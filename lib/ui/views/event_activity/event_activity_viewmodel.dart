import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:nest/services/comments_service.dart';
import 'package:nest/services/share_service.dart';
import 'package:nest/services/shared_preferences_service.dart';
import 'package:nest/services/social_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.bottomsheets.dart';
import '../../../app/app.locator.dart';
import '../../../models/post_models.dart';

class EventActivityViewModel extends BaseViewModel {
  final bottomSheet = locator<BottomSheetService>();
  final comments = locator<CommentsService>();
  final socialService = locator<SocialService>();
  final share = locator<ShareService>();

  int page = 1;
  int size = 10;
  List<Post> posts = [];
  Logger logger = Logger();
  int get id => locator<SharedPreferencesService>().getUserInfo()!['id'];

  // New properties for pagination and loading states
  bool _isLoadingMore = false;
  bool get isLoadingMore => _isLoadingMore;

  bool _hasMoreData = true;
  bool get hasMoreData => _hasMoreData;

  // Modified getUserPosts method to support pagination
  Future getUserPosts({bool isRefresh = false}) async {
    setBusy(true);

    // Reset pagination for refresh
    if (isRefresh) {
      page = 1;
      _hasMoreData = true;
      posts.clear();
    }

    try {
      final response =
          await socialService.getUserPosts(page: page, size: size, id: id);
      if (response.statusCode == 200 && response.data != null) {
        final List<dynamic> postsJson = response.data['posts'];
        debugPrint('User posts loaded successfully: ${response.data}',
            wrapWidth: 1024);

        // Convert each JSON object to Post model
        final newPosts =
            postsJson.map((postJson) => Post.fromJson(postJson)).toList();

        if (isRefresh) {
          posts = newPosts;
        } else {
          posts.addAll(newPosts);
        }

        // Check if there are more posts to load
        _hasMoreData = newPosts.length == size;

        notifyListeners();
      } else {
        throw Exception(response.message ?? 'Failed to load user posts');
      }
    } catch (e, s) {
      logger.i('error: $e');
      logger.e('error: $s');
      locator<SnackbarService>().showSnackbar(
        message: 'Failed to load user posts: $e',
        duration: const Duration(seconds: 3),
      );
    } finally {
      setBusy(false);
    }
  }

  // New method for pull-to-refresh
  Future<void> refreshPosts() async {
    await getUserPosts(isRefresh: true);
  }

  // New method for load more functionality
  Future<void> loadMorePosts() async {
    if (_isLoadingMore || !_hasMoreData) return;

    _isLoadingMore = true;
    notifyListeners();

    try {
      page++;
      final response =
          await socialService.getUserPosts(page: page, size: size, id: id);

      if (response.statusCode == 200 && response.data != null) {
        final List<dynamic> postsJson = response.data['posts'];
        debugPrint('More posts loaded successfully: ${postsJson.length}',
            wrapWidth: 1024);

        // Convert and add new posts
        final newPosts =
            postsJson.map((postJson) => Post.fromJson(postJson)).toList();
        posts.addAll(newPosts);

        // Check if there are more posts to load
        _hasMoreData = newPosts.length == size;

        notifyListeners();
      } else {
        // If failed, decrement page to retry later
        page--;
        throw Exception(response.message ?? 'Failed to load more posts');
      }
    } catch (e, s) {
      logger.i('Load more error: $e');
      logger.e('Load more error: $s');

      // Decrement page on error
      page--;

      locator<SnackbarService>().showSnackbar(
        message: 'Failed to load more posts: $e',
        duration: const Duration(seconds: 3),
      );
    } finally {
      _isLoadingMore = false;
      notifyListeners();
    }
  }

  // Fixed toggleLike method for your EventActivityViewModel

  toggleLike(Post post) async {
    // Optimistically update the UI first for better UX
    final index = posts.indexWhere((p) => p.id == post.id);
    if (index != -1) {
      posts[index] = posts[index].copyWith(
        isLiked: !posts[index].isLiked,
        likeCount: posts[index].isLiked
            ? posts[index].likeCount - 1
            : posts[index].likeCount + 1,
      );
      notifyListeners();
    }

    try {
      final response = await comments.toggleLikePost(post.id);
      if (response.statusCode == 200 || response.statusCode == 201) {
        // Success - UI already updated optimistically
        logger.i('Like toggled successfully for post ${post.id}');
      } else {
        // Revert the optimistic update on failure
        if (index != -1) {
          posts[index] = posts[index].copyWith(
            isLiked: !posts[index].isLiked,
            likeCount: posts[index].isLiked
                ? posts[index].likeCount - 1
                : posts[index].likeCount + 1,
          );
          notifyListeners();
        }
        throw Exception('Failed to toggle like on post');
      }
    } catch (e) {
      // Revert the optimistic update on error
      if (index != -1) {
        posts[index] = posts[index].copyWith(
          isLiked: !posts[index].isLiked,
          likeCount: posts[index].isLiked
              ? posts[index].likeCount - 1
              : posts[index].likeCount + 1,
        );
        notifyListeners();
      }

      if (kDebugMode) {
        print('Like toggle error: $e');
      }
      locator<SnackbarService>().showSnackbar(
        message: 'Failed to update like',
        duration: const Duration(seconds: 2),
      );
    }
  }

  // Your existing methods remain the same
  Future<void> _loadComments(int id) async {
    setBusy(true);
    try {
      final response = await comments.getComments(id);
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (kDebugMode) {
          debugPrint("Loaded ${response.data}", wrapWidth: 1024);
        }
        final List<dynamic> data = response.data ?? [];
      } else {
        throw Exception('Failed to load comments');
      }
      rebuildUi();
    } catch (error) {
      setError(error);
    } finally {
      setBusy(false);
    }
  }

  Future openComments(int id) async {
    final result = await bottomSheet.showCustomSheet(
      variant: BottomSheetType.comments,
      title: 'Comments',
      data: id.toString(),
      isScrollControlled: true,
    );
    if (result != null && result.confirmed) {}
    notifyListeners();
  }

  sharePost(Post post) {
    ShareService.sharePost(
        postId: post.id.toString(),
        title: post.content,
        description: post.content,
        imageUrl: post.imageUrls.isNotEmpty ? post.imageUrls[0] : null);
  }

  editPost(int id) {}
}
