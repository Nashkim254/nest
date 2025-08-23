// ui/views/chat/widgets/chat_bubble.dart

import 'package:flutter/material.dart';
import 'package:nest/app/app.locator.dart';
import 'package:nest/models/message_models.dart';
import 'package:nest/services/shared_preferences_service.dart';
import 'package:nest/ui/common/app_colors.dart';
import 'package:nest/utils/utilities.dart';

import '../../../../models/chat_message.dart';
import '../../../common/app_enums.dart';

class ChatBubble extends StatelessWidget {
  final Message message;

  const ChatBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    final isSent = message.senderId ==
        locator<SharedPreferencesService>().getUserInfo()!['id'];

    return Align(
      alignment: isSent ? Alignment.centerRight : Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        child: Column(
          crossAxisAlignment:
              isSent ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(14),
              constraints: const BoxConstraints(maxWidth: 300),
              decoration: BoxDecoration(
                color: isSent ? kcPrimaryColor : kcMyTextColor,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Text(
                message.content,
                style: const TextStyle(color: Colors.white),
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
