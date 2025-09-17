import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:video_player/video_player.dart';
import '../../../app/app.bottomsheets.dart';
import '../../../app/app.locator.dart';
import '../../../models/post_models.dart';
import '../../../services/comments_service.dart';
import '../../../services/share_service.dart';

class VideoPlayerViewModel extends BaseViewModel {
  VideoPlayerController? _controller;
  bool _isInitialized = false;
  bool _hasError = false;
  String _errorMessage = '';
  Logger logger = Logger();

  final comments = locator<CommentsService>();
  final bottomSheet = locator<BottomSheetService>();

  VideoPlayerController? get controller => _controller;
  bool get isInitialized => _isInitialized;
  bool get isPlaying => _controller?.value.isPlaying ?? false;
  @override
  bool get hasError => _hasError;
  String get errorMessage => _errorMessage;

  Future<void> initializeVideo(Post post) async {
    setBusy(true);
    _hasError = false;
    _errorMessage = '';
    
    try {
      // Check if video is ready and has URL
      if (!post.videoReady || post.videoUrl == null || post.videoUrl!.isEmpty) {
        throw Exception('Video is not ready or URL is missing');
      }

      logger.i('Initializing video player for URL: ${post.videoUrl}');
      
      // Dispose existing controller if any
      await _disposeController();

      // Create new controller
      _controller = VideoPlayerController.networkUrl(Uri.parse(post.videoUrl!));
      
      // Initialize the controller
      await _controller!.initialize();
      
      _isInitialized = true;
      
      // Auto-play the video
      await _controller!.play();
      
      logger.i('Video initialized and playing');
      
    } catch (e) {
      logger.e('Failed to initialize video: $e');
      _hasError = true;
      _errorMessage = _getErrorMessage(e);
      _isInitialized = false;
    } finally {
      setBusy(false);
      notifyListeners();
    }
  }

  String _getErrorMessage(dynamic error) {
    if (error.toString().contains('not ready')) {
      return 'Video is still processing. Please try again later.';
    } else if (error.toString().contains('network')) {
      return 'Network error. Please check your connection.';
    } else if (error.toString().contains('format')) {
      return 'Video format not supported.';
    } else {
      return 'Failed to load video. Please try again.';
    }
  }

  Future<void> togglePlayPause() async {
    if (_controller == null || !_isInitialized) return;

    try {
      if (_controller!.value.isPlaying) {
        await _controller!.pause();
      } else {
        await _controller!.play();
      }
      notifyListeners();
    } catch (e) {
      logger.e('Error toggling play/pause: $e');
    }
  }

  Future<void> retry(Post post) async {
    // Reset error state and reinitialize
    _hasError = false;
    _errorMessage = '';
    notifyListeners();

    // Reinitialize the video
    await initializeVideo(post);
  }

  Future<void> _disposeController() async {
    if (_controller != null) {
      try {
        await _controller!.pause();
        await _controller!.dispose();
      } catch (e) {
        logger.w('Error disposing video controller: $e');
      } finally {
        _controller = null;
        _isInitialized = false;
      }
    }
  }

  // Like functionality
  Future<void> toggleLike(Post post) async {
    try {
      final response = await comments.toggleLikePost(post.id);
      if (response.statusCode == 200 || response.statusCode == 201) {
        // Show feedback - in a real implementation, you'd update the post state
        locator<SnackbarService>().showSnackbar(
          message: post.isLiked ? 'Unliked' : 'Liked',
          duration: const Duration(seconds: 1),
        );
      }
    } catch (e) {
      logger.e('Error toggling like: $e');
      locator<SnackbarService>().showSnackbar(
        message: 'Failed to update like status',
        duration: const Duration(seconds: 2),
      );
    }
  }

  // Comment functionality
  Future<void> openComments(Post post) async {
    final result = await bottomSheet.showCustomSheet(
      variant: BottomSheetType.comments,
      title: 'Comments',
      data: post.id.toString(),
      isScrollControlled: true,
    );
    if (result != null && result.confirmed) {
      // Handle any comment actions if needed
    }
    notifyListeners();
  }

  // Share functionality
  void sharePost(Post post) {
    ShareService.sharePost(
      postId: post.id.toString(),
      title: post.content,
      description: post.content,
      imageUrl: post.videoThumbnail,
    );
  }

  @override
  void dispose() {
    _disposeController();
    super.dispose();
  }
}