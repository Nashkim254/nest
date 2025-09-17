import 'package:flutter/material.dart';
import 'package:nest/models/event_activity.dart';

import '../../../../models/post_models.dart';
import '../../../common/app_colors.dart';
import '../../../common/app_styles.dart';

class EventGalleryGrid extends StatelessWidget {
  final List<Post> posts;
  final Function(Post post) onTap;
  const EventGalleryGrid({super.key, required this.posts, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: posts.isNotEmpty ? null : 100, // Adjust height based on activity
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: kcOffWhite8Grey,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: kcContainerBorderColor),
      ),
      child: posts.isNotEmpty
          ? GridView.builder(
              shrinkWrap: true,
              physics:
                  const NeverScrollableScrollPhysics(), // Prevent internal scrolling
              itemCount: posts.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemBuilder: (context, index) {
                final post = posts[index];
                return InkWell(
                  onTap: () => onTap(post),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Hero(
                      tag: index,
                      child: _buildMediaWidget(post),
                    ),
                  ),
                );
              },
            )
          : Center(
              child: Text(
                'No feed to display.',
                style: titleTextMedium.copyWith(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: kcFollowColor,
                ),
              ),
            ),
    );
  }

  Widget _buildMediaWidget(Post post) {
    // Priority: Video thumbnail > First image > Placeholder
    if (post.hasVideo && post.videoThumbnail != null && post.videoThumbnail!.isNotEmpty) {
      // Show video thumbnail with play icon overlay
      return Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            post.videoThumbnail!,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                      : null,
                  color: kcPrimaryColor,
                ),
              );
            },
            errorBuilder: (context, error, stackTrace) {
              // Fallback if thumbnail fails to load
              return _buildVideoPlaceholder();
            },
          ),
          // Play icon overlay with shadow for better visibility
          Center(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.3),
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(8),
              child: const Icon(
                Icons.play_arrow,
                color: Colors.white,
                size: 32,
              ),
            ),
          ),
          // Video indicator badge
          Positioned(
            top: 8,
            right: 8,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.7),
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text(
                'VIDEO',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      );
    } else if (post.hasVideo) {
      // Video exists but no thumbnail yet (probably still processing)
      return _buildVideoPlaceholder(processing: !post.videoReady);
    } else if (post.hasImages) {
      // Show first image
      return Image.network(
        post.imageUrls.first,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                      loadingProgress.expectedTotalBytes!
                  : null,
              color: kcPrimaryColor,
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return _buildImagePlaceholder();
        },
      );
    } else {
      // No media - show text post placeholder
      return _buildTextPostPlaceholder();
    }
  }

  Widget _buildVideoPlaceholder({bool processing = false}) {
    return Container(
      color: Colors.grey[800],
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              processing ? Icons.video_settings : Icons.videocam,
              color: Colors.white,
              size: 30,
            ),
            const SizedBox(height: 4),
            Text(
              processing ? 'Processing...' : 'Video',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImagePlaceholder() {
    return Container(
      color: Colors.grey[300],
      child: const Center(
        child: Icon(
          Icons.image,
          color: Colors.grey,
          size: 30,
        ),
      ),
    );
  }

  Widget _buildTextPostPlaceholder() {
    return Container(
      color: kcOffWhite8Grey,
      child: const Center(
        child: Icon(
          Icons.text_fields,
          color: kcFollowColor,
          size: 30,
        ),
      ),
    );
  }
}
