import 'package:flutter/material.dart';
import 'package:nest/ui/common/app_colors.dart';
import 'package:stacked/stacked.dart';
import 'package:video_player/video_player.dart';

import '../discover_viewmodel.dart';

class VideoPlayerWidget extends StackedView<DiscoverViewModel> {
  final String videoUrl;
  final bool isVisible;

  const VideoPlayerWidget({
    Key? key,
    required this.videoUrl,
    required this.isVisible,
  }) : super(key: key);

  @override
  Widget builder(
      BuildContext context, DiscoverViewModel viewModel, Widget? child) {
    // Initialize video when widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      viewModel.initializeVideo(videoUrl);

      // Handle visibility changes
      if (isVisible && viewModel.isInitialized) {
        viewModel.playVideo();
      } else if (!isVisible && viewModel.isInitialized) {
        viewModel.pauseVideo();
      }
    });

    if (!viewModel.isInitialized || viewModel.controller == null) {
      return Container(
        color: kcDarkColor,
        child: const Center(
          child: CircularProgressIndicator(color: kcPrimaryColor),
        ),
      );
    }

    return GestureDetector(
      onTap: viewModel.togglePlayPause,
      child: SizedBox.expand(
        child: FittedBox(
          fit: BoxFit.cover,
          child: SizedBox(
            width: viewModel.controller!.value.size.width,
            height: viewModel.controller!.value.size.height,
            child: VideoPlayer(viewModel.controller!),
          ),
        ),
      ),
    );
  }

  @override
  DiscoverViewModel viewModelBuilder(BuildContext context) =>
      DiscoverViewModel();
}
