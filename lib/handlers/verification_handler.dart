import '../abstractClasses/deep_link_handler_interface.dart';

class VerificationDeepLinkHandler implements DeepLinkHandler {
  final Function(String token, String? email) onVerificationRequested;

  VerificationDeepLinkHandler({required this.onVerificationRequested});

  @override
  bool canHandle(Uri uri) {
    return uri.path.startsWith('/verify') ||
        uri.queryParameters.containsKey('verification_token');
  }

  @override
  void handle(Uri uri) {
    final String? token = uri.queryParameters['token'] ??
        uri.queryParameters['verification_token'];
    final String? email = uri.queryParameters['email'];

    if (token != null && token.isNotEmpty) {
      onVerificationRequested(token, email);
    }
  }
}
