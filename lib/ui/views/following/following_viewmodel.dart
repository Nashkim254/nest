import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';
import 'package:nest/services/comments_service.dart';
import 'package:nest/services/share_service.dart';
import 'package:nest/services/shared_preferences_service.dart';
import 'package:nest/services/social_service.dart';
import 'package:nest/services/user_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:video_player/video_player.dart';

import '../../../app/app.bottomsheets.dart';
import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';
import '../../../models/post_models.dart';

class FollowingViewModel extends BaseViewModel {
  VideoPlayerController? _controller;
  bool _isInitialized = false;
  String? _currentVideoUrl;
  final dialogService = locator<DialogService>();
  final bottomSheet = locator<BottomSheetService>();
  final socialService = locator<SocialService>();
  final comments = locator<CommentsService>();
  final share = locator<ShareService>();
  final userService = locator<UserService>();
  final navigationService = locator<NavigationService>();
  Logger logger = Logger();

  VideoPlayerController? get controller => _controller;
  bool get isInitialized => _isInitialized;

  int page = 1;
  int size = 10;
  List<Post> posts = [];

  // New properties for pagination and loading states
  bool _isLoadingMore = false;
  bool get isLoadingMore => _isLoadingMore;

  bool _hasMoreData = true;
  bool get hasMoreData => _hasMoreData;

  int get id => locator<SharedPreferencesService>().getUserInfo()!['id'];

  Future<void> initializeVideo(String videoUrl) async {
    if (_currentVideoUrl == videoUrl && _controller != null) return;

    await disposeVideo();

    _currentVideoUrl = videoUrl;
    _controller = VideoPlayerController.networkUrl(Uri.parse(videoUrl));

    try {
      await _controller!.initialize();
      _isInitialized = true;
      _controller!.setLooping(true);
      notifyListeners();
    } catch (e) {
      _isInitialized = false;
      notifyListeners();
    }
  }

  void playVideo() {
    if (_controller != null && _isInitialized) {
      _controller!.play();
    }
  }

  void pauseVideo() {
    if (_controller != null && _isInitialized) {
      _controller!.pause();
    }
  }

  void togglePlayPause() {
    if (_controller != null && _isInitialized) {
      if (_controller!.value.isPlaying) {
        pauseVideo();
      } else {
        playVideo();
      }
    }
  }

  Future<void> disposeVideo() async {
    if (_controller != null) {
      await _controller!.dispose();
      _controller = null;
      _isInitialized = false;
      _currentVideoUrl = null;
    }
  }

  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  void onPageChanged(int index) {
    _currentIndex = index;

    // Handle video for current post
    if (posts.isNotEmpty && index < posts.length) {
      final currentPost = posts[index];
      if (currentPost.hasVideo && currentPost.videoUrl != null) {
        initializeVideo(currentPost.videoUrl!);
      } else {
        // If current post has no video, pause any existing video
        pauseVideo();
      }
    }

    notifyListeners();
  }

  @override
  void dispose() {
    disposeVideo();
    super.dispose();
  }

  // Initialize method to load posts when view is first opened
  void initialize() async {
    await getPosts();
  }

  // Get posts from API (Following feed - posts from followed users)
  Future getPosts({bool isRefresh = false}) async {
    setBusy(true);

    // Reset pagination for refresh
    if (isRefresh) {
      page = 1;
      _hasMoreData = true;
      posts.clear();
    }

    try {
      // For following feed, we'll use getPosts but could add a filter if needed
      // If there's a separate endpoint for following feed, replace this
      final response = await socialService.getPosts(page: page, size: size);
      if (response.statusCode == 200 && response.data != null) {
        final List<dynamic> postsJson = response.data['posts'] ?? response.data;
        debugPrint('Following posts loaded successfully: ${postsJson.length}',
            wrapWidth: 1024);

        // Convert each JSON object to Post model
        final newPosts = postsJson
            .map((postJson) => Post.fromJson(postJson))
            .where((post) =>
                post.id > 0 && post.content.isNotEmpty) // Basic validation
            .toList();

        if (isRefresh) {
          posts = newPosts;
        } else {
          posts.addAll(newPosts);
        }

        // Check if there are more posts to load
        _hasMoreData = newPosts.length == size;

        notifyListeners();

        // Auto-play first video if available
        if (posts.isNotEmpty &&
            posts[0].hasVideo &&
            posts[0].videoUrl != null) {
          initializeVideo(posts[0].videoUrl!);
        }
      } else {
        throw Exception(response.message ?? 'Failed to load posts');
      }
    } catch (e, s) {
      logger.i('error: $e');
      logger.e('error: $s');
      locator<SnackbarService>().showSnackbar(
        message: 'Failed to load posts: $e',
        duration: const Duration(seconds: 3),
      );
    } finally {
      setBusy(false);
    }
  }

  // New method for pull-to-refresh
  Future<void> refreshPosts() async {
    await getPosts(isRefresh: true);
  }

  // New method for load more functionality
  Future<void> loadMorePosts() async {
    if (_isLoadingMore || !_hasMoreData) return;

    _isLoadingMore = true;
    notifyListeners();

    try {
      page++;
      final response = await socialService.getPosts(page: page, size: size);

      if (response.statusCode == 200 && response.data != null) {
        final List<dynamic> postsJson = response.data['posts'] ?? response.data;
        debugPrint(
            'More following posts loaded successfully: ${postsJson.length}',
            wrapWidth: 1024);

        // Convert and add new posts
        final newPosts = postsJson
            .map((postJson) => Post.fromJson(postJson))
            .where((post) =>
                post.id > 0 && post.content.isNotEmpty) // Basic validation
            .toList();
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

  // Fixed toggleLike method with proper Post model
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

  Future<void> toggleFollow(String postId) async {
    final post = posts.firstWhere((p) => p.id.toString() == postId,
        orElse: () => throw Exception('Post not found'));

    if (post.user?.id == null) {
      locator<SnackbarService>().showSnackbar(
        message: 'User information not available',
        duration: const Duration(seconds: 2),
      );
      return;
    }

    final userId = post.user!.id;
    final isCurrentlyFollowing = false;

    // Optimistically update the UI
    final index = posts.indexWhere((p) => p.id == post.id);
    if (index != -1) {
      notifyListeners();
    }

    try {
      final response = await userService.followUnfollowUser(
        id: userId,
        isFollow: !isCurrentlyFollowing,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        logger.i('Follow status updated successfully for user $userId');
        locator<SnackbarService>().showSnackbar(
          message: !isCurrentlyFollowing ? 'Following user' : 'Unfollowed user',
          duration: const Duration(seconds: 2),
        );
      } else {
        // Revert optimistic update on failure
        if (index != -1) {
          notifyListeners();
        }
        throw Exception('Failed to update follow status');
      }
    } catch (e) {
      // Revert optimistic update on error
      if (index != -1) {
        notifyListeners();
      }

      logger.e('Follow toggle error: $e');
      locator<SnackbarService>().showSnackbar(
        message: 'Failed to update follow status',
        duration: const Duration(seconds: 2),
      );
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

  void repost(String postId) {
    // Implementation for sharing post
  }

  void navigateToProfile(int userId) {
    print('Navigating to profile of userId: $userId');
    print(
        'Current userId: ${locator<SharedPreferencesService>().getUserInfo()!['id']}');
    // navigationService.navigateToProfileView(
    //   isOtherUser: userId ==
    //           int.parse(locator<SharedPreferencesService>()
    //               .getUserInfo()!['id']
    //               .toString())
    //       ? false
    //       : true,
    // );
  }
}
