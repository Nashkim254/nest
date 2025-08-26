import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:nest/services/deep_link_generator_service.dart';
import 'package:share_plus/share_plus.dart';

class ShareService {
  copyToClipboard(String resource) {
    Clipboard.setData(ClipboardData(text: resource));
  }

  static Future<void> sharePost({
    required String postId,
    required String title,
    String? description,
    String? imageUrl,
  }) async {
    try {
      final String link = await DeepLinkGeneratorService.generatePostLink(
        postId: postId,
        title: title,
        description: description,
        imageUrl: imageUrl,
      );

      await SharePlus.instance.share(ShareParams(
        text: link,
        subject: title,
      ));
    } catch (e) {
      debugPrint('Error sharing post: $e');
    }
  }

  getSharePostLink(
      {required String postId,
      required String title,
      String? description,
      String? imageUrl}) async {
    try {
      final String link = await DeepLinkGeneratorService.generatePostLink(
        postId: postId,
        title: title,
        description: description,
        imageUrl: imageUrl,
      );
      return link;
    } catch (e) {
      debugPrint('Error sharing post: $e');
      return null;
    }
  }

  static Future<void> shareVerificationLink({
    required String email,
    required String token,
  }) async {
    try {
      final String link =
          await DeepLinkGeneratorService.generateVerificationLink(
        email: email,
        token: token,
      );

      await SharePlus.instance.share(ShareParams(
        text: 'Verify your account: $link',
        subject: 'Account Verification',
      ));
    } catch (e) {
      debugPrint('Error sharing verification link: $e');
    }
  }
}
