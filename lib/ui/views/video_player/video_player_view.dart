import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stacked/stacked.dart';
import 'package:video_player/video_player.dart';
import '../../common/app_colors.dart';
import '../../common/app_strings.dart';
import '../../common/app_styles.dart';
import '../../common/ui_helpers.dart';
import '../../../models/post_models.dart';
import '../../../utils/utilities.dart';
import 'video_player_viewmodel.dart';

class VideoPlayerView extends StackedView<VideoPlayerViewModel> {
  final Post post;
  
  const VideoPlayerView({Key? key, required this.post}) : super(key: key);

  @override
  Widget builder(BuildContext context, VideoPlayerViewModel viewModel, Widget? child) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kcDarkColor,
        appBar: AppBar(
          backgroundColor: kcDarkColor,
          elevation: 0,
          leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.arrow_back, color: kcWhiteColor),
          ),
          title: Text(
            'Video Post',
            style: titleTextMedium.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: kcWhiteColor,
            ),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            decoration: BoxDecoration(
              color: kcDarkGreyColor,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: kcContainerBorderColor),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header: profile image, name, time
                Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(post.user?.profilePicture ?? ''),
                        radius: 20,
                      ),
                      horizontalSpaceSmall,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              post.user?.displayName ?? 'Unknown User',
                              style: titleTextMedium.copyWith(color: kcWhiteColor),
                            ),
                            Text(
                              formatter.format(post.safeUpdatedAt),
                              style: bodyTextMedium.copyWith(color: kcFollowColor),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Video Section
                Container(
                  height: 300,
                  width: double.infinity,
                  color: Colors.black,
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
                      : Center(
                          child: viewModel.hasError
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
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
                                      onPressed: () => viewModel.retry(post),
                                      child: const Text('Retry'),
                                    ),
                                  ],
                                )
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
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
                        ),
                ),

                // Video Progress Bar
                if (viewModel.isInitialized && viewModel.controller != null)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    child: VideoProgressIndicator(
                      viewModel.controller!,
                      allowScrubbing: true,
                      colors: const VideoProgressColors(
                        playedColor: kcPrimaryColor,
                        bufferedColor: Colors.grey,
                        backgroundColor: Colors.white24,
                      ),
                    ),
                  ),

                // Action Buttons (Like, Comment, Share)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  child: Row(
                    children: [
                      // Like button
                      GestureDetector(
                        onTap: () => viewModel.toggleLike(post),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(
                              like,
                              color: post.isLiked ? kcPrimaryColor : kcWhiteColor,
                              width: 24,
                              height: 24,
                            ),
                            if (post.likeCount > 0) ...[
                              const SizedBox(width: 4),
                              Text(
                                '${post.likeCount}',
                                style: bodyTextMedium.copyWith(
                                  color: post.isLiked ? kcPrimaryColor : kcWhiteColor,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                      horizontalSpaceMedium,
                      // Comment button
                      GestureDetector(
                        onTap: () => viewModel.openComments(post),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(
                              comment,
                              color: kcWhiteColor,
                              width: 24,
                              height: 24,
                            ),
                            if (post.commentCount > 0) ...[
                              const SizedBox(width: 4),
                              Text(
                                '${post.commentCount}',
                                style: bodyTextMedium.copyWith(
                                  color: kcWhiteColor,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                      horizontalSpaceMedium,
                      // Share button
                      GestureDetector(
                        onTap: () => viewModel.sharePost(post),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SvgPicture.asset(
                              send,
                              color: kcWhiteColor,
                              width: 24,
                              height: 24,
                            ),
                            if (post.shareCount > 0) ...[
                              const SizedBox(width: 4),
                              Text(
                                '${post.shareCount}',
                                style: bodyTextMedium.copyWith(
                                  color: kcWhiteColor,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Like count text
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    post.likeCount == 0
                        ? 'Be the first to like this'
                        : post.likeCount == 1
                            ? 'Liked by 1 person'
                            : 'Liked by ${post.likeCount} people',
                    style: bodyTextMedium.copyWith(
                      color: kcFollowColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),

                verticalSpaceSmall,

                // Caption
                if (post.content.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    child: RichText(
                      text: TextSpan(
                        style: titleTextMedium.copyWith(color: kcWhiteColor),
                        children: [
                          TextSpan(text: post.content),
                          if (post.hashtags.isNotEmpty) ...[
                            const TextSpan(text: '  '),
                            TextSpan(
                              text: post.hashtags.join(' '),
                              style: const TextStyle(color: kcPrimaryColor),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                verticalSpaceMedium,
              ],
            ),
          ),
        ),
      ),
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