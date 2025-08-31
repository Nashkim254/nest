import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'dart:io';

// First, create a separate VideoThumbnail widget
class VideoThumbnailWidget extends StatefulWidget {
  final File videoFile;

  const VideoThumbnailWidget({Key? key, required this.videoFile}) : super(key: key);

  @override
  State<VideoThumbnailWidget> createState() => _VideoThumbnailWidgetState();
}

class _VideoThumbnailWidgetState extends State<VideoThumbnailWidget> {
  VideoPlayerController? _controller;
  bool _isInitialized = false;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _initializeVideo();
  }

  Future<void> _initializeVideo() async {
    try {
      _controller = VideoPlayerController.file(widget.videoFile);
      await _controller!.initialize();

      // Seek to 1 second to get a good thumbnail frame
      if (_controller!.value.duration.inSeconds > 1) {
        await _controller!.seekTo(const Duration(seconds: 1));
      }

      if (mounted) {
        setState(() {
          _isInitialized = true;
        });
      }
    } catch (e) {
      print('Error initializing video: $e');
      if (mounted) {
        setState(() {
          _hasError = true;
        });
      }
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_hasError) {
      return Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.grey[300],
        child: const Center(
          child: Icon(
            Icons.error_outline,
            size: 40,
            color: Colors.grey,
          ),
        ),
      );
    }

    if (!_isInitialized || _controller == null) {
      return Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.grey[300],
        child: const Center(
          child: CircularProgressIndicator(
            strokeWidth: 2,
          ),
        ),
      );
    }

    return Stack(
      children: [
        SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: FittedBox(
            fit: BoxFit.cover,
            child: SizedBox(
              width: _controller!.value.size.width,
              height: _controller!.value.size.height,
              child: VideoPlayer(_controller!),
            ),
          ),
        ),
        // Play button overlay
        const Positioned.fill(
          child: Center(
            child: Icon(
              Icons.play_circle_outline,
              size: 30,
              color: Colors.white,
              shadows: [
                Shadow(
                  blurRadius: 4,
                  color: Colors.black54,
                ),
              ],
            ),
          ),
        ),
        // Video indicator in corner
        const Positioned(
          bottom: 4,
          left: 4,
          child: Icon(
            Icons.videocam,
            color: Colors.white,
            size: 16,
            shadows: [
              Shadow(
                blurRadius: 2,
                color: Colors.black54,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
