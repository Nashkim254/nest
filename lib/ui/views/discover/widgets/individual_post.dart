import 'package:flutter/material.dart';
import 'package:nest/ui/views/discover/widgets/right_side_actions.dart';
import 'package:nest/ui/views/discover/widgets/user_info.dart';
import 'package:nest/ui/views/discover/widgets/video_player.dart';

import '../../../../models/feed_post.dart';
import 'feed_tab_bar.dart';

class FeedPostWidget extends StatelessWidget {
  final FeedPost post;
  final VoidCallback onLike;
  final VoidCallback onFollow;
  final VoidCallback onComment;
  final VoidCallback onShare;
  final VoidCallback onRepost;
  final bool isVisible;

  const FeedPostWidget({
    Key? key,
    required this.post,
    required this.onLike,
    required this.onFollow,
    required this.onComment,
    required this.onShare,
    required this.onRepost,
    required this.isVisible,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        VideoPlayerWidget(
          videoUrl: post.videoUrl,
          isVisible: isVisible,
        ),

        // Tab Bar
        const FeedTabBarWidget(),

        // Right Side Actions
        FeedActionsWidget(
          likes: post.likes,
          comments: post.comments,
          shares: post.shares,
          onLike: onLike,
          onComment: onComment,
          onShare: onShare,
          onRepost: onRepost,
          reposts: post.reposts, // Placeholder for repost action
        ),

        // Bottom User Info
        FeedUserInfoWidget(
          post: post,
          onFollow: onFollow,
        ),
      ],
    );
  }
}
