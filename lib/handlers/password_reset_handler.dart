import '../abstractClasses/deep_link_handler_interface.dart';

class PasswordResetDeepLinkHandler implements DeepLinkHandler {
  final Function(String token) onPasswordResetRequested;

  PasswordResetDeepLinkHandler({required this.onPasswordResetRequested});

  @override
  bool canHandle(Uri uri) {
    print('PasswordResetHandler checking URI: ${uri.toString()}');
    print('Path: ${uri.path}');
    print('Query params: ${uri.queryParameters}');

    final canHandle =
        uri.path.contains('/reset-password') ||
        uri.path.contains('/password-reset') ||
        uri.queryParameters.containsKey('reset_token') ||
        uri.queryParameters.containsKey('token');

    print('Can handle: $canHandle');
    return canHandle;
  }

  @override
  void handle(Uri uri) {
    final String? token = uri.queryParameters['token'] ??
        uri.queryParameters['reset_token'];

    if (token != null && token.isNotEmpty) {
      onPasswordResetRequested(token);
    }
  }
}