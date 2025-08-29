import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'message_models.freezed.dart';
part 'message_models.g.dart';

// Add this new model to handle the API response structure
@freezed
class ConversationResponse with _$ConversationResponse {
  const factory ConversationResponse({
    required List<Conversation> conversations,
  }) = _ConversationResponse;

  factory ConversationResponse.fromJson(Map<String, dynamic> json) =>
      _$ConversationResponseFromJson(json);
}

// Model to handle the messages fetch API response
@freezed
class MessageResponse with _$MessageResponse {
  const factory MessageResponse({
    // Made these nullable in case API returns null
    int? limit,
    int? offset,
    @Default([]) List<Message> messages, // Added default empty list
  }) = _MessageResponse;

  factory MessageResponse.fromJson(Map<String, dynamic> json) =>
      _$MessageResponseFromJson(json);
}

@freezed
class User with _$User {
  const factory User({
    // Updated to match your API response - using lowercase 'id' instead of 'ID'
    int? id,
    @JsonKey(name: 'display_name') String? name,
    @JsonKey(name: 'profile_picture') String? avatar,
    String? email,
    @JsonKey(name: 'first_name') String? firstName,
    @JsonKey(name: 'last_name') String? lastName,
    @JsonKey(name: 'phone_number') String? phoneNumber,
    @JsonKey(name: 'whatsapp_number') String? whatsappNumber,
    String? bio,
    List<String>? interests,
    double? longitude,
    double? latitude,
    String? location,
    @JsonKey(name: 'is_private') @Default(false) bool isPrivate,
    @JsonKey(name: 'show_on_guest_list') @Default(false) bool showOnGuestList,
    @JsonKey(name: 'show_events') @Default(false) bool showEvents,
    @JsonKey(name: 'last_active') DateTime? lastActive,
    @JsonKey(name: 'last_login') DateTime? lastLogin,
    @JsonKey(name: 'qdrant_id') String? qdrantId,
    @JsonKey(name: 'is_verified') @Default(false) bool isVerified,
    @JsonKey(name: 'is_active') @Default(false) bool isActive,
    String? role,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

@freezed
class Message with _$Message {
  const factory Message({
    // Updated to match your API response - using lowercase 'id'
    int? id,
    // Made senderId nullable in case API returns null
    @JsonKey(name: 'sender_id') int? senderId,
    @JsonKey(name: 'receiver_id') int? receiverId,
    @JsonKey(name: 'conversation_id') int? conversationId,
    @Default('') String content, // Added default empty string
    @JsonKey(name: 'message_type') @Default('text') String messageType,
    @JsonKey(name: 'is_read') @Default(false) bool isRead,
    @JsonKey(name: 'read_at') DateTime? readAt,
    @JsonKey(name: 'deleted_at') DateTime? deletedAt,
    // Updated to match your API response - using snake_case
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
    @JsonKey(name: 'file_url') String? fileUrl,
    User? sender,
    User? receiver,
    Conversation? conversation,
  }) = _Message;

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);
}

@freezed
class Conversation with _$Conversation {
  const factory Conversation({
    // Updated to match your API response - using lowercase 'id'
    int? id,
    @JsonKey(name: 'conversation_id') int? conversationId,
    @JsonKey(name: 'participant_ids') List<int>? participantIds,
    @JsonKey(name: 'last_message_id') int? lastMessageId,
    @JsonKey(name: 'last_message_at') DateTime? lastMessageAt,
    @JsonKey(name: 'is_group') @Default(false) bool isGroup,
    @JsonKey(name: 'group_name') String? groupName,
    @JsonKey(name: 'group_avatar') String? groupAvatar,
    @JsonKey(name: 'created_by') int? createdBy,
    @JsonKey(name: 'admin_ids') List<int>? adminIds,
    // Added missing fields from your API response
    @JsonKey(name: 'created_at') DateTime? createdAt,
    @JsonKey(name: 'updated_at') DateTime? updatedAt,
    @Default([]) List<Message> messages,
    // Added participants list to match your API structure
    @Default([]) List<User> participants,
  }) = _Conversation;

  factory Conversation.fromJson(Map<String, dynamic> json) =>
      _$ConversationFromJson(json);
}

@freezed
class WebSocketMessage with _$WebSocketMessage {
  const factory WebSocketMessage({
    required String type,
    @JsonKey(fromJson: _payloadFromJson, toJson: _payloadToJson)
    Map<String, dynamic>? payload,
  }) = _WebSocketMessage;

  factory WebSocketMessage.fromJson(Map<String, dynamic> json) =>
      _$WebSocketMessageFromJson(json);
}

// Helper functions to handle string or map payload
Map<String, dynamic>? _payloadFromJson(dynamic value) {
  if (value == null) return null;
  if (value is Map<String, dynamic>) return value;
  if (value is String) {
    try {
      return jsonDecode(value) as Map<String, dynamic>;
    } catch (e) {
      print('Failed to decode payload string: $value');
      return null;
    }
  }
  return null;
}

dynamic _payloadToJson(Map<String, dynamic>? payload) => payload;

@freezed
class MessagePayload with _$MessagePayload {
  const factory MessagePayload({
    required Message message,
    @JsonKey(name: 'conversation_id') required int conversationId,
  }) = _MessagePayload;

  factory MessagePayload.fromJson(Map<String, dynamic> json) =>
      _$MessagePayloadFromJson(json);
}

@freezed
class TypingPayload with _$TypingPayload {
  const factory TypingPayload({
    @JsonKey(name: 'user_id') required int userId,
    @JsonKey(name: 'conversation_id') required int conversationId,
    @JsonKey(name: 'is_typing') required bool isTyping,
  }) = _TypingPayload;

  factory TypingPayload.fromJson(Map<String, dynamic> json) =>
      _$TypingPayloadFromJson(json);
}

@freezed
class OnlineStatusPayload with _$OnlineStatusPayload {
  const factory OnlineStatusPayload({
    @JsonKey(name: 'user_id') required int userId,
    required bool online,
  }) = _OnlineStatusPayload;

  factory OnlineStatusPayload.fromJson(Map<String, dynamic> json) =>
      _$OnlineStatusPayloadFromJson(json);
}

// Enhanced example usage function with better error handling
void handleConversationResponse(String jsonString) {
  try {
    final Map<String, dynamic> jsonData = jsonDecode(jsonString);
    final ConversationResponse response =
        ConversationResponse.fromJson(jsonData);

    for (final conversation in response.conversations) {
      print('Conversation ${conversation.id}:');
      print('- Is Group: ${conversation.isGroup}');
      print(
          '- Participants: ${conversation.participants.map((p) => p.name ?? 'Unknown').join(', ')}');
      print(
          '- Last Message: "${conversation.messages.lastOrNull?.content ?? 'No messages'}"');
      print('- Last Message At: ${conversation.lastMessageAt}');
      print('---');
    }
  } catch (e) {
    print('Error parsing conversation response: $e');
  }
}

// Helper function to safely parse message response
MessageResponse? parseMessageResponse(Map<String, dynamic> json) {
  try {
    return MessageResponse.fromJson(json);
  } catch (e) {
    print('Error parsing MessageResponse: $e');
    print('JSON: $json');
    return null;
  }
}
