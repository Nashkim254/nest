import 'package:flutter/material.dart';
import 'package:nest/ui/common/app_colors.dart';
import 'package:nest/ui/common/app_styles.dart';
import 'package:nest/ui/common/ui_helpers.dart';
import 'package:nest/ui/views/messages/widgets/helpers.dart';
import 'package:nest/utils/utilities.dart';

import '../../../../models/message_models.dart';


class ChatListItem extends StatelessWidget {
  final Conversation chat;
  final int currentUserId; // Add this parameter
  final VoidCallback? onTap;

  const ChatListItem({
    super.key,
    required this.chat,
    required this.currentUserId, // Make this required
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // Get the other participant (not the current user)
    final otherUser = chat.getOtherParticipant(currentUserId);

    // Get display information
    final displayName = chat.getDisplayName(currentUserId);
    final displayAvatar = chat.getDisplayAvatar(currentUserId);

    // Handle last message safely
    final lastMessage = chat.messages.isNotEmpty ? chat.messages.last : null;
    final lastMessageContent = chat.lastMessagePreview;

    // Get unread count for current user
    final unreadCount = chat.getUnreadCount(currentUserId);

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        child: Row(
          children: [
            // Profile Image
            CircleAvatar(
              radius: 24,
              backgroundImage: displayAvatar != null && displayAvatar.isNotEmpty
                  ? NetworkImage(displayAvatar)
                  : null,
              backgroundColor: displayAvatar == null || displayAvatar.isEmpty
                  ? kcPrimaryColor
                  : null,
              child: displayAvatar == null || displayAvatar.isEmpty
                  ? Text(
                displayName.isNotEmpty ? displayName[0].toUpperCase() : '?',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              )
                  : null,
            ),
            horizontalSpaceMedium,
            // Name, Message
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    displayName,
                    style: titleTextMedium.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      // Show "You: " prefix if last message was sent by current user
                      if (lastMessage?.senderId == currentUserId) ...[
                        Text(
                          'You: ',
                          style: titleTextMedium.copyWith(
                            fontSize: 14,
                            color: kcSubtitleText2Color,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                      Expanded(
                        child: Text(
                          lastMessageContent,
                          style: titleTextMedium.copyWith(
                            fontSize: 14,
                            color: kcSubtitleText2Color,
                            fontWeight: FontWeight.w400,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Time + Unread
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  lastMessage?.createdAt != null
                      ? formatter.format(lastMessage!.createdAt!)
                      : '',
                  style: titleTextMedium.copyWith(
                    fontSize: 13,
                    color: kcSubtitleText2Color,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 6),
                // Show unread badge only if there are unread messages
                if (unreadCount > 0)
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    decoration: const BoxDecoration(
                      color: kcPrimaryColor,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    child: Text(
                      unreadCount > 99 ? '99+' : unreadCount.toString(),
                      style: titleTextMedium.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
