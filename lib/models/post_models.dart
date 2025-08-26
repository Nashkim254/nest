import 'package:json_annotation/json_annotation.dart';

part 'post_models.g.dart';

@JsonSerializable()
class UserPreview {
  @JsonKey(defaultValue: 0)
  final int id;
  @JsonKey(name: 'display_name', defaultValue: '')
  final String displayName;
  @JsonKey(name: 'profile_picture')
  final String? profilePicture;
  @JsonKey(name: 'is_verified', defaultValue: false)
  final bool isVerified;

  const UserPreview({
    this.id = 0,
    this.displayName = '',
    this.profilePicture,
    this.isVerified = false,
  });

  factory UserPreview.fromJson(Map<String, dynamic> json) =>
      _$UserPreviewFromJson(json);

  Map<String, dynamic> toJson() => _$UserPreviewToJson(this);
}

@JsonSerializable()
class Post {
  @JsonKey(defaultValue: 0, name: 'ID')
  final int id;
  @JsonKey(defaultValue: '')
  final String content;
  @JsonKey(name: 'image_urls', defaultValue: <String>[])
  final List<String> imageUrls;
  @JsonKey(defaultValue: <String>[])
  final List<String> hashtags;
  @JsonKey(name: 'is_private', defaultValue: false)
  final bool isPrivate;
  final String? location;
  @JsonKey(
      name: 'created_at', fromJson: _dateTimeFromJson, toJson: _dateTimeToJson)
  final DateTime? createdAt;
  @JsonKey(
      name: 'updated_at', fromJson: _dateTimeFromJson, toJson: _dateTimeToJson)
  final DateTime? updatedAt;
  @JsonKey(name: 'like_count', defaultValue: 0)
  final int likeCount;
  @JsonKey(name: 'comment_count', defaultValue: 0)
  final int commentCount;
  @JsonKey(name: 'share_count', defaultValue: 0)
  final int shareCount;
  @JsonKey(name: 'view_count', defaultValue: 0)
  final int viewCount;
  @JsonKey(name: 'media_id')
  final String? mediaId;
  @JsonKey(name: 'video_url')
  final String? videoUrl;
  @JsonKey(name: 'video_thumbnail')
  final String? videoThumbnail;
  @JsonKey(name: 'video_ready', defaultValue: false)
  final bool videoReady;
  @JsonKey(fromJson: _userPreviewFromJson, toJson: _userPreviewToJson)
  final UserPreview? user;
  @JsonKey(name: 'is_liked', defaultValue: false)
  final bool isLiked;

  const Post({
    this.id = 0,
    this.content = '',
    this.imageUrls = const <String>[],
    this.hashtags = const <String>[],
    this.isPrivate = false,
    this.location,
    this.createdAt,
    this.updatedAt,
    this.likeCount = 0,
    this.commentCount = 0,
    this.shareCount = 0,
    this.viewCount = 0,
    this.mediaId,
    this.videoUrl,
    this.videoThumbnail,
    this.videoReady = false,
    this.user,
    this.isLiked = false,
  });

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  Map<String, dynamic> toJson() => _$PostToJson(this);

  // Custom serialization helpers for safe null handling
  static DateTime? _dateTimeFromJson(dynamic value) {
    if (value == null) return null;
    if (value is String) {
      return DateTime.tryParse(value);
    }
    return null;
  }

  static String? _dateTimeToJson(DateTime? dateTime) {
    return dateTime?.toIso8601String();
  }

  static UserPreview? _userPreviewFromJson(dynamic value) {
    if (value == null) return null;
    if (value is Map<String, dynamic>) {
      try {
        return UserPreview.fromJson(value);
      } catch (e) {
        return null;
      }
    }
    return null;
  }

  static Map<String, dynamic>? _userPreviewToJson(UserPreview? user) {
    return user?.toJson();
  }

  // Convenience getters with null safety
  bool get hasImages => imageUrls.isNotEmpty;
  bool get hasVideo => videoUrl != null && videoUrl!.isNotEmpty;
  bool get hasMedia => hasImages || hasVideo;
  bool get hasLocation => location != null && location!.isNotEmpty;
  bool get hasHashtags => hashtags.isNotEmpty;
  bool get hasUser => user != null;
  bool get hasValidDates => createdAt != null && updatedAt != null;

  // Helper methods for UI with safe fallbacks
  String get formattedLikeCount => _formatCount(likeCount);
  String get formattedCommentCount => _formatCount(commentCount);
  String get formattedShareCount => _formatCount(shareCount);
  String get formattedViewCount => _formatCount(viewCount);
  String get safeDisplayName => user?.displayName ?? 'Unknown User';
  DateTime get safeCreatedAt => createdAt ?? DateTime.now();
  DateTime get safeUpdatedAt => updatedAt ?? DateTime.now();

  static String _formatCount(int count) {
    if (count >= 1000000) {
      return '${(count / 1000000).toStringAsFixed(1)}M';
    } else if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(1)}K';
    }
    return count.toString();
  }

  // Create a copy with updated values (useful for state management)
  Post copyWith({
    int? id,
    String? content,
    List<String>? imageUrls,
    List<String>? hashtags,
    bool? isPrivate,
    String? location,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? likeCount,
    int? commentCount,
    int? shareCount,
    int? viewCount,
    String? mediaId,
    String? videoUrl,
    String? videoThumbnail,
    bool? videoReady,
    UserPreview? user,
    bool? isLiked,
  }) {
    return Post(
      id: id ?? this.id,
      content: content ?? this.content,
      imageUrls: imageUrls ?? this.imageUrls,
      hashtags: hashtags ?? this.hashtags,
      isPrivate: isPrivate ?? this.isPrivate,
      location: location ?? this.location,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      likeCount: likeCount ?? this.likeCount,
      commentCount: commentCount ?? this.commentCount,
      shareCount: shareCount ?? this.shareCount,
      viewCount: viewCount ?? this.viewCount,
      mediaId: mediaId ?? this.mediaId,
      videoUrl: videoUrl ?? this.videoUrl,
      videoThumbnail: videoThumbnail ?? this.videoThumbnail,
      videoReady: videoReady ?? this.videoReady,
      user: user ?? this.user,
      isLiked: isLiked ?? this.isLiked,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Post && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;

  // Validation method to check if the post has minimum required data
  bool get isValid =>
      id > 0 &&
      content.isNotEmpty &&
      user != null &&
      user!.id > 0 &&
      user!.displayName.isNotEmpty;
}
