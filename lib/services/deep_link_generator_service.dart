import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:nest/app/app.locator.dart';
import 'package:nest/services/api_service.dart';

class DeepLinkGeneratorService {
  static const String baseUrl = 'https://api.nesthaps.com'; // Your web domain
  static const String shortDomain = 'https://api.nesthaps.com'; // Short domain for links
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

  // Create direct link (web URLs that are clickable everywhere)
  static String _createDirectLink(Map<String, dynamic> linkData) {
    final String type = linkData['type'] ?? 'post';
    
    switch (type) {
      case 'post':
        return '$baseUrl/post/${linkData['post_id']}';
      case 'event':
        return '$baseUrl/event/${linkData['event_id']}';
      case 'profile':
        return '$baseUrl/user/${linkData['user_id']}';
      case 'verification':
        return '$baseUrl/verify?token=${linkData['token']}&email=${linkData['email']}';
      default:
        return '$baseUrl/post/${linkData['post_id']}';
    }
  }

  // Create short link (requires backend API)
  static Future<String> _createShortLink(Map<String, dynamic> linkData) async {
    try {
      final response = await apiService.post(
        '/links/create', // Use your API service which already has the base URL
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
}
