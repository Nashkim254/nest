import 'package:flutter/cupertino.dart';
import 'package:stacked/stacked.dart';

import '../../../models/chat_message.dart';
import '../../common/app_enums.dart';

class ChatViewModel extends BaseViewModel {
  TextEditingController messageController = TextEditingController();
  final List<ChatMessage> _messages = [
    ChatMessage(
      message: "Hey! Are you going to the Neon Nights party this weekend?",
      time: "10:30 AM",
      type: MessageType.received,
    ),
    ChatMessage(
      message: "Yeah, definitely! Heard it's going to be epic. Are you?",
      time: "10:32 AM",
      type: MessageType.sent,
    ),
    ChatMessage(
      message:
          "Absolutely! Can’t miss it. What time are you planning to head over?",
      time: "10:35 AM",
      type: MessageType.received,
    ),
    ChatMessage(
      message: "Probably around 9 PM. Want to meet up there?",
      time: "10:36 AM",
      type: MessageType.sent,
    ),
    ChatMessage(
      message: "Sounds good! See you then!",
      time: "10:38 AM",
      type: MessageType.received,
    ),
  ];

  List<ChatMessage> get messages => _messages;
}
