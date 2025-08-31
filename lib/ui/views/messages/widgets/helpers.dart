import '../../../../models/message_models.dart';

extension ConversationHelpers on Conversation {
  /// Get the other participant in a conversation (excluding current user)
  User? getOtherParticipant(int currentUserId) {
    return participants.firstWhere(
      (participant) => participant.id != currentUserId,
      orElse: () => const User(), // Return empty user if not found
    );
  }

  /// Get the display name for the conversation
  /// For group chats: returns group name or "Group Chat"
  /// For direct messages: returns the other participant's name
  String getDisplayName(int currentUserId) {
    if (isGroup) {
      return groupName ?? 'Group Chat';
    }

    final otherUser = getOtherParticipant(currentUserId);
    return otherUser?.name ?? 'Unknown User';
  }

  /// Get the avatar for the conversation
  /// For group chats: returns group avatar or null
  /// For direct messages: returns the other participant's avatar
  String? getDisplayAvatar(int currentUserId) {
    if (isGroup) {
      return groupAvatar;
    }

    final otherUser = getOtherParticipant(currentUserId);
    return otherUser?.avatar;
  }

  /// Get all other participants (excluding current user)
  List<User> getOtherParticipants(int currentUserId) {
    return participants
        .where((participant) => participant.id != currentUserId)
        .toList();
  }

  /// Check if current user is admin (for group chats)
  bool isCurrentUserAdmin(int currentUserId) {
    return adminIds?.contains(currentUserId) ?? false;
  }

  int getUnreadCount(int currentUserId) {
    return messages
        .where(
            (message) => message.senderId != currentUserId && !message.isRead)
        .length;
  }

  /// Get the last message preview text
  String get lastMessagePreview {
    final lastMessage = messages.isNotEmpty ? messages.last : null;
    if (lastMessage == null) return 'No messages';

    // Handle different message types
    switch (lastMessage.messageType) {
      case 'text':
        return lastMessage.content.isNotEmpty
            ? lastMessage.content
            : 'No content';
      case 'image':
        return '📷 Image';
      case 'file':
        return '📎 File';
      default:
        return 'Message';
    }
  }
}

extension MessageHelpers on Message {
  /// Check if message is sent by current user
  bool isSentByCurrentUser(int currentUserId) {
    return senderId == currentUserId;
  }

  /// Get formatted time string for message
  String get formattedTime {
    if (createdAt == null) return '';

    final now = DateTime.now();
    final messageTime = createdAt!;
    final difference = now.difference(messageTime);

    if (difference.inDays > 0) {
      return '${difference.inDays}d ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m ago';
    } else {
      return 'Just now';
    }
  }
}
