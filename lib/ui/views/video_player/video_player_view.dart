import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:video_player/video_player.dart';
import '../../common/app_colors.dart';
import '../../../models/post_models.dart';
import 'video_player_viewmodel.dart';

class VideoPlayerView extends StackedView<VideoPlayerViewModel> {
  final Post post;
  
  const VideoPlayerView({Key? key, required this.post}) : super(key: key);

  @override
  Widget builder(BuildContext context, VideoPlayerViewModel viewModel, Widget? child) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.close, color: Colors.white),
        ),
        title: Text(
          post.user?.displayName ?? 'Video',
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: viewModel.isInitialized && viewModel.controller != null
            ? GestureDetector(
                onTap: viewModel.togglePlayPause,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    AspectRatio(
                      aspectRatio: viewModel.controller!.value.aspectRatio,
                      child: VideoPlayer(viewModel.controller!),
                    ),
                    // Play/Pause overlay
                    if (!viewModel.isPlaying)
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.3),
                          shape: BoxShape.circle,
                        ),
                        padding: const EdgeInsets.all(20),
                        child: const Icon(
                          Icons.play_arrow,
                          color: Colors.white,
                          size: 60,
                        ),
                      ),
                    // Loading indicator
                    if (viewModel.isBusy)
                      const CircularProgressIndicator(
                        color: kcPrimaryColor,
                      ),
                  ],
                ),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (viewModel.hasError)
                    Column(
                      children: [
                        const Icon(
                          Icons.error_outline,
                          color: Colors.white,
                          size: 60,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          viewModel.errorMessage,
                          style: const TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: viewModel.retry,
                          child: const Text('Retry'),
                        ),
                      ],
                    )
                  else
                    Column(
                      children: [
                        const CircularProgressIndicator(
                          color: kcPrimaryColor,
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Loading video...',
                          style: TextStyle(color: Colors.white),
                        ),
                        if (!post.videoReady)
                          const Padding(
                            padding: EdgeInsets.only(top: 8.0),
                            child: Text(
                              'Video is still processing',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                              ),
                            ),
                          ),
                      ],
                    ),
                ],
              ),
      ),
      // Video controls at bottom
      bottomNavigationBar: viewModel.isInitialized && viewModel.controller != null
          ? Container(
              color: Colors.black.withOpacity(0.7),
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Video progress bar
                  VideoProgressIndicator(
                    viewModel.controller!,
                    allowScrubbing: true,
                    colors: const VideoProgressColors(
                      playedColor: kcPrimaryColor,
                      bufferedColor: Colors.grey,
                      backgroundColor: Colors.white24,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Post content
                  if (post.content.isNotEmpty)
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        post.content,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ),
                ],
              ),
            )
          : null,
    );
  }

  @override
  void onViewModelReady(VideoPlayerViewModel viewModel) {
    viewModel.initializeVideo(post);
    super.onViewModelReady(viewModel);
  }

  @override
  VideoPlayerViewModel viewModelBuilder(BuildContext context) => VideoPlayerViewModel();
}