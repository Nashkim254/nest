import 'package:freezed_annotation/freezed_annotation.dart';

part 'message_models.freezed.dart';
part 'message_models.g.dart';

@freezed
class User with _$User {
  const factory User({
    required int id,
    required String name,
    String? avatar,
    String? email,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

@freezed
class Message with _$Message {
  const factory Message({
    int? id,
    required int senderId,
    int? receiverId,
    required String conversationId,
    required String content,
    @Default('text') String messageType,
    @Default(false) bool isRead,
    DateTime? readAt,
    DateTime? deletedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
    User? sender,
    User? receiver,
  }) = _Message;

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);
}

@freezed
class Conversation with _$Conversation {
  const factory Conversation({
    int? id,
    required String conversationId,
    required List<int> participantIds,
    int? lastMessageId,
    DateTime? lastMessageAt,
    @Default(false) bool isGroup,
    String? groupName,
    String? groupAvatar,
    @Default([]) List<Message> messages,
  }) = _Conversation;

  factory Conversation.fromJson(Map<String, dynamic> json) =>
      _$ConversationFromJson(json);
}

@freezed
class WebSocketMessage with _$WebSocketMessage {
  const factory WebSocketMessage({
    required String type,
    required Map<String, dynamic> payload,
  }) = _WebSocketMessage;

  factory WebSocketMessage.fromJson(Map<String, dynamic> json) =>
      _$WebSocketMessageFromJson(json);
}

@freezed
class MessagePayload with _$MessagePayload {
  const factory MessagePayload({
    required Message message,
    required String conversationId,
  }) = _MessagePayload;

  factory MessagePayload.fromJson(Map<String, dynamic> json) =>
      _$MessagePayloadFromJson(json);
}

@freezed
class TypingPayload with _$TypingPayload {
  const factory TypingPayload({
    required int userId,
    required String conversationId,
    required bool isTyping,
  }) = _TypingPayload;

  factory TypingPayload.fromJson(Map<String, dynamic> json) =>
      _$TypingPayloadFromJson(json);
}

@freezed
class OnlineStatusPayload with _$OnlineStatusPayload {
  const factory OnlineStatusPayload({
    required int userId,
    required bool online,
  }) = _OnlineStatusPayload;

  factory OnlineStatusPayload.fromJson(Map<String, dynamic> json) =>
      _$OnlineStatusPayloadFromJson(json);
}
