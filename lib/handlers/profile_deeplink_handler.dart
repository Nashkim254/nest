import '../abstractClasses/deep_link_handler_interface.dart';

class ProfileDeepLinkHandler implements DeepLinkHandler {
  final Function(String userId) onProfileRequested;

  ProfileDeepLinkHandler({required this.onProfileRequested});

  @override
  bool canHandle(Uri uri) {
    return uri.path.startsWith('/profile/') ||
        uri.queryParameters.containsKey('user_id');
  }

  @override
  void handle(Uri uri) {
    String? userId;

    if (uri.path.startsWith('/profile/')) {
      userId = uri.pathSegments[1];
    } else {
      userId = uri.queryParameters['user_id'];
    }

    if (userId != null && userId.isNotEmpty) {
      onProfileRequested(userId);
    }
  }
}