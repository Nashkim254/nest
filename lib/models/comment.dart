import 'package:json_annotation/json_annotation.dart';
import 'package:nest/models/post_models.dart';
part 'comment.g.dart';

@JsonSerializable()
class Comment {
  final int id;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;
  @JsonKey(name: 'deleted_at')
  final DateTime? deletedAt;
  @JsonKey(name: 'post_id')
  final int postId;
  @JsonKey(name: 'user_id')
  final int userId;
  final String content;
  @JsonKey(name: 'parent_id')
  final int? parentId;
  @JsonKey(name: 'like_count')
  final int likeCount;

  // Relationships - import your existing Post and User models
  final Post? post;
  final User user;
  final Comment? parent;
  final List<Comment> replies;
  final List<CommentLike> likes;

  // UI-specific fields (not from API)
  @JsonKey(includeFromJson: false, includeToJson: false)
  final bool isLiked;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final bool isExpanded;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final bool showReplies;

  const Comment({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.postId,
    required this.userId,
    required this.content,
    this.parentId,
    this.likeCount = 0,
    this.post,
    required this.user,
    this.parent,
    this.replies = const [],
    this.likes = const [],
    this.isLiked = false,
    this.isExpanded = false,
    this.showReplies = true,
  });

  factory Comment.fromJson(Map<String, dynamic> json) =>
      _$CommentFromJson(json);
  Map<String, dynamic> toJson() => _$CommentToJson(this);

  // Helper getters
  String get timeAgo {
    final now = DateTime.now();
    final difference = now.difference(createdAt);

    if (difference.inDays > 365) {
      return '${(difference.inDays / 365).floor()}y ago';
    } else if (difference.inDays > 30) {
      return '${(difference.inDays / 30).floor()}mo ago';
    } else if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'now';
    }
  }

  String get username => user.username;
  String get userAvatar =>
      user.profilePicture ?? 'assets/images/default_avatar.png';
  String get userDisplayName => user.displayName ?? user.username;

  bool get hasReplies => replies.isNotEmpty;
  int get replyCount => replies.length;
  bool get isTopLevel => parentId == null;
  bool get isReply => parentId != null;

  String get formattedLikeCount {
    if (likeCount >= 1000000) {
      return '${(likeCount / 1000000).toStringAsFixed(1)}M';
    } else if (likeCount >= 1000) {
      return '${(likeCount / 1000).toStringAsFixed(1)}K';
    } else {
      return likeCount.toString();
    }
  }

  // Copy with method for state updates
  Comment copyWith({
    int? id,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    int? postId,
    int? userId,
    String? content,
    int? parentId,
    int? likeCount,
    Post? post,
    User? user,
    Comment? parent,
    List<Comment>? replies,
    List<CommentLike>? likes,
    bool? isLiked,
    bool? isExpanded,
    bool? showReplies,
  }) {
    return Comment(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      postId: postId ?? this.postId,
      userId: userId ?? this.userId,
      content: content ?? this.content,
      parentId: parentId ?? this.parentId,
      likeCount: likeCount ?? this.likeCount,
      post: post ?? this.post,
      user: user ?? this.user,
      parent: parent ?? this.parent,
      replies: replies ?? this.replies,
      likes: likes ?? this.likes,
      isLiked: isLiked ?? this.isLiked,
      isExpanded: isExpanded ?? this.isExpanded,
      showReplies: showReplies ?? this.showReplies,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Comment && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'Comment(id: $id, content: $content, user: ${user.username}, likeCount: $likeCount)';
  }
}

@JsonSerializable()
class CommentLike {
  final int id;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;
  @JsonKey(name: 'deleted_at')
  final DateTime? deletedAt;
  @JsonKey(name: 'comment_id')
  final int commentId;
  @JsonKey(name: 'user_id')
  final int userId;

  // Relationships
  final Comment? comment;
  final User user;

  const CommentLike({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.commentId,
    required this.userId,
    this.comment,
    required this.user,
  });

  factory CommentLike.fromJson(Map<String, dynamic> json) =>
      _$CommentLikeFromJson(json);
  Map<String, dynamic> toJson() => _$CommentLikeToJson(this);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CommentLike && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}

// Remove this User class if you already have a User model
// Import your existing User model instead
@JsonSerializable()
class User {
  final int id;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime updatedAt;
  @JsonKey(name: 'deleted_at')
  final DateTime? deletedAt;
  final String username;
  @JsonKey(name: 'display_name')
  final String? displayName;
  @JsonKey(name: 'profile_picture')
  final String? profilePicture;
  final String? bio;

  const User({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.username,
    this.displayName,
    this.profilePicture,
    this.bio,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is User && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}

// Extension for comment operations
extension CommentOperations on Comment {
  // Get all nested replies recursively
  List<Comment> get allReplies {
    final List<Comment> allReplies = [];

    void collectReplies(List<Comment> replies) {
      for (final reply in replies) {
        allReplies.add(reply);
        if (reply.hasReplies) {
          collectReplies(reply.replies);
        }
      }
    }

    collectReplies(replies);
    return allReplies;
  }

  // Get total reply count including nested
  int get totalReplyCount {
    int count = replies.length;
    for (final reply in replies) {
      count += reply.totalReplyCount;
    }
    return count;
  }

  // Find a reply by ID in the nested structure
  Comment? findReply(int replyId) {
    for (final reply in replies) {
      if (reply.id == replyId) return reply;
      final found = reply.findReply(replyId);
      if (found != null) return found;
    }
    return null;
  }

  // Add a reply to the appropriate parent
  Comment addReply(Comment newReply) {
    if (newReply.parentId == id) {
      // Direct reply to this comment
      return copyWith(replies: [...replies, newReply]);
    } else {
      // Reply to a nested comment
      final updatedReplies = replies.map((reply) {
        if (reply.id == newReply.parentId) {
          return reply.copyWith(replies: [...reply.replies, newReply]);
        } else if (reply.hasReplies) {
          return reply.addReply(newReply);
        }
        return reply;
      }).toList();

      return copyWith(replies: updatedReplies);
    }
  }

  // Update a nested comment
  Comment updateReply(Comment updatedReply) {
    final updatedReplies = replies.map((reply) {
      if (reply.id == updatedReply.id) {
        return updatedReply;
      } else if (reply.hasReplies) {
        return reply.updateReply(updatedReply);
      }
      return reply;
    }).toList();

    return copyWith(replies: updatedReplies);
  }

  // Remove a reply
  Comment removeReply(int replyId) {
    final updatedReplies = replies
        .where((reply) => reply.id != replyId)
        .map((reply) => reply.hasReplies ? reply.removeReply(replyId) : reply)
        .toList();

    return copyWith(replies: updatedReplies);
  }

  // Get comment depth in nested structure
  int get depth {
    if (parent == null) return 0;
    return 1 + (parent?.depth ?? 0);
  }

  // Check if comment is deeply nested (for UI considerations)
  bool get isDeeplyNested => depth > 3;

  // Extract mentions from comment
  List<String> get mentions {
    final mentionRegex = RegExp(r'@(\w+)');
    return mentionRegex
        .allMatches(content)
        .map((match) => match.group(1)!)
        .toList();
  }
}

// Response wrapper for API calls
@JsonSerializable()
class CommentsResponse {
  final List<Comment> comments;
  final int total;
  @JsonKey(name: 'has_more')
  final bool hasMore;
  @JsonKey(name: 'next_cursor')
  final String? nextCursor;

  const CommentsResponse({
    required this.comments,
    required this.total,
    required this.hasMore,
    this.nextCursor,
  });

  factory CommentsResponse.fromJson(Map<String, dynamic> json) =>
      _$CommentsResponseFromJson(json);
  Map<String, dynamic> toJson() => _$CommentsResponseToJson(this);
}
