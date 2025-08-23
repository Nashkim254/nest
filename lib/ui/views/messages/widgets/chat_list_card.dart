import 'package:flutter/material.dart';
import 'package:nest/ui/common/app_colors.dart';
import 'package:nest/ui/common/app_styles.dart';
import 'package:nest/ui/common/ui_helpers.dart';
import 'package:nest/utils/utilities.dart';

import '../../../../models/chats.dart';
import '../../../../models/message_models.dart';

class ChatListItem extends StatelessWidget {
  final Conversation chat;
  final VoidCallback? onTap;

  const ChatListItem({
    super.key,
    required this.chat,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        child: Row(
          children: [
            // Profile Image
            CircleAvatar(
              radius: 24,
              backgroundImage: NetworkImage(chat.groupAvatar!),
            ),
            horizontalSpaceMedium,
            // Name, Message
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    chat.messages.first.sender!.name,
                    style: titleTextMedium.copyWith(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    chat.messages.first.content,
                    style: titleTextMedium.copyWith(
                      fontSize: 14,
                      color: kcSubtitleText2Color,
                      fontWeight: FontWeight.w400,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            // Time + Unread
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  formatter.format(chat.messages.last.createdAt!),
                  style: titleTextMedium.copyWith(
                    fontSize: 13,
                    color: kcSubtitleText2Color,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                const SizedBox(height: 6),
                if (!chat.messages.last.isRead)
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    decoration: const BoxDecoration(
                      color: kcPrimaryColor,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    child: Text(
                      chat.messages
                          .where((m) => !m.isRead)
                          .toList()
                          .length
                          .toString(),
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
