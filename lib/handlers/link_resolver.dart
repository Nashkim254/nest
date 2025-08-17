import 'dart:convert';

import 'package:flutter/foundation.dart';

import '../app/app.locator.dart';
import '../services/api_service.dart';
import '../services/deep_link_generator_service.dart';

class LinkResolver {
  static final apiService = locator<ApiService>();
  static final deepLinkGenerator = locator<DeepLinkGeneratorService>();

  static Future<Map<String, dynamic>?> resolveLink(Uri uri) async {
    // Handle direct encoded links
    final String? encodedData = uri.queryParameters['data'];
    if (encodedData != null) {
      return _decodeDirectLink(encodedData);
    }

    // Handle short links (requires backend call)
    if (uri.host.contains('yourap.co')) {
      return await _resolveShortLink(uri);
    }

    // Handle legacy format
    return _resolveLegacyLink(uri);
  }

  static Map<String, dynamic>? _decodeDirectLink(String encodedData) {
    try {
      final String jsonData = utf8.decode(base64Url.decode(encodedData));
      return jsonDecode(jsonData);
    } catch (e) {
      debugPrint('Failed to decode link data: $e');
      return null;
    }
  }

  static Future<Map<String, dynamic>?> _resolveShortLink(Uri uri) async {
    try {
      final response = await apiService.get(
          '${DeepLinkGeneratorService.baseUrl}/api/links/resolve${uri.path}');

      if (response.statusCode == 200) {
        return jsonDecode(response.data);
      }
    } catch (e) {
      debugPrint('Failed to resolve short link: $e');
    }
    return null;
  }

  static Map<String, dynamic>? _resolveLegacyLink(Uri uri) {
    if (uri.path.startsWith('/post/')) {
      return {
        'type': 'post',
        'post_id': uri.pathSegments[1],
      };
    }

    if (uri.path.startsWith('/verify')) {
      return {
        'type': 'verification',
        'token': uri.queryParameters['token'],
        'email': uri.queryParameters['email'],
      };
    }

    return null;
  }
}
