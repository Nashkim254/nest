import 'package:flutter/material.dart';
import 'package:nest/ui/common/app_colors.dart';

import '../../../../models/post_models.dart';
import '../../../common/app_styles.dart';

class FeedUserInfoWidget extends StatelessWidget {
  final Post post;
  final VoidCallback onFollow;
  final Function(int)? onProfileTap;

  const FeedUserInfoWidget({
    Key? key,
    required this.post,
    required this.onFollow,
    this.onProfileTap,
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
              GestureDetector(
                onTap: () {
                  if (post.user?.id != null && onProfileTap != null) {
                    onProfileTap!(post.user!.id);
                  }
                },
                child: CircleAvatar(
                  radius: 20,
                  backgroundImage: post.user?.profilePicture != null
                      ? NetworkImage(post.user!.profilePicture!)
                      : const AssetImage('assets/images/default_avatar.png')
                          as ImageProvider,
                ),
              ),
              const SizedBox(width: 12),
              GestureDetector(
                onTap: () {
                  if (post.user?.id != null && onProfileTap != null) {
                    onProfileTap!(post.user!.id);
                  }
                },
                child: Text(
                  post.user?.displayName ?? 'Unknown User',
                  style: titleTextMedium.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
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
                    color: (false) ? kcGreyColor : kcPrimaryColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    (false) ? 'Following' : 'Follow',
                    style: const TextStyle(
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
            post.createdAt != null ? _getTimeAgo(post.createdAt!) : 'Just now',
            style: const TextStyle(
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            post.content,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 8),
          if (post.hasLocation || post.hasHashtags)
            RichText(
              text: TextSpan(
                children: [
                  if (post.hasLocation)
                    TextSpan(
                      text: '@${post.location}',
                      style: const TextStyle(
                        color: kcPrimaryColor,
                        fontSize: 14,
                      ),
                    ),
                  if (post.hasHashtags)
                    TextSpan(
                      text: ' ${post.hashtags.join(' ')}',
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

  String _getTimeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inDays > 7) {
      return '${(difference.inDays / 7).floor()}w';
    } else if (difference.inDays > 0) {
      return '${difference.inDays}d';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m';
    } else {
      return 'now';
    }
  }
}
