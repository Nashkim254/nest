import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:video_player/video_player.dart';
import '../../../models/post_models.dart';

class VideoPlayerViewModel extends BaseViewModel {
  VideoPlayerController? _controller;
  bool _isInitialized = false;
  bool _hasError = false;
  String _errorMessage = '';
  Logger logger = Logger();

  VideoPlayerController? get controller => _controller;
  bool get isInitialized => _isInitialized;
  bool get isPlaying => _controller?.value.isPlaying ?? false;
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
      _controller = VideoPlayerController.network(post.videoUrl!);
      
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

  Future<void> retry() async {
    // This will be called from the view with the post data
    // The view should call initializeVideo again
    _hasError = false;
    _errorMessage = '';
    notifyListeners();
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

  @override
  void dispose() {
    _disposeController();
    super.dispose();
  }
}