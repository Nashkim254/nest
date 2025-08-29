import 'package:json_annotation/json_annotation.dart';

part 'send_message_request.g.dart';

@JsonSerializable()
class SendMessageRequest {
  @JsonKey(name: 'receiver_id')
  final int? receiverId;

  @JsonKey(name: 'conversation_id')
  final int? conversationId;

  final String content;

  @JsonKey(name: 'message_type')
  final String messageType;

  @JsonKey(name: 'file_url')
  final String? fileUrl;

  SendMessageRequest({
    this.receiverId,
    this.conversationId,
    required this.content,
    required this.messageType,
    this.fileUrl,
  });

  factory SendMessageRequest.fromJson(Map<String, dynamic> json) =>
      _$SendMessageRequestFromJson(json);

  Map<String, dynamic> toJson() => _$SendMessageRequestToJson(this);
}
