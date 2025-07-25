class EventActivity {
  final String userName;
  final String userProfileImageUrl;
  final String timeAgo;
  final bool isEditable;

  final String eventImageUrl;
  final String captionTitle;
  final String captionDescription;
  final List<String> hashtags;

  final String likedByUser;
  final int likeCount;

  EventActivity({
    required this.userName,
    required this.userProfileImageUrl,
    required this.timeAgo,
    required this.isEditable,
    required this.eventImageUrl,
    required this.captionTitle,
    required this.captionDescription,
    required this.hashtags,
    required this.likedByUser,
    required this.likeCount,
  });
  factory EventActivity.fromJson(Map<String, dynamic> json) {
    return EventActivity(
      userName: json['user_name'],
      userProfileImageUrl: json['user_profile_image_url'],
      timeAgo: json['time_ago'],
      isEditable: json['is_editable'],
      eventImageUrl: json['event_image_url'],
      captionTitle: json['caption_title'],
      captionDescription: json['caption_description'],
      hashtags: List<String>.from(json['hashtags']),
      likedByUser: json['liked_by_user'],
      likeCount: json['like_count'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_name': userName,
      'user_profile_image_url': userProfileImageUrl,
      'time_ago': timeAgo,
      'is_editable': isEditable,
      'event_image_url': eventImageUrl,
      'caption_title': captionTitle,
      'caption_description': captionDescription,
      'hashtags': hashtags,
      'liked_by_user': likedByUser,
      'like_count': likeCount,
    };
  }
}
