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

  // Share event functionality
  static Future<void> shareEvent({
    required String eventId,
    required String title,
    String? description,
    String? imageUrl,
  }) async {
    try {
      final String link = await DeepLinkGeneratorService.generateEventLink(
        eventId: eventId,
        title: title,
        description: description,
        imageUrl: imageUrl,
      );

      await SharePlus.instance.share(ShareParams(
        text: 'Check out this event: $title\n$link',
        subject: 'Event: $title',
      ));
    } catch (e) {
      debugPrint('Error sharing event: $e');
    }
  }

  // Share profile functionality
  static Future<void> shareProfile({
    required String userId,
    required String profileName,
    String? username,
    String? profilePicture,
  }) async {
    try {
      final String link = await DeepLinkGeneratorService.generateProfileLink(
        userId: userId,
        username: username,
        profileName: profileName,
        profilePicture: profilePicture,
      );

      await SharePlus.instance.share(ShareParams(
        text: 'Check out $profileName\'s profile\n$link',
        subject: '$profileName\'s Profile',
      ));
    } catch (e) {
      debugPrint('Error sharing profile: $e');
    }
  }

  // Get event share link
  getShareEventLink({
    required String eventId,
    required String title,
    String? description,
    String? imageUrl,
  }) async {
    try {
      final String link = await DeepLinkGeneratorService.generateEventLink(
        eventId: eventId,
        title: title,
        description: description,
        imageUrl: imageUrl,
      );
      return link;
    } catch (e) {
      debugPrint('Error getting event link: $e');
      return null;
    }
  }

  // Get profile share link
  getShareProfileLink({
    required String userId,
    required String profileName,
    String? username,
    String? profilePicture,
  }) async {
    try {
      final String link = await DeepLinkGeneratorService.generateProfileLink(
        userId: userId,
        username: username,
        profileName: profileName,
        profilePicture: profilePicture,
      );
      return link;
    } catch (e) {
      debugPrint('Error getting profile link: $e');
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
