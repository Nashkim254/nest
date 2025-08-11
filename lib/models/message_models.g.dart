// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      avatar: json['avatar'] as String?,
      email: json['email'] as String?,
    );

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'avatar': instance.avatar,
      'email': instance.email,
    };

_$MessageImpl _$$MessageImplFromJson(Map<String, dynamic> json) =>
    _$MessageImpl(
      id: (json['id'] as num?)?.toInt(),
      senderId: (json['senderId'] as num).toInt(),
      receiverId: (json['receiverId'] as num?)?.toInt(),
      conversationId: json['conversationId'] as String,
      content: json['content'] as String,
      messageType: json['messageType'] as String? ?? 'text',
      isRead: json['isRead'] as bool? ?? false,
      readAt: json['readAt'] == null
          ? null
          : DateTime.parse(json['readAt'] as String),
      deletedAt: json['deletedAt'] == null
          ? null
          : DateTime.parse(json['deletedAt'] as String),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      sender: json['sender'] == null
          ? null
          : User.fromJson(json['sender'] as Map<String, dynamic>),
      receiver: json['receiver'] == null
          ? null
          : User.fromJson(json['receiver'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$MessageImplToJson(_$MessageImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'senderId': instance.senderId,
      'receiverId': instance.receiverId,
      'conversationId': instance.conversationId,
      'content': instance.content,
      'messageType': instance.messageType,
      'isRead': instance.isRead,
      'readAt': instance.readAt?.toIso8601String(),
      'deletedAt': instance.deletedAt?.toIso8601String(),
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'sender': instance.sender,
      'receiver': instance.receiver,
    };

_$ConversationImpl _$$ConversationImplFromJson(Map<String, dynamic> json) =>
    _$ConversationImpl(
      id: (json['id'] as num?)?.toInt(),
      conversationId: json['conversationId'] as String,
      participantIds: (json['participantIds'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      lastMessageId: (json['lastMessageId'] as num?)?.toInt(),
      lastMessageAt: json['lastMessageAt'] == null
          ? null
          : DateTime.parse(json['lastMessageAt'] as String),
      isGroup: json['isGroup'] as bool? ?? false,
      groupName: json['groupName'] as String?,
      groupAvatar: json['groupAvatar'] as String?,
      messages: (json['messages'] as List<dynamic>?)
              ?.map((e) => Message.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$ConversationImplToJson(_$ConversationImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'conversationId': instance.conversationId,
      'participantIds': instance.participantIds,
      'lastMessageId': instance.lastMessageId,
      'lastMessageAt': instance.lastMessageAt?.toIso8601String(),
      'isGroup': instance.isGroup,
      'groupName': instance.groupName,
      'groupAvatar': instance.groupAvatar,
      'messages': instance.messages,
    };

_$WebSocketMessageImpl _$$WebSocketMessageImplFromJson(
        Map<String, dynamic> json) =>
    _$WebSocketMessageImpl(
      type: json['type'] as String,
      payload: json['payload'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$$WebSocketMessageImplToJson(
        _$WebSocketMessageImpl instance) =>
    <String, dynamic>{
      'type': instance.type,
      'payload': instance.payload,
    };

_$MessagePayloadImpl _$$MessagePayloadImplFromJson(Map<String, dynamic> json) =>
    _$MessagePayloadImpl(
      message: Message.fromJson(json['message'] as Map<String, dynamic>),
      conversationId: json['conversationId'] as String,
    );

Map<String, dynamic> _$$MessagePayloadImplToJson(
        _$MessagePayloadImpl instance) =>
    <String, dynamic>{
      'message': instance.message,
      'conversationId': instance.conversationId,
    };

_$TypingPayloadImpl _$$TypingPayloadImplFromJson(Map<String, dynamic> json) =>
    _$TypingPayloadImpl(
      userId: (json['userId'] as num).toInt(),
      conversationId: json['conversationId'] as String,
      isTyping: json['isTyping'] as bool,
    );

Map<String, dynamic> _$$TypingPayloadImplToJson(_$TypingPayloadImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'conversationId': instance.conversationId,
      'isTyping': instance.isTyping,
    };

_$OnlineStatusPayloadImpl _$$OnlineStatusPayloadImplFromJson(
        Map<String, dynamic> json) =>
    _$OnlineStatusPayloadImpl(
      userId: (json['userId'] as num).toInt(),
      online: json['online'] as bool,
    );

Map<String, dynamic> _$$OnlineStatusPayloadImplToJson(
        _$OnlineStatusPayloadImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'online': instance.online,
    };
