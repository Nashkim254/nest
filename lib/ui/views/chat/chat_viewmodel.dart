import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import 'package:nest/services/global_service.dart';
import 'package:nest/services/message_service.dart';
import 'package:nest/services/shared_preferences_service.dart';
import 'package:nest/ui/common/app_urls.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../models/chat_message.dart';
import '../../../models/message_models.dart';
import '../../../services/auth_service.dart';
import '../../common/app_enums.dart';

class ChatViewModel extends ReactiveViewModel {
  TextEditingController messageController = TextEditingController();
  final authService = locator<AuthService>();
  final global = locator<GlobalService>();

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
  List<ListenableServiceMixin> get listenableServices => [_messagingService];

  // Getters
  List<Message> get chats =>
      _messagingService.getConversationMessages(conversationId);
  Set<int> get typingUsers => _messagingService.getTypingUsers(conversationId);
  WebSocketConnectionStatus get connectionStatus =>
      _messagingService.connectionStatus;
  bool get isConnected =>
      connectionStatus == WebSocketConnectionStatus.connected;

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

  int get userId => locator<SharedPreferencesService>().getUserInfo()!['id'];

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
      senderId: userId,
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
      AppUrls.websocketUrl,
      authService.prefsService.getAuthToken()!, // Replace with actual token
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
