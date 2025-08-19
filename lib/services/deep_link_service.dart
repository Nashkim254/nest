import 'package:app_links/app_links.dart';
import 'package:logger/logger.dart';

import '../abstractClasses/deep_link_handler_interface.dart';

class DeepLinkService {
  final AppLinks _appLinks = AppLinks();
  final List<DeepLinkHandler> _handlers = [];

  Future<void> initialize() async {
    // Handle incoming links when app is already running
    _appLinks.uriLinkStream.listen(
      (uri) => _handleIncomingLink(uri),
      onError: (err) => Logger().e('Deep link error: $err'),
    );

    // Handle link when app is launched
    try {
      final Uri? initialUri = await _appLinks.getInitialLink();
      if (initialUri != null) {
        _handleIncomingLink(initialUri);
      }
    } catch (e) {
      Logger().e('Failed to get initial link: $e');
    }
  }

  void registerHandler(DeepLinkHandler handler) {
    _handlers.add(handler);
  }

  void _handleIncomingLink(Uri uri) {
    Logger().i('Handling deep link: $uri');

    for (final handler in _handlers) {
      if (handler.canHandle(uri)) {
        handler.handle(uri);
        return;
      }
    }

    Logger().w('No handler found for: $uri');
  }
}
