// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserPreview _$UserPreviewFromJson(Map<String, dynamic> json) => UserPreview(
      id: (json['id'] as num?)?.toInt() ?? 0,
      displayName: json['display_name'] as String? ?? '',
      profilePicture: json['profile_picture'] as String?,
      isVerified: json['is_verified'] as bool? ?? false,
    );

Map<String, dynamic> _$UserPreviewToJson(UserPreview instance) =>
    <String, dynamic>{
      'id': instance.id,
      'display_name': instance.displayName,
      'profile_picture': instance.profilePicture,
      'is_verified': instance.isVerified,
    };

Post _$PostFromJson(Map<String, dynamic> json) => Post(
      id: (json['ID'] as num?)?.toInt() ?? 0,
      content: json['content'] as String? ?? '',
      imageUrls: (json['image_urls'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      hashtags: (json['hashtags'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          [],
      isPrivate: json['is_private'] as bool? ?? false,
      location: json['location'] as String?,
      createdAt: Post._dateTimeFromJson(json['created_at']),
      updatedAt: Post._dateTimeFromJson(json['updated_at']),
      likeCount: (json['like_count'] as num?)?.toInt() ?? 0,
      commentCount: (json['comment_count'] as num?)?.toInt() ?? 0,
      shareCount: (json['share_count'] as num?)?.toInt() ?? 0,
      viewCount: (json['view_count'] as num?)?.toInt() ?? 0,
      mediaId: json['media_id'] as String?,
      videoUrl: json['video_url'] as String?,
      videoThumbnail: json['video_thumbnail'] as String?,
      videoReady: json['video_ready'] as bool? ?? false,
      user: Post._userPreviewFromJson(json['user']),
      isLiked: json['is_liked'] as bool? ?? false,
    );

Map<String, dynamic> _$PostToJson(Post instance) => <String, dynamic>{
      'ID': instance.id,
      'content': instance.content,
      'image_urls': instance.imageUrls,
      'hashtags': instance.hashtags,
      'is_private': instance.isPrivate,
      'location': instance.location,
      'created_at': Post._dateTimeToJson(instance.createdAt),
      'updated_at': Post._dateTimeToJson(instance.updatedAt),
      'like_count': instance.likeCount,
      'comment_count': instance.commentCount,
      'share_count': instance.shareCount,
      'view_count': instance.viewCount,
      'media_id': instance.mediaId,
      'video_url': instance.videoUrl,
      'video_thumbnail': instance.videoThumbnail,
      'video_ready': instance.videoReady,
      'user': Post._userPreviewToJson(instance.user),
      'is_liked': instance.isLiked,
    };
