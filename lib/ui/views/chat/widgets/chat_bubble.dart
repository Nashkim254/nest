// ui/views/chat/widgets/chat_bubble.dart

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:nest/app/app.locator.dart';
import 'package:nest/models/message_models.dart';
import 'package:nest/services/shared_preferences_service.dart';
import 'package:nest/ui/common/app_colors.dart';
import 'package:nest/utils/utilities.dart';

class ChatBubble extends StatelessWidget {
  final Message message;
  final int currentUserId;
  const ChatBubble(
      {super.key, required this.message, required this.currentUserId});

  @override
  Widget build(BuildContext context) {
    final isMyMessage = message.sender!.id == currentUserId;

    return Align(
      alignment: isMyMessage ? Alignment.centerRight : Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        child: Column(
          crossAxisAlignment:
              isMyMessage ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              constraints: const BoxConstraints(maxWidth: 300),
              decoration: BoxDecoration(
                color: isMyMessage ? kcPrimaryColor : kcMyTextColor,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  message.fileUrl != null
                      ? Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Image.network(
                            message.fileUrl!,
                            fit: BoxFit.cover,
                          ),
                        )
                      : const SizedBox.shrink(),
                  Text(
                    message.content,
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 4),
            Text(
              formatter.format(message.createdAt!),
              style: TextStyle(
                fontSize: 11,
                color: Colors.grey[500],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
