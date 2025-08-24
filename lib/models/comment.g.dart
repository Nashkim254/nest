// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'comment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Comment _$CommentFromJson(Map<String, dynamic> json) => Comment(
      id: (json['id'] as num).toInt(),
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      deletedAt: json['deleted_at'] == null
          ? null
          : DateTime.parse(json['deleted_at'] as String),
      postId: (json['post_id'] as num).toInt(),
      userId: (json['user_id'] as num).toInt(),
      content: json['content'] as String,
      parentId: (json['parent_id'] as num?)?.toInt(),
      likeCount: (json['like_count'] as num?)?.toInt() ?? 0,
      post: json['post'] == null
          ? null
          : Post.fromJson(json['post'] as Map<String, dynamic>),
      user: User.fromJson(json['user'] as Map<String, dynamic>),
      parent: json['parent'] == null
          ? null
          : Comment.fromJson(json['parent'] as Map<String, dynamic>),
      replies: (json['replies'] as List<dynamic>?)
              ?.map((e) => Comment.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      likes: (json['likes'] as List<dynamic>?)
              ?.map((e) => CommentLike.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$CommentToJson(Comment instance) => <String, dynamic>{
      'id': instance.id,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'deleted_at': instance.deletedAt?.toIso8601String(),
      'post_id': instance.postId,
      'user_id': instance.userId,
      'content': instance.content,
      'parent_id': instance.parentId,
      'like_count': instance.likeCount,
      'post': instance.post,
      'user': instance.user,
      'parent': instance.parent,
      'replies': instance.replies,
      'likes': instance.likes,
    };

CommentLike _$CommentLikeFromJson(Map<String, dynamic> json) => CommentLike(
      id: (json['id'] as num).toInt(),
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      deletedAt: json['deleted_at'] == null
          ? null
          : DateTime.parse(json['deleted_at'] as String),
      commentId: (json['comment_id'] as num).toInt(),
      userId: (json['user_id'] as num).toInt(),
      comment: json['comment'] == null
          ? null
          : Comment.fromJson(json['comment'] as Map<String, dynamic>),
      user: User.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CommentLikeToJson(CommentLike instance) =>
    <String, dynamic>{
      'id': instance.id,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'deleted_at': instance.deletedAt?.toIso8601String(),
      'comment_id': instance.commentId,
      'user_id': instance.userId,
      'comment': instance.comment,
      'user': instance.user,
    };

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: (json['id'] as num).toInt(),
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
      deletedAt: json['deleted_at'] == null
          ? null
          : DateTime.parse(json['deleted_at'] as String),
      username: json['username'] as String,
      displayName: json['display_name'] as String?,
      profilePicture: json['profile_picture'] as String?,
      bio: json['bio'] as String?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt.toIso8601String(),
      'deleted_at': instance.deletedAt?.toIso8601String(),
      'username': instance.username,
      'display_name': instance.displayName,
      'profile_picture': instance.profilePicture,
      'bio': instance.bio,
    };

CommentsResponse _$CommentsResponseFromJson(Map<String, dynamic> json) =>
    CommentsResponse(
      comments: (json['comments'] as List<dynamic>)
          .map((e) => Comment.fromJson(e as Map<String, dynamic>))
          .toList(),
      total: (json['total'] as num).toInt(),
      hasMore: json['has_more'] as bool,
      nextCursor: json['next_cursor'] as String?,
    );

Map<String, dynamic> _$CommentsResponseToJson(CommentsResponse instance) =>
    <String, dynamic>{
      'comments': instance.comments,
      'total': instance.total,
      'has_more': instance.hasMore,
      'next_cursor': instance.nextCursor,
    };
