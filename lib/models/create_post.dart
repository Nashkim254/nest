import 'dart:convert';

class CreatePostRequest {
  final String content;
  final List<String>? imageUrls;
  final List<String>? hashtags;
  final bool? isPrivate;
  final String? location;
  final String? mediaId;

  CreatePostRequest({
    required this.content,
    this.imageUrls,
    this.hashtags,
    this.isPrivate,
    this.location,
    this.mediaId,
  });

  factory CreatePostRequest.fromJson(Map<String, dynamic> json) {
    return CreatePostRequest(
      content: json['content'],
      imageUrls: json['image_urls'] != null
          ? List<String>.from(json['image_urls'])
          : null,
      hashtags:
          json['hashtags'] != null ? List<String>.from(json['hashtags']) : null,
      isPrivate: json['is_private'],
      location: json['location'],
      mediaId: json['media_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'content': content,
      'image_urls': imageUrls,
      'hashtags': hashtags,
      'is_private': isPrivate,
      'location': location,
      'media_id': mediaId,
    };
  }

  String toRawJson() => json.encode(toJson());

  factory CreatePostRequest.fromRawJson(String str) =>
      CreatePostRequest.fromJson(json.decode(str));
}
