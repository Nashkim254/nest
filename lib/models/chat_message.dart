// models/chat_message.dart

import '../ui/common/app_enums.dart';

class ChatMessage {
  final String message;
  final String time;
  final MessageType type;

  ChatMessage({
    required this.message,
    required this.time,
    required this.type,
  });
}
