class FeedPost {
  final String id;
  final String username;
  final String userAvatar;
  final String description;
  final String venue;
  final String hashtags;
  final String timeAgo;
  final int likes;
  final int comments;
  final int shares;
  final String videoUrl;
  final bool isFollowing;

  FeedPost({
    required this.id,
    required this.username,
    required this.userAvatar,
    required this.description,
    required this.venue,
    required this.hashtags,
    required this.timeAgo,
    required this.likes,
    required this.comments,
    required this.shares,
    required this.videoUrl,
    this.isFollowing = false,
  });
}
