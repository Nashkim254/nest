import '../abstractClasses/deep_link_handler_interface.dart';

class EventDeepLinkHandler implements DeepLinkHandler {
  final Function(String eventId) onEventRequested;

  EventDeepLinkHandler({required this.onEventRequested});

  @override
  bool canHandle(Uri uri) {
    return uri.path.startsWith('/event/') ||
        uri.queryParameters.containsKey('event_id');
  }

  @override
  void handle(Uri uri) {
    String? eventId;

    if (uri.path.startsWith('/event/')) {
      eventId = uri.pathSegments[1];
    } else {
      eventId = uri.queryParameters['event_id'];
    }

    if (eventId != null && eventId.isNotEmpty) {
      onEventRequested(eventId);
    }
  }
}