// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'send_message_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SendMessageRequest _$SendMessageRequestFromJson(Map<String, dynamic> json) =>
    SendMessageRequest(
      receiverId: (json['receiver_id'] as num?)?.toInt(),
      conversationId: (json['conversation_id'] as num?)?.toInt(),
      content: json['content'] as String,
      messageType: json['message_type'] as String,
      fileUrl: json['file_url'] as String?,
    );

Map<String, dynamic> _$SendMessageRequestToJson(SendMessageRequest instance) =>
    <String, dynamic>{
      'receiver_id': instance.receiverId,
      'conversation_id': instance.conversationId,
      'content': instance.content,
      'message_type': instance.messageType,
      'file_url': instance.fileUrl,
    };
