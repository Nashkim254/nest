class Comment {
  final String id;
  final String username;
  final String userAvatar;
  final String content;
  final String timeAgo;
  final bool isLiked;
  final int likes;

  Comment({
    required this.id,
    required this.username,
    required this.userAvatar,
    required this.content,
    required this.timeAgo,
    this.isLiked = false,
    this.likes = 0,
  });
}
