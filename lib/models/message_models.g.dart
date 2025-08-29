// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ConversationResponseImpl _$$ConversationResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$ConversationResponseImpl(
      conversations: (json['conversations'] as List<dynamic>)
          .map((e) => Conversation.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$ConversationResponseImplToJson(
        _$ConversationResponseImpl instance) =>
    <String, dynamic>{
      'conversations': instance.conversations,
    };

_$MessageResponseImpl _$$MessageResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$MessageResponseImpl(
      limit: (json['limit'] as num?)?.toInt(),
      offset: (json['offset'] as num?)?.toInt(),
      messages: (json['messages'] as List<dynamic>?)
              ?.map((e) => Message.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$MessageResponseImplToJson(
        _$MessageResponseImpl instance) =>
    <String, dynamic>{
      'limit': instance.limit,
      'offset': instance.offset,
      'messages': instance.messages,
    };

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
      id: (json['id'] as num?)?.toInt(),
      name: json['display_name'] as String?,
      avatar: json['profile_picture'] as String?,
      email: json['email'] as String?,
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      phoneNumber: json['phone_number'] as String?,
      whatsappNumber: json['whatsapp_number'] as String?,
      bio: json['bio'] as String?,
      interests: (json['interests'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      longitude: (json['longitude'] as num?)?.toDouble(),
      latitude: (json['latitude'] as num?)?.toDouble(),
      location: json['location'] as String?,
      isPrivate: json['is_private'] as bool? ?? false,
      showOnGuestList: json['show_on_guest_list'] as bool? ?? false,
      showEvents: json['show_events'] as bool? ?? false,
      lastActive: json['last_active'] == null
          ? null
          : DateTime.parse(json['last_active'] as String),
      lastLogin: json['last_login'] == null
          ? null
          : DateTime.parse(json['last_login'] as String),
      qdrantId: json['qdrant_id'] as String?,
      isVerified: json['is_verified'] as bool? ?? false,
      isActive: json['is_active'] as bool? ?? false,
      role: json['role'] as String?,
    );

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'display_name': instance.name,
      'profile_picture': instance.avatar,
      'email': instance.email,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'phone_number': instance.phoneNumber,
      'whatsapp_number': instance.whatsappNumber,
      'bio': instance.bio,
      'interests': instance.interests,
      'longitude': instance.longitude,
      'latitude': instance.latitude,
      'location': instance.location,
      'is_private': instance.isPrivate,
      'show_on_guest_list': instance.showOnGuestList,
      'show_events': instance.showEvents,
      'last_active': instance.lastActive?.toIso8601String(),
      'last_login': instance.lastLogin?.toIso8601String(),
      'qdrant_id': instance.qdrantId,
      'is_verified': instance.isVerified,
      'is_active': instance.isActive,
      'role': instance.role,
    };

_$MessageImpl _$$MessageImplFromJson(Map<String, dynamic> json) =>
    _$MessageImpl(
      id: (json['id'] as num?)?.toInt(),
      senderId: (json['sender_id'] as num?)?.toInt(),
      receiverId: (json['receiver_id'] as num?)?.toInt(),
      conversationId: (json['conversation_id'] as num?)?.toInt(),
      content: json['content'] as String? ?? '',
      messageType: json['message_type'] as String? ?? 'text',
      isRead: json['is_read'] as bool? ?? false,
      readAt: json['read_at'] == null
          ? null
          : DateTime.parse(json['read_at'] as String),
      deletedAt: json['deleted_at'] == null
          ? null
          : DateTime.parse(json['deleted_at'] as String),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      fileUrl: json['file_url'] as String?,
      sender: json['sender'] == null
          ? null
          : User.fromJson(json['sender'] as Map<String, dynamic>),
      receiver: json['receiver'] == null
          ? null
          : User.fromJson(json['receiver'] as Map<String, dynamic>),
      conversation: json['conversation'] == null
          ? null
          : Conversation.fromJson(json['conversation'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$MessageImplToJson(_$MessageImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'sender_id': instance.senderId,
      'receiver_id': instance.receiverId,
      'conversation_id': instance.conversationId,
      'content': instance.content,
      'message_type': instance.messageType,
      'is_read': instance.isRead,
      'read_at': instance.readAt?.toIso8601String(),
      'deleted_at': instance.deletedAt?.toIso8601String(),
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'file_url': instance.fileUrl,
      'sender': instance.sender,
      'receiver': instance.receiver,
      'conversation': instance.conversation,
    };

_$ConversationImpl _$$ConversationImplFromJson(Map<String, dynamic> json) =>
    _$ConversationImpl(
      id: (json['id'] as num?)?.toInt(),
      conversationId: (json['conversation_id'] as num?)?.toInt(),
      participantIds: (json['participant_ids'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
      lastMessageId: (json['last_message_id'] as num?)?.toInt(),
      lastMessageAt: json['last_message_at'] == null
          ? null
          : DateTime.parse(json['last_message_at'] as String),
      isGroup: json['is_group'] as bool? ?? false,
      groupName: json['group_name'] as String?,
      groupAvatar: json['group_avatar'] as String?,
      createdBy: (json['created_by'] as num?)?.toInt(),
      adminIds: (json['admin_ids'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      messages: (json['messages'] as List<dynamic>?)
              ?.map((e) => Message.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      participants: (json['participants'] as List<dynamic>?)
              ?.map((e) => User.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$ConversationImplToJson(_$ConversationImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'conversation_id': instance.conversationId,
      'participant_ids': instance.participantIds,
      'last_message_id': instance.lastMessageId,
      'last_message_at': instance.lastMessageAt?.toIso8601String(),
      'is_group': instance.isGroup,
      'group_name': instance.groupName,
      'group_avatar': instance.groupAvatar,
      'created_by': instance.createdBy,
      'admin_ids': instance.adminIds,
      'created_at': instance.createdAt?.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'messages': instance.messages,
      'participants': instance.participants,
    };

_$WebSocketMessageImpl _$$WebSocketMessageImplFromJson(
        Map<String, dynamic> json) =>
    _$WebSocketMessageImpl(
      type: json['type'] as String,
      payload: _payloadFromJson(json['payload']),
    );

Map<String, dynamic> _$$WebSocketMessageImplToJson(
        _$WebSocketMessageImpl instance) =>
    <String, dynamic>{
      'type': instance.type,
      'payload': _payloadToJson(instance.payload),
    };

_$MessagePayloadImpl _$$MessagePayloadImplFromJson(Map<String, dynamic> json) =>
    _$MessagePayloadImpl(
      message: Message.fromJson(json['message'] as Map<String, dynamic>),
      conversationId: (json['conversation_id'] as num).toInt(),
    );

Map<String, dynamic> _$$MessagePayloadImplToJson(
        _$MessagePayloadImpl instance) =>
    <String, dynamic>{
      'message': instance.message,
      'conversation_id': instance.conversationId,
    };

_$TypingPayloadImpl _$$TypingPayloadImplFromJson(Map<String, dynamic> json) =>
    _$TypingPayloadImpl(
      userId: (json['user_id'] as num).toInt(),
      conversationId: (json['conversation_id'] as num).toInt(),
      isTyping: json['is_typing'] as bool,
    );

Map<String, dynamic> _$$TypingPayloadImplToJson(_$TypingPayloadImpl instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'conversation_id': instance.conversationId,
      'is_typing': instance.isTyping,
    };

_$OnlineStatusPayloadImpl _$$OnlineStatusPayloadImplFromJson(
        Map<String, dynamic> json) =>
    _$OnlineStatusPayloadImpl(
      userId: (json['user_id'] as num).toInt(),
      online: json['online'] as bool,
    );

Map<String, dynamic> _$$OnlineStatusPayloadImplToJson(
        _$OnlineStatusPayloadImpl instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'online': instance.online,
    };
