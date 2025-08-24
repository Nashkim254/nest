import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../models/comment.dart';
import '../../../services/comments_service.dart';

class CommentsSheetModel extends BaseViewModel {
  final _bottomSheetService = locator<BottomSheetService>();
  final _commentsService = locator<CommentsService>();

  final TextEditingController commentController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  Logger logger = Logger();
  List<Comment> _comments = [];
  List<Comment> get comments => _comments;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _canSendComment = false;
  bool get canSendComment => _canSendComment;

  int? _postId;

  @override
  void dispose() {
    commentController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  Future<void> initialize(int postId) async {
    _postId = postId;
    await _loadComments();
    _setupScrollListener();
  }

  void _setupScrollListener() {
    scrollController.addListener(() {
      // Auto-load more comments when near the bottom
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent * 0.8) {
        _loadMoreComments();
      }
    });
  }

  Future<void> _loadComments() async {
    if (_postId == null) return;

    _setLoading(true);
    try {
      final response = await _commentsService.getComments(_postId!);
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (kDebugMode) {
          debugPrint("Loaded ${response.data}", wrapWidth: 1024);
        }

        final List<dynamic> data = response.data['comments'] ?? [];
        _comments = data.map((json) => Comment.fromJson(json)).toList();
        logger.i("Loaded ${_comments.length} comments");
      } else {
        throw Exception('Failed to load comments');
      }
      rebuildUi();
    } catch (error) {
      // Handle error - could show snackbar or error state
      setError(error);
    } finally {
      _setLoading(false);
    }
  }

  Future<void> _loadMoreComments() async {
    if (_postId == null || _isLoading) return;

    try {
      final moreComments = await _commentsService.getMoreComments(
        _postId!,
        offset: _comments.length,
      );

      if (moreComments.isNotEmpty) {
        _comments.addAll(moreComments);
        rebuildUi();
      }
    } catch (error) {
      // Handle pagination error silently or show toast
    }
  }

  void onCommentTextChanged() {
    final hasText = commentController.text.trim().isNotEmpty;
    if (_canSendComment != hasText) {
      _canSendComment = hasText;
      rebuildUi();
    }
  }

  Future<void> sendComment() async {
    if (!_canSendComment || _postId == null) return;

    final commentText = commentController.text.trim();
    if (commentText.isEmpty) return;

    try {
      // Clear input immediately for better UX
      commentController.clear();
      _canSendComment = false;
      rebuildUi();

      // Send comment
      final newComment =
          await _commentsService.postComment(_postId!, commentText);

      // Add to local list
      _comments.insert(0, newComment);
      rebuildUi();

      // Scroll to top to show new comment
      if (scrollController.hasClients) {
        scrollController.animateTo(
          0,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    } catch (error) {
      // Restore comment text on error
      commentController.text = commentText;
      _canSendComment = true;
      rebuildUi();

      // Show error to user
      setError(error);
    }
  }

  Future<void> toggleLikeComment(int commentId) async {
    try {
      // Optimistically update UI
      final commentIndex = _comments.indexWhere((c) => c.id == commentId);
      if (commentIndex != -1) {
        _comments[commentIndex] = _comments[commentIndex].copyWith(
          isLiked: !_comments[commentIndex].isLiked,
          likeCount: _comments[commentIndex].isLiked
              ? _comments[commentIndex].likeCount - 1
              : _comments[commentIndex].likeCount + 1,
        );
        rebuildUi();
      }

      // Send request to server
      await _commentsService.toggleLikeComment(commentId);
    } catch (error) {
      // Revert optimistic update on error
      final commentIndex = _comments.indexWhere((c) => c.id == commentId);
      if (commentIndex != -1) {
        _comments[commentIndex] = _comments[commentIndex].copyWith(
          isLiked: !_comments[commentIndex].isLiked,
          likeCount: _comments[commentIndex].isLiked
              ? _comments[commentIndex].likeCount - 1
              : _comments[commentIndex].likeCount + 1,
        );
        rebuildUi();
      }

      // Could show error toast here
      setError(error);
    }
  }

  Future<void> refreshComments() async {
    await _loadComments();
  }

  void closeBottomSheet() {
    _bottomSheetService.completeSheet(SheetResponse());
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    rebuildUi();
  }
}
