import '../abstractClasses/deep_link_handler_interface.dart';

class PostDeepLinkHandler implements DeepLinkHandler {
  final Future<void> Function(String postId) onPostRequested;

  PostDeepLinkHandler({required this.onPostRequested});

  @override
  bool canHandle(Uri uri) {
    return uri.path.startsWith('/post/') ||
        uri.queryParameters.containsKey('post_id');
  }

  @override
  void handle(Uri uri) {
    String? postId;

    if (uri.path.startsWith('/post/')) {
      postId = uri.pathSegments[1];
    } else {
      postId = uri.queryParameters['post_id'];
    }

    if (postId != null && postId.isNotEmpty) {
      // Call the async function without awaiting since handle() must be void
      onPostRequested(postId);
    }
  }
}
