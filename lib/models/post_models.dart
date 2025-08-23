import 'package:json_annotation/json_annotation.dart';

part 'post_models.g.dart';

@JsonSerializable()
class UserPreview {
  final int id;
  @JsonKey(name: 'display_name')
  final String displayName;
  @JsonKey(name: 'profile_picture')
  final String? profilePicture;
  @JsonKey(name: 'is_verified')
  final bool isVerified;

  const UserPreview({
    required this.id,
    required this.displayName,
    this.profilePicture,
    required this.isVerified,
  });

  factory UserPreview.fromJson(Map<String, dynamic> json) =>
      _$UserPreviewFromJson(json);

  Map<String, dynamic> toJson() => _$UserPreviewToJson(this);
}

@JsonSerializable()
class Post {
  final int id;
  final String content;
  @JsonKey(name: 'image_urls')
  final List<String> imageUrls;
  final List<String> hashtags;
  @JsonKey(name: 'is_private')
  final bool isPrivate;
  final String? location;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;
  @JsonKey(name: 'like_count')
  final int likeCount;
  @JsonKey(name: 'comment_count')
  final int commentCount;
  @JsonKey(name: 'share_count')
  final int shareCount;
  @JsonKey(name: 'view_count')
  final int viewCount;
  @JsonKey(name: 'media_id')
  final String? mediaId;
  @JsonKey(name: 'video_url')
  final String? videoUrl;
  @JsonKey(name: 'video_thumbnail')
  final String? videoThumbnail;
  @JsonKey(name: 'video_ready')
  final bool videoReady;
  final UserPreview user;
  @JsonKey(name: 'is_liked')
  final bool isLiked;

  const Post({
    required this.id,
    required this.content,
    required this.imageUrls,
    required this.hashtags,
    required this.isPrivate,
    this.location,
    required this.createdAt,
    required this.updatedAt,
    required this.likeCount,
    required this.commentCount,
    required this.shareCount,
    required this.viewCount,
    this.mediaId,
    this.videoUrl,
    this.videoThumbnail,
    required this.videoReady,
    required this.user,
    required this.isLiked,
  });

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);

  Map<String, dynamic> toJson() => _$PostToJson(this);

  // Convenience getters
  bool get hasImages => imageUrls.isNotEmpty;
  bool get hasVideo => videoUrl != null && videoUrl!.isNotEmpty;
  bool get hasMedia => hasImages || hasVideo;
  bool get hasLocation => location != null && location!.isNotEmpty;
  bool get hasHashtags => hashtags.isNotEmpty;

  // Helper methods for UI
  String get formattedLikeCount => _formatCount(likeCount);
  String get formattedCommentCount => _formatCount(commentCount);
  String get formattedShareCount => _formatCount(shareCount);
  String get formattedViewCount => _formatCount(viewCount);

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
}
