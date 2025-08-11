import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:nest/services/message_service.dart';
import 'package:stacked/stacked.dart';

import '../../../app/app.locator.dart';
import '../../../models/chat_message.dart';
import '../../../models/message_models.dart';
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

  final MessageService _messagingService = locator<MessageService>();

  final String conversationId;
  final int? receiverId;

  bool _isTyping = false;
  Timer? _typingTimer;

  ChatViewModel({
    required this.conversationId,
    this.receiverId,
  });

  @override
  List<ListenableServiceMixin> get reactiveServices => [_messagingService];

  // Getters
  List<Message> get chats => _messagingService.getConversationMessages(conversationId);
  Set<int> get typingUsers => _messagingService.getTypingUsers(conversationId);
  WebSocketConnectionStatus get connectionStatus => _messagingService.connectionStatus;
  bool get isConnected => connectionStatus == WebSocketConnectionStatus.connected;

  String get connectionStatusText {
    switch (connectionStatus) {
      case WebSocketConnectionStatus.connected:
        return 'Connected';
      case WebSocketConnectionStatus.connecting:
        return 'Connecting...';
      case WebSocketConnectionStatus.disconnected:
        return 'Disconnected';
      case WebSocketConnectionStatus.error:
        return 'Connection Error';
    }
  }

  // Message sending
  Future<void> sendMessage() async {
    final content = messageController.text.trim();
    if (content.isEmpty || !isConnected) return;

    // Clear the input immediately
    messageController.clear();

    // Stop typing indicator
    if (_isTyping) {
      await _stopTyping();
    }

    // Create local message for immediate UI update
    final localMessage = Message(
      senderId: 1, // Replace with actual current user ID
      receiverId: receiverId,
      conversationId: conversationId,
      content: content,
      messageType: 'text',
      createdAt: DateTime.now(),
    );

    // Add to local messages immediately
    _messagingService.addLocalMessage(conversationId, localMessage);

    // Send through WebSocket
    final success = await _messagingService.sendMessage(
      receiverId: receiverId,
      content: content,
      conversationId: conversationId,
    );

    if (!success) {
      // Handle send failure - maybe show error or retry
      // For now, the local message will remain
    }
  }

  // Typing indicators
  void onMessageChanged(String text) {
    if (text.isNotEmpty && !_isTyping) {
      _startTyping();
    } else if (text.isEmpty && _isTyping) {
      _stopTyping();
    }

    // Reset typing timer
    _typingTimer?.cancel();
    _typingTimer = Timer(const Duration(seconds: 2), () {
      if (_isTyping) {
        _stopTyping();
      }
    });
  }

  Future<void> _startTyping() async {
    _isTyping = true;
    await _messagingService.sendTypingIndicator(
      conversationId: conversationId,
      isTyping: true,
    );
  }

  Future<void> _stopTyping() async {
    _isTyping = false;
    _typingTimer?.cancel();
    await _messagingService.sendTypingIndicator(
      conversationId: conversationId,
      isTyping: false,
    );
  }

  // Connection management
  Future<void> connect() async {
    await _messagingService.connect(
      'ws://localhost:8080/api/v1/ws',
      'YOUR_AUTH_TOKEN', // Replace with actual token
    );
  }

  void markMessageAsRead(Message message) {
    if (message.id != null && !message.isRead) {
      _messagingService.markMessageAsRead(
        messageId: message.id!,
        conversationId: conversationId,
      );
    }
  }

  @override
  void dispose() {
    messageController.dispose();
    _typingTimer?.cancel();
    if (_isTyping) {
      _stopTyping();
    }
    super.dispose();
  }
}
