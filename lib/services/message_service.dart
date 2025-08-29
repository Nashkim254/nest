import 'package:nest/abstractClasses/abstract_class.dart';
import 'package:nest/models/send_message_request.dart';
import 'package:nest/services/websocket_service.dart';
import 'package:nest/ui/common/app_urls.dart';
import 'package:stacked/stacked.dart';
import 'dart:async';
import '../app/app.locator.dart';
import '../models/message_models.dart';
import '../ui/common/app_enums.dart';

class MessageService with ListenableServiceMixin {
  final WebsocketService _webSocketService = WebsocketService();
  final apiService = locator<IApiService>();
  // In-memory storage for conversations and messages
  final Map<int, List<Message>> _conversationMessages = {};
  final Map<int, Conversation> _conversations = {};
  final Map<int, Set<int>> _typingUsers = {};
  final Map<int, bool> _onlineUsers = {};

  StreamSubscription? _messageSubscription;
  StreamSubscription? _typingSubscription;
  StreamSubscription? _onlineStatusSubscription;

  // Reactive properties
  ReactiveValue<WebSocketConnectionStatus> _connectionStatus =
      ReactiveValue<WebSocketConnectionStatus>(
          WebSocketConnectionStatus.disconnected);

  ReactiveValue<Map<int, List<Message>>> _messages =
      ReactiveValue<Map<int, List<Message>>>({});

  ReactiveValue<Map<String, Set<int>>> _typing =
      ReactiveValue<Map<String, Set<int>>>({});

  // Getters
  WebSocketConnectionStatus get connectionStatus => _connectionStatus.value;
  Map<int, List<Message>> get messages => _messages.value;
  Map<String, Set<int>> get typingUsers => _typing.value;
  Map<int, bool> get onlineUsers => _onlineUsers;

  List<Message> getConversationMessages(int conversationId) {
    return _conversationMessages[conversationId] ?? [];
  }

  Set<int> getTypingUsers(int conversationId) {
    return _typingUsers[conversationId] ?? {};
  }

  bool isUserOnline(int userId) {
    return _onlineUsers[userId] ?? false;
  }

  MessageService() {
    listenToReactiveValues([_connectionStatus, _messages, _typing]);
    _setupSubscriptions();
  }

  void _setupSubscriptions() {
    // Connection status subscription
    _webSocketService.connectionStatus.listen((status) {
      _connectionStatus.value = status;
      notifyListeners();
    });

    // Message subscription
    _messageSubscription = _webSocketService.messageStream.listen((payload) {
      _handleNewMessage(payload);
    });

    // Typing subscription
    _typingSubscription = _webSocketService.typingStream.listen((payload) {
      _handleTypingIndicator(payload);
    });

    // Online status subscription
    _onlineStatusSubscription =
        _webSocketService.onlineStatusStream.listen((payload) {
      _handleOnlineStatus(payload);
    });
  }

  void _handleNewMessage(MessagePayload payload) {
    final conversationId = payload.conversationId;

    if (!_conversationMessages.containsKey(conversationId)) {
      _conversationMessages[conversationId] = [];
    }

    _conversationMessages[conversationId]!.add(payload.message);
    _messages.value = Map.from(_conversationMessages);
    notifyListeners();
  }

  void _handleTypingIndicator(TypingPayload payload) {
    final conversationId = payload.conversationId;

    if (!_typingUsers.containsKey(conversationId)) {
      _typingUsers[conversationId] = <int>{};
    }

    if (payload.isTyping) {
      _typingUsers[conversationId]!.add(payload.userId);
    } else {
      _typingUsers[conversationId]!.remove(payload.userId);
    }

    _typing.value = Map.from(_typingUsers);
    notifyListeners();
  }

  void _handleOnlineStatus(OnlineStatusPayload payload) {
    _onlineUsers[payload.userId] = payload.online;
    notifyListeners();
  }

  // Connection methods
  Future<void> connect(String serverUrl, String authToken) async {
    await _webSocketService.connect(serverUrl, authToken);
  }

  void disconnect() {
    _webSocketService.disconnect();
  }

  // Messaging methods
  Future<bool> sendMessage({
    required int? receiverId,
    required String content,
    String messageType = 'text',
    int? conversationId,
  }) async {
    return await _webSocketService.sendMessage(
      receiverId: receiverId,
      content: content,
      messageType: messageType,
      conversationId: conversationId!,
    );
  }

  Future<bool> sendTypingIndicator({
    required int conversationId,
    required bool isTyping,
  }) async {
    return await _webSocketService.sendTypingIndicator(
      conversationId: conversationId,
      isTyping: isTyping,
    );
  }

  Future<bool> markMessageAsRead({
    required int messageId,
    required int conversationId,
  }) async {
    return await _webSocketService.markMessageAsRead(
      messageId: messageId,
      conversationId: conversationId,
    );
  }

  // Local message management
  void addLocalMessage(int conversationId, Message message) {
    if (!_conversationMessages.containsKey(conversationId)) {
      _conversationMessages[conversationId] = [];
    }

    _conversationMessages[conversationId]!.add(message);
    _messages.value = Map.from(_conversationMessages);
    notifyListeners();
  }

  void setConversationMessages(int conversationId, List<Message> messages) {
    _conversationMessages[conversationId] = List.from(messages);
    _messages.value = Map.from(_conversationMessages);
    notifyListeners();
  }

  void clearConversationMessages(int conversationId) {
    _conversationMessages[conversationId]?.clear();
    _messages.value = Map.from(_conversationMessages);
    notifyListeners();
  }

  void dispose() {
    _messageSubscription?.cancel();
    _typingSubscription?.cancel();
    _onlineStatusSubscription?.cancel();
    _webSocketService.dispose();
  }

  //endpoints
  Future fetchConversations() async {
    final response = await apiService.get(AppUrls.conversations);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response;
    } else {
      throw Exception('Failed to load conversations: ${response.message}');
    }
  }

  Future fetchConversationMessages(int id) async {
    final response =
        await apiService.get('${AppUrls.conversationMessages}/$id/messages');
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response;
    } else {
      throw Exception('Failed to load conversations: ${response.message}');
    }
  }

  Future sendMessageApi(SendMessageRequest payload) async {
    final response =
        await apiService.post(AppUrls.sendMessage, data: payload.toJson());
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response;
    } else {
      throw Exception('Failed to load conversations: ${response.message}');
    }
  }

  Future createGroupConvo(var body) async {
    final response =
        await apiService.post(AppUrls.createGroupConvo, data: body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      return response;
    } else {
      throw Exception('Failed to load conversations: ${response.message}');
    }
  }
}
