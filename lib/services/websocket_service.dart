import 'dart:async';
import 'dart:convert';

import 'package:flutter/rendering.dart';
import 'package:logger/logger.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../models/message_models.dart';
import '../ui/common/app_enums.dart';

class WebsocketService {
  static final WebsocketService _instance = WebsocketService._internal();
  factory WebsocketService() => _instance;
  WebsocketService._internal();

  final Logger _logger = Logger();
  WebSocketChannel? _channel;
  Timer? _heartbeatTimer;
  Timer? _reconnectTimer;

  String? _serverUrl;
  String? _authToken;
  int _reconnectAttempts = 0;
  static const int maxReconnectAttempts = 5;
  static const Duration reconnectInterval = Duration(seconds: 5);
  static const Duration heartbeatInterval = Duration(seconds: 30);

  // Connection status stream
  final _connectionStatusController =
      StreamController<WebSocketConnectionStatus>.broadcast();
  Stream<WebSocketConnectionStatus> get connectionStatus =>
      _connectionStatusController.stream;
  WebSocketConnectionStatus _currentStatus =
      WebSocketConnectionStatus.disconnected;

  // Message streams
  final _messageController = StreamController<MessagePayload>.broadcast();
  Stream<MessagePayload> get messageStream => _messageController.stream;

  final _typingController = StreamController<TypingPayload>.broadcast();
  Stream<TypingPayload> get typingStream => _typingController.stream;

  final _onlineStatusController =
      StreamController<OnlineStatusPayload>.broadcast();
  Stream<OnlineStatusPayload> get onlineStatusStream =>
      _onlineStatusController.stream;

  // Connection methods
  Future<void> connect(String serverUrl, String authToken) async {
    _serverUrl = serverUrl;
    _authToken = authToken;
    await _connect();
  }

  Future<void> _connect() async {
    if (_currentStatus == WebSocketConnectionStatus.connecting ||
        _currentStatus == WebSocketConnectionStatus.connected) {
      return;
    }

    _updateConnectionStatus(WebSocketConnectionStatus.connecting);

    try {
      _logger.e(_serverUrl);
      final uri = Uri.parse('$_serverUrl?token=$_authToken');

      _channel = WebSocketChannel.connect(
        uri,
      );

      // Listen to the channel
      _channel!.stream.listen(
        _onMessage,
        onError: _onError,
        onDone: _onDisconnected,
        cancelOnError: false,
      );

      _updateConnectionStatus(WebSocketConnectionStatus.connected);
      _reconnectAttempts = 0;
      _startHeartbeat();
      _logger.i('WebSocket connected successfully');
    } catch (e) {
      _logger.e('WebSocket connection error: $e');
      _updateConnectionStatus(WebSocketConnectionStatus.error);
      _scheduleReconnect();
    }
  }

  void _onMessage(dynamic data) {
    final jsonData = jsonDecode(data);
    try {
      final wsMessage = WebSocketMessage.fromJson(jsonData);

      _logger.d('Received WebSocket message: ${wsMessage.type}');

      switch (wsMessage.type) {
        case 'new_message':
          final payload = MessagePayload.fromJson(wsMessage.payload!);
          _logger.d('Received WebSocket message: ${payload}');

          _messageController.add(payload);
          break;

        case 'typing':
          final payload = TypingPayload.fromJson(wsMessage.payload!);
          _typingController.add(payload);
          break;

        case 'online_status':
          final payload = OnlineStatusPayload.fromJson(wsMessage.payload!);
          _onlineStatusController.add(payload);
          break;

        case 'pong':
          _logger.d('Received pong');
          break;
        case 'ping':
          _logger.d('send ping');
          break;

        default:
          _logger.w('Unknown message type: ${wsMessage.type}');
      }
    } catch (e, s) {
      _logger.e('Error processing message: $s');
      _logger.e('Error processing message: $e');
      debugPrint('Error processing message: $jsonData', wrapWidth: 1024);
    }
  }

  void _onError(error) {
    _logger.e('WebSocket error: $error');
    _updateConnectionStatus(WebSocketConnectionStatus.error);
    _scheduleReconnect();
  }

  void _onDisconnected() {
    _logger.w('WebSocket disconnected');
    _updateConnectionStatus(WebSocketConnectionStatus.disconnected);
    _cleanup();
    _scheduleReconnect();
  }

  void _updateConnectionStatus(WebSocketConnectionStatus status) {
    _currentStatus = status;
    _connectionStatusController.add(status);
  }

  void _startHeartbeat() {
    _heartbeatTimer?.cancel();
    _heartbeatTimer = Timer.periodic(heartbeatInterval, (timer) {
      if (_currentStatus == WebSocketConnectionStatus.connected) {
        _sendHeartbeat();
      }
    });
  }

  void _sendHeartbeat() {
    try {
      final heartbeat = WebSocketMessage(
        type: 'ping',
        payload: {'timestamp': DateTime.now().millisecondsSinceEpoch},
      );
      _channel?.sink.add(jsonEncode(heartbeat.toJson()));
    } catch (e) {
      _logger.e('Error sending heartbeat: $e');
    }
  }

  void _scheduleReconnect() {
    if (_reconnectAttempts >= maxReconnectAttempts) {
      _logger.e('Max reconnection attempts reached');
      return;
    }

    _reconnectTimer?.cancel();
    _reconnectTimer = Timer(reconnectInterval, () {
      _reconnectAttempts++;
      _logger.i(
          'Attempting to reconnect... ($_reconnectAttempts/$maxReconnectAttempts)');
      _connect();
    });
  }

  void _cleanup() {
    _heartbeatTimer?.cancel();
    _reconnectTimer?.cancel();
    _channel?.sink.close();
    _channel = null;
  }

  // Message sending methods
  Future<bool> sendMessage({
    required int? receiverId,
    required String content,
    String messageType = 'text',
    int? conversationId,
  }) async {
    if (_currentStatus != WebSocketConnectionStatus.connected) {
      _logger.w('Cannot send message: WebSocket not connected');
      return false;
    }

    try {
      final message = WebSocketMessage(
        type: 'send_message',
        payload: {
          if (receiverId != null) 'receiver_id': receiverId,
          'content': content,
          'message_type': messageType,
          if (conversationId != null) 'conversation_id': conversationId,
        },
      );

      _channel?.sink.add(jsonEncode(message.toJson()));
      _logger.d('Message sent successfully');
      return true;
    } catch (e) {
      _logger.e('Error sending message: $e');
      return false;
    }
  }

  Future<bool> sendTypingIndicator({
    required int conversationId,
    required bool isTyping,
  }) async {
    if (_currentStatus != WebSocketConnectionStatus.connected) {
      return false;
    }

    try {
      final message = WebSocketMessage(
        type: 'typing',
        payload: {
          'conversation_id': conversationId,
          'is_typing': isTyping,
        },
      );

      _channel?.sink.add(jsonEncode(message.toJson()));
      return true;
    } catch (e) {
      _logger.e('Error sending typing indicator: $e');
      return false;
    }
  }

  Future<bool> markMessageAsRead({
    required int messageId,
    required int conversationId,
  }) async {
    if (_currentStatus != WebSocketConnectionStatus.connected) {
      return false;
    }

    try {
      final message = WebSocketMessage(
        type: 'mark_as_read',
        payload: {
          'message_id': messageId,
          'conversation_id': conversationId,
        },
      );

      _channel?.sink.add(jsonEncode(message.toJson()));
      return true;
    } catch (e) {
      _logger.e('Error marking message as read: $e');
      return false;
    }
  }

  // Connection management
  void disconnect() {
    _logger.i('Disconnecting WebSocket');
    _reconnectTimer?.cancel();
    _cleanup();
    _updateConnectionStatus(WebSocketConnectionStatus.disconnected);
  }

  void dispose() {
    disconnect();
    _connectionStatusController.close();
    _messageController.close();
    _typingController.close();
    _onlineStatusController.close();
  }

  // Getters
  bool get isConnected => _currentStatus == WebSocketConnectionStatus.connected;
  WebSocketConnectionStatus get currentStatus => _currentStatus;
}
