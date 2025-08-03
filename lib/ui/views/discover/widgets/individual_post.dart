import 'package:flutter/material.dart';
import 'package:nest/ui/views/discover/widgets/right_side_actions.dart';
import 'package:nest/ui/views/discover/widgets/user_info.dart';

import '../../../../models/feed_post.dart';
import 'feed_tab_bar.dart';

class FeedPostWidget extends StatelessWidget {
  final FeedPost post;
  final VoidCallback onLike;
  final VoidCallback onFollow;
  final VoidCallback onComment;
  final VoidCallback onShare;

  const FeedPostWidget({
    Key? key,
    required this.post,
    required this.onLike,
    required this.onFollow,
    required this.onComment,
    required this.onShare,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Background Video/Image
        Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.transparent,
                Colors.black54,
              ],
            ),
          ),
          child: Image.asset(
            'assets/images/fireworks_bg.jpg',
            fit: BoxFit.cover,
          ),
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