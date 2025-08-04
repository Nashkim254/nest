import 'package:flutter/material.dart';
import 'package:nest/ui/common/app_colors.dart';

import '../../../../models/feed_post.dart';
import '../../../common/app_styles.dart';

class FeedUserInfoWidget extends StatelessWidget {
  final FeedPost post;
  final VoidCallback onFollow;

  const FeedUserInfoWidget({
    Key? key,
    required this.post,
    required this.onFollow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 16,
      bottom: 100,
      right: 100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage(post.userAvatar),
              ),
              const SizedBox(width: 12),
              Text(
                post.username,
                style: titleTextMedium.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 12),
              GestureDetector(
                onTap: onFollow,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: kcPrimaryColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Text(
                    'Follow',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            post.timeAgo,
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            post.description,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: post.venue,
                  style: const TextStyle(
                    color: kcPrimaryColor,
                    fontSize: 14,
                  ),
                ),
                TextSpan(
                  text: ' ${post.hashtags}',
                  style: const TextStyle(
                    color: kcPrimaryColor,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}