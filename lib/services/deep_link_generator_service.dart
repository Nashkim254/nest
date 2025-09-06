import 'dart:convert';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:nest/app/app.locator.dart';
import 'package:nest/services/api_service.dart';

class DeepLinkGeneratorService {
  static const String baseUrl = 'com.example.nest'; // Your domain
  static const String shortDomain =
      'com.example.nest'; // Short domain for links
  static final apiService = locator<ApiService>();
  // Generate post sharing link
  static Future<String> generatePostLink({
    required String postId,
    String? title,
    String? description,
    String? imageUrl,
    bool useShortLink = false,
  }) async {
    final Map<String, dynamic> linkData = {
      'type': 'post',
      'post_id': postId,
      'title': title,
      'description': description,
      'image_url': imageUrl,
      'created_at': DateTime.now().toIso8601String(),
    };

    if (useShortLink) {
      return await _createShortLink(linkData);
    } else {
      return _createDirectLink(linkData);
    }
  }

  // Generate verification link
  static Future<String> generateVerificationLink({
    required String email,
    required String token,
    int? expiryHours = 24,
    bool useShortLink = false,
  }) async {
    final Map<String, dynamic> linkData = {
      'type': 'verification',
      'email': email,
      'token': token,
      'expires_at': DateTime.now()
          .add(Duration(hours: expiryHours ?? 24))
          .toIso8601String(),
    };

    if (useShortLink) {
      return await _createShortLink(linkData);
    } else {
      return _createDirectLink(linkData);
    }
  }

  // Generate event sharing link
  static Future<String> generateEventLink({
    required String eventId,
    String? title,
    String? description,
    String? imageUrl,
    bool useShortLink = false,
  }) async {
    final Map<String, dynamic> linkData = {
      'type': 'event',
      'event_id': eventId,
      'title': title,
      'description': description,
      'image_url': imageUrl,
      'created_at': DateTime.now().toIso8601String(),
    };

    if (useShortLink) {
      return await _createShortLink(linkData);
    } else {
      return _createDirectLink(linkData);
    }
  }

  // Generate profile sharing link
  static Future<String> generateProfileLink({
    required String userId,
    String? username,
    String? profileName,
    String? profilePicture,
    bool useShortLink = false,
  }) async {
    final Map<String, dynamic> linkData = {
      'type': 'profile',
      'user_id': userId,
      'username': username,
      'profile_name': profileName,
      'profile_picture': profilePicture,
      'created_at': DateTime.now().toIso8601String(),
    };

    if (useShortLink) {
      return await _createShortLink(linkData);
    } else {
      return _createDirectLink(linkData);
    }
  }

  // Create direct link (no backend required)
  static String _createDirectLink(Map<String, dynamic> linkData) {
    final String encodedData = base64Url
        .encode(utf8.encode(jsonEncode(linkData)))
        .replaceAll('=', ''); // Remove padding

    final String type = linkData['type'] ?? 'post';
    
    switch (type) {
      case 'post':
        return '$baseUrl://post/${linkData['post_id']}';
      case 'event':
        return '$baseUrl://event/${linkData['event_id']}';
      case 'profile':
        return '$baseUrl://profile/${linkData['user_id']}';
      case 'verification':
        return '$baseUrl://verify?token=${linkData['token']}&email=${linkData['email']}';
      default:
        return '$baseUrl://post/${linkData['post_id']}';
    }
  }

  // Create short link (requires backend)
  static Future<String> _createShortLink(Map<String, dynamic> linkData) async {
    try {
      final response = await apiService.post(
        '$baseUrl/api/links/create',
        headers: {'Content-Type': 'application/json'},
        data: jsonEncode(linkData),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.data);
        return data['short_url'] ?? _createDirectLink(linkData);
      }
    } catch (e) {
      debugPrint('Failed to create short link: $e');
    }

    // Fallback to direct link
    return _createDirectLink(linkData);
  }

  // Generate random short ID
  static String _generateShortId({int length = 8}) {
    const chars =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = Random();
    return String.fromCharCodes(Iterable.generate(
        length, (_) => chars.codeUnitAt(random.nextInt(chars.length))));
  }
}
