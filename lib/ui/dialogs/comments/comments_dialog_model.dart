import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../../models/comments.dart';

class CommentsDialogModel extends BaseViewModel {
  final TextEditingController _commentController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  String _postId = '';
  List<Comment> _comments = [];
  bool _isLoading = false;

  TextEditingController get commentController => _commentController;
  ScrollController get scrollController => _scrollController;
  List<Comment> get comments => _comments;
  bool get isLoading => _isLoading;
  bool get canSendComment => _commentController.text.trim().isNotEmpty;

  void initialize(String postId) {
    _postId = postId;
    _loadComments();
  }

  void _loadComments() {
    _isLoading = true;
    notifyListeners();

    // Mock comments data
    _comments = [
      Comment(
        id: '1',
        username: 'Alex M.',
        userAvatar: 'assets/images/alex_m.jpg',
        content: 'This looks like an epic night! Wish I was there. 🎵',
        timeAgo: '1 hour ago',
        isLiked: true,
        likes: 12,
      ),
      Comment(
        id: '2',
        username: 'PartyGoer',
        userAvatar: 'assets/images/partygoer.jpg',
        content: 'The music was insane! Best party in months.',
        timeAgo: '30 minutes ago',
        isLiked: true,
        likes: 8,
      ),
      Comment(
        id: '3',
        username: 'EventLover',
        userAvatar: 'assets/images/eventlover.jpg',
        content: 'Definitely adding this to my must-attend list next time!',
        timeAgo: '15 minutes ago',
        likes: 3,
      ),
    ];

    _isLoading = false;
    notifyListeners();
  }

  void onCommentTextChanged() {
    notifyListeners();
  }

  void toggleLikeComment(String commentId) {
    final commentIndex = _comments.indexWhere((c) => c.id == commentId);
    if (commentIndex != -1) {
      final comment = _comments[commentIndex];
      _comments[commentIndex] = Comment(
        id: comment.id,
        username: comment.username,
        userAvatar: comment.userAvatar,
        content: comment.content,
        timeAgo: comment.timeAgo,
        isLiked: !comment.isLiked,
        likes: comment.isLiked ? comment.likes - 1 : comment.likes + 1,
      );
      notifyListeners();
    }
  }

  void sendComment() {
    if (!canSendComment) return;

    final newComment = Comment(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      username: 'You',
      userAvatar: 'assets/images/your_avatar.jpg',
      content: _commentController.text.trim(),
      timeAgo: 'just now',
    );

    _comments.insert(0, newComment);
    _commentController.clear();
    notifyListeners();

    // Scroll to top to show new comment
    _scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  void dispose() {
    _commentController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
}
