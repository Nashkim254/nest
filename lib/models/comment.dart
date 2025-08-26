// Updated Comment model to match your API structure
// File: models/comment.dart

import 'package:json_annotation/json_annotation.dart';

part 'comment.g.dart';

@JsonSerializable()
class Comment {
  final int id;
  final String content;
  @JsonKey(name: 'created_at')
  final String? createdAt;
  @JsonKey(name: 'updated_at')
  final String? updatedAt;
  @JsonKey(name: 'like_count')
  final int likeCount;
  @JsonKey(name: 'is_liked')
  final bool isLiked;
  final CommentUser? user;

  // Computed properties for UI
  String get username => user?.displayName ?? 'Unknown User';
  String get userAvatar => user?.profilePicture ?? '';
  String get timeAgo => _formatTimeAgo(createdAt);

  Comment({
    required this.id,
    required this.content,
    this.createdAt,
    this.updatedAt,
    this.likeCount = 0,
    this.isLiked = false,
    this.user,
  });

  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);
  Map<String, dynamic> toJson() => _$CommentToJson(this);

  Comment copyWith({
    int? id,
    String? content,
    String? createdAt,
    String? updatedAt,
    int? likeCount,
    bool? isLiked,
    CommentUser? user,
  }) {
    return Comment(
      id: id ?? this.id,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      likeCount: likeCount ?? this.likeCount,
      isLiked: isLiked ?? this.isLiked,
      user: user ?? this.user,
    );
  }

  String _formatTimeAgo(String? dateTimeString) {
    if (dateTimeString == null) return 'just now';

    try {
      final dateTime = DateTime.parse(dateTimeString);
      final now = DateTime.now();
      final difference = now.difference(dateTime);

      if (difference.inMinutes < 1) {
        return 'just now';
      } else if (difference.inHours < 1) {
        return '${difference.inMinutes}m ago';
      } else if (difference.inDays < 1) {
        return '${difference.inHours}h ago';
      } else if (difference.inDays < 7) {
        return '${difference.inDays}d ago';
      } else {
        return '${(difference.inDays / 7).floor()}w ago';
      }
    } catch (e) {
      return 'just now';
    }
  }
}

@JsonSerializable()
class CommentUser {
  final int id;
  @JsonKey(name: 'display_name')
  final String displayName;
  @JsonKey(name: 'profile_picture')
  final String? profilePicture;
  @JsonKey(name: 'is_verified')
  final bool isVerified;

  CommentUser({
    required this.id,
    required this.displayName,
    this.profilePicture,
    this.isVerified = false,
  });

  factory CommentUser.fromJson(Map<String, dynamic> json) =>
      _$CommentUserFromJson(json);
  Map<String, dynamic> toJson() => _$CommentUserToJson(this);
}

// Alternative constructor for backward compatibility if needed
extension CommentExtension on Comment {
  static Comment legacy({
    required int id,
    required String content,
    required String username,
    required String userAvatar,
    required String timeAgo,
    required bool isLiked,
    required int likeCount,
    DateTime? createdAt,
  }) {
    return Comment(
      id: id,
      content: content,
      createdAt: createdAt?.toIso8601String(),
      likeCount: likeCount,
      isLiked: isLiked,
      user: CommentUser(
        id: 0, // Default ID
        displayName: username,
        profilePicture: userAvatar,
      ),
    );
  }
}
