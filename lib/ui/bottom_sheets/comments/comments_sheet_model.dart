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
  final _snackbarService = locator<SnackbarService>();

  final TextEditingController commentController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  Logger logger = Logger();

  List<Comment> _comments = [];
  List<Comment> get comments => _comments;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isLoadingMore = false;
  bool get isLoadingMore => _isLoadingMore;

  bool _hasMoreComments = true;
  bool get hasMoreComments => _hasMoreComments;

  bool _canSendComment = false;
  bool get canSendComment => _canSendComment;

  bool _isSendingComment = false;
  bool get isSendingComment => _isSendingComment;

  int? _postId;
  int _page = 1;
  final int _pageSize = 20;

  @override
  void dispose() {
    commentController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  Future<void> initialize(int postId) async {
    logger.wtf(postId);
    logger.wtf(postId.runtimeType);
    _postId = postId;
    await _loadComments(isInitial: true);
    _setupScrollListener();
  }

  void _setupScrollListener() {
    scrollController.addListener(() {
      // Auto-load more comments when near the bottom
      if (scrollController.position.pixels >=
              scrollController.position.maxScrollExtent * 0.8 &&
          !_isLoadingMore &&
          _hasMoreComments &&
          !_isLoading) {
        _loadMoreComments();
      }
    });
  }

  Future<void> _loadComments(
      {bool isInitial = false, bool isRefresh = false}) async {
    if (_postId == null) return;

    if (isInitial || isRefresh) {
      _setLoading(true);
      _page = 1;
      _hasMoreComments = true;
      if (isRefresh) _comments.clear();
    }

    try {
      final response = await _commentsService.getComments(
        _postId!,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        if (kDebugMode) {
          debugPrint("Loaded comments: ${response.data}", wrapWidth: 1024);
        }

        final List<dynamic> data = response.data['comments'] ?? [];
        final newComments = data.map((json) => Comment.fromJson(json)).toList();

        if (isInitial || isRefresh) {
          _comments = newComments;
        } else {
          _comments.addAll(newComments);
        }

        // Check if there are more comments
        _hasMoreComments = newComments.length == _pageSize;

        logger.i(
            "Loaded ${newComments.length} comments, total: ${_comments.length}");
      } else {
        throw Exception(response.message ?? 'Failed to load comments');
      }
    } catch (error) {
      logger.e('Error loading comments: $error');
      if (isInitial) {
        setError(error);
      } else {
        _showErrorMessage('Failed to load comments');
      }
    } finally {
      if (isInitial || isRefresh) {
        _setLoading(false);
      }
    }
  }

  Future<void> _loadMoreComments() async {
    if (_postId == null || _isLoadingMore || !_hasMoreComments) return;

    _setLoadingMore(true);
    _page++;

    try {
      final response = await _commentsService.getComments(
        _postId!,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final List<dynamic> data = response.data['comments'] ?? [];
        final newComments = data.map((json) => Comment.fromJson(json)).toList();

        _comments.addAll(newComments);
        _hasMoreComments = newComments.length == _pageSize;

        logger.i("Loaded ${newComments.length} more comments");
      } else {
        _page--; // Revert page increment on failure
        throw Exception('Failed to load more comments');
      }
    } catch (error) {
      _page--; // Revert page increment on error
      logger.e('Error loading more comments: $error');
      _showErrorMessage('Failed to load more comments');
    } finally {
      _setLoadingMore(false);
    }
  }

  void onCommentTextChanged() {
    final hasText = commentController.text.trim().isNotEmpty;
    if (_canSendComment != hasText) {
      _canSendComment = hasText;
      notifyListeners();
    }
  }

  Future<void> sendComment() async {
    if (!_canSendComment || _postId == null || _isSendingComment) return;

    final commentText = commentController.text.trim();
    if (commentText.isEmpty) return;

    _setSendingComment(true);

    try {
      // Clear input immediately for better UX
      commentController.clear();
      _canSendComment = false;
      notifyListeners();

      // Send comment
      final response =
          await _commentsService.postComment(_postId!, commentText);

      if (response.statusCode == 200 || response.statusCode == 201) {
        logger.w(response.data);
        final newComment = Comment.fromJson(response.data);

        // Add to local list at the beginning (newest first)
        _comments.insert(0, newComment);
        notifyListeners();

        // Scroll to top to show new comment
        if (scrollController.hasClients) {
          scrollController.animateTo(
            0,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }

        logger.i('Comment posted successfully');
      } else {
        throw Exception(response.message ?? 'Failed to post comment');
      }
    } catch (error, s) {
      logger.e('Error posting comment: $s');

      // Restore comment text on error
      commentController.text = commentText;
      _canSendComment = true;
      notifyListeners();

      _showErrorMessage('Failed to post comment. Please try again.');
    } finally {
      _setSendingComment(false);
    }
  }

  Future<void> toggleLikeComment(int commentId) async {
    try {
      // Optimistically update UI
      final commentIndex = _comments.indexWhere((c) => c.id == commentId);
      if (commentIndex != -1) {
        final currentComment = _comments[commentIndex];
        _comments[commentIndex] = currentComment.copyWith(
          isLiked: !currentComment.isLiked,
          likeCount: currentComment.isLiked
              ? currentComment.likeCount - 1
              : currentComment.likeCount + 1,
        );
        notifyListeners();
      }

      // Send request to server
      final response = await _commentsService.toggleLikeComment(commentId);

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception('Failed to toggle like');
      }

      logger.i('Comment like toggled successfully');
    } catch (error) {
      logger.e('Error toggling comment like: $error');

      // Revert optimistic update on error
      final commentIndex = _comments.indexWhere((c) => c.id == commentId);
      if (commentIndex != -1) {
        final currentComment = _comments[commentIndex];
        _comments[commentIndex] = currentComment.copyWith(
          isLiked: !currentComment.isLiked,
          likeCount: currentComment.isLiked
              ? currentComment.likeCount - 1
              : currentComment.likeCount + 1,
        );
        notifyListeners();
      }

      _showErrorMessage('Failed to update like');
    }
  }

  Future<void> refreshComments() async {
    await _loadComments(isRefresh: true);
  }

  void closeBottomSheet() {
    _bottomSheetService.completeSheet(SheetResponse(confirmed: true));
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setLoadingMore(bool loading) {
    _isLoadingMore = loading;
    notifyListeners();
  }

  void _setSendingComment(bool sending) {
    _isSendingComment = sending;
    notifyListeners();
  }

  void _showErrorMessage(String message) {
    _snackbarService.showSnackbar(
      message: message,
      duration: const Duration(seconds: 3),
    );
  }

  // Method to update a specific comment (useful for real-time updates)
  void updateComment(Comment updatedComment) {
    final index = _comments.indexWhere((c) => c.id == updatedComment.id);
    if (index != -1) {
      _comments[index] = updatedComment;
      notifyListeners();
    }
  }

  // Method to delete a comment
  // Future<void> deleteComment(int commentId) async {
  //   try {
  //     final response = await _commentsService.deleteComment(commentId);

  //     if (response.statusCode == 200 || response.statusCode == 204) {
  //       _comments.removeWhere((c) => c.id == commentId);
  //       notifyListeners();
  //       logger.i('Comment deleted successfully');
  //     } else {
  //       throw Exception('Failed to delete comment');
  //     }
  //   } catch (error) {
  //     logger.e('Error deleting comment: $error');
  //     _showErrorMessage('Failed to delete comment');
  //   }
  // }
}
