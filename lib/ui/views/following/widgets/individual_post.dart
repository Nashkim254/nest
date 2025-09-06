import 'package:flutter/material.dart';
import 'package:nest/ui/views/for_you/widgets/right_side_actions.dart';
import 'package:nest/ui/views/for_you/widgets/user_info.dart';
import 'package:nest/ui/views/for_you/widgets/video_player.dart';

import '../../../../models/post_models.dart';
import '../../discover/widgets/feed_tab_bar.dart';

class FeedPostWidget extends StatelessWidget {
  final Post post;
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
        // Check if post has video, otherwise show image or placeholder
        if (post.hasVideo && post.videoUrl != null)
          VideoPlayerWidget(
            videoUrl: post.videoUrl!,
            isVisible: isVisible,
          )
        else if (post.hasImages)
          _ImageCarousel(imageUrls: post.imageUrls)
        else
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.grey[800],
            child: const Center(
              child: Icon(
                Icons.image_not_supported,
                color: Colors.white54,
                size: 64,
              ),
            ),
          ),

        // Right Side Actions
        FeedActionsWidget(
          likes: post.likeCount,
          comments: post.commentCount,
          shares: post.shareCount,
          onLike: onLike,
          onComment: onComment,
          onShare: onShare,
          onRepost: onRepost,
          reposts: post.viewCount, // Using viewCount as placeholder for reposts
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

class _ImageCarousel extends StatefulWidget {
  final List<String> imageUrls;

  const _ImageCarousel({required this.imageUrls});

  @override
  State<_ImageCarousel> createState() => _ImageCarouselState();
}

class _ImageCarouselState extends State<_ImageCarousel> {
  int _currentImageIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Image carousel
        PageView.builder(
          controller: _pageController,
          itemCount: widget.imageUrls.length,
          onPageChanged: (index) {
            setState(() {
              _currentImageIndex = index;
            });
          },
          itemBuilder: (context, imageIndex) {
            return Container(
              width: double.infinity,
              height: double.infinity,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(widget.imageUrls[imageIndex]),
                  fit: BoxFit.cover,
                  onError: (error, stackTrace) {
                    // Handle image loading errors silently
                  },
                ),
              ),
            );
          },
        ),
        // Image counter (top right)
        if (widget.imageUrls.length > 1)
          Positioned(
            top: 50,
            right: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Text(
                '${_currentImageIndex + 1}/${widget.imageUrls.length}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        // Indicator dots (bottom)
        if (widget.imageUrls.length > 1)
          Positioned(
            bottom: 120,
            left: 16,
            child: Row(
              children: widget.imageUrls.asMap().entries.map((entry) {
                final isActive = entry.key == _currentImageIndex;
                return GestureDetector(
                  onTap: () {
                    _pageController.animateToPage(
                      entry.key,
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: isActive ? 8 : 6,
                    height: isActive ? 8 : 6,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isActive 
                          ? Colors.white
                          : Colors.white.withOpacity(0.4),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
      ],
    );
  }
}
