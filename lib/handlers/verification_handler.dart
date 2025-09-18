import '../abstractClasses/deep_link_handler_interface.dart';

class VerificationDeepLinkHandler implements DeepLinkHandler {
  final Function(String token, String? email) onVerificationRequested;

  VerificationDeepLinkHandler({required this.onVerificationRequested});

  @override
  bool canHandle(Uri uri) {
    print('VerificationHandler checking URI: ${uri.toString()}');
    print('Path: ${uri.path}');
    print('Query params: ${uri.queryParameters}');

    final canHandle =
        uri.path.contains('/verify-email');

    print('Can handle: $canHandle');
    return canHandle;
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
