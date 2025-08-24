import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:logger/logger.dart';
import 'package:nest/app/app.locator.dart';
import 'package:nest/models/event_activity.dart';
import 'package:nest/models/post_models.dart';
import 'package:nest/services/shared_preferences_service.dart';
import 'package:nest/ui/common/app_strings.dart';
import 'package:nest/ui/common/ui_helpers.dart';
import 'package:nest/utils/utilities.dart';
import '../../../common/app_colors.dart';
import '../../../common/app_styles.dart';

class EventActivityCard extends StatelessWidget {
  final Post post;
  final int index;
  final Function(Post) onLike;
  final Function(Post) onComment;
  final Function(Post) onEdit;
  final Function(Post) onShare;
  const EventActivityCard(
      {super.key,
      required this.post,
      required this.index,
      required this.onLike,
      required this.onEdit,
      required this.onShare,
      required this.onComment});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: kcDarkGreyColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: kcContainerBorderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: profile image, name, time, edit
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(post.user!.profilePicture!),
                    radius: 20,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(post.user!.displayName, style: titleTextMedium),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    formatter.format(post.createdAt ?? DateTime.now()),
                    style: titleTextMedium.copyWith(color: Colors.grey),
                  ),
                ),
                if (post.user!.id ==
                        locator<SharedPreferencesService>()
                            .getUserInfo()!['id'] ??
                    locator<SharedPreferencesService>().getUserInfo()!['ID'])
                  Expanded(
                    flex: 2,
                    child: TextButton(
                      onPressed: () => onEdit(post),
                      child: Text('Edit',
                          style:
                              bodyTextMedium.copyWith(color: kcPrimaryColor)),
                    ),
                  ),
              ],
            ),
          ),

          // Multiple Images Handler
          if (post.hasImages) _buildImageSection(context),

          // Actions
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                InkWell(
                  onTap: () => onLike(post),
                  child: SvgPicture.asset(like,
                      color: post.isLiked ? kcPrimaryColor : kcWhiteColor),
                ),
                horizontalSpaceMedium,
                InkWell(
                  onTap: () => onComment(post),
                  child: SvgPicture.asset(comment),
                ),
                horizontalSpaceMedium,
                InkWell(
                  onTap: () => onShare(post),
                  child: SvgPicture.asset(send),
                ),
              ],
            ),
          ),

          // Liked by
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              'Liked by  ${post.likeCount} people',
              style: bodyTextMedium.copyWith(
                color: kcFollowColor,
                fontSize: 14,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),

          verticalSpaceSmall,

          // Caption
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            child: RichText(
              text: TextSpan(
                style: titleTextMedium.copyWith(color: kcWhiteColor),
                children: [
                  TextSpan(
                    //pick few characters of the content
                    text: '${post.content} ',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
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
    );
  }

  Widget _buildImageSection(BuildContext context) {
    final imageCount = post.imageUrls.length;

    if (imageCount == 1) {
      // Single image - full width
      return Hero(
        tag: '${index}_0',
        child: ClipRRect(
          child: Image.network(
            post.imageUrls.first,
            fit: BoxFit.cover,
            width: double.infinity,
            height: 300,
          ),
        ),
      );
    } else if (imageCount == 2) {
      // Two images side by side
      return SizedBox(
        height: 250,
        child: Row(
          children: [
            Expanded(
              child: Hero(
                tag: '${index}_0',
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(8),
                  ),
                  child: Image.network(
                    post.imageUrls[0],
                    fit: BoxFit.cover,
                    height: double.infinity,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 2),
            Expanded(
              child: Hero(
                tag: '${index}_1',
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(8),
                  ),
                  child: Image.network(
                    post.imageUrls[1],
                    fit: BoxFit.cover,
                    height: double.infinity,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    } else if (imageCount == 3) {
      // Three images: one large on left, two smaller on right
      return SizedBox(
        height: 300,
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Hero(
                tag: '${index}_0',
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(8),
                  ),
                  child: Image.network(
                    post.imageUrls[0],
                    fit: BoxFit.cover,
                    height: double.infinity,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 2),
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: Hero(
                      tag: '${index}_1',
                      child: ClipRRect(
                        child: Image.network(
                          post.imageUrls[1],
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Expanded(
                    child: Hero(
                      tag: '${index}_2',
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(8),
                        ),
                        child: Image.network(
                          post.imageUrls[2],
                          fit: BoxFit.cover,
                          width: double.infinity,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    } else {
      // Four or more images: 2x2 grid with "more" overlay
      return SizedBox(
        height: 300,
        child: Column(
          children: [
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Hero(
                      tag: '${index}_0',
                      child: ClipRRect(
                        child: Image.network(
                          post.imageUrls[0],
                          fit: BoxFit.cover,
                          height: double.infinity,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 2),
                  Expanded(
                    child: Hero(
                      tag: '${index}_1',
                      child: ClipRRect(
                        child: Image.network(
                          post.imageUrls[1],
                          fit: BoxFit.cover,
                          height: double.infinity,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 2),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Hero(
                      tag: '${index}_2',
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(8),
                        ),
                        child: Image.network(
                          post.imageUrls[2],
                          fit: BoxFit.cover,
                          height: double.infinity,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 2),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _showAllImages(context),
                      child: Stack(
                        children: [
                          Hero(
                            tag: '${index}_3',
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                bottomRight: Radius.circular(8),
                              ),
                              child: Image.network(
                                post.imageUrls[3],
                                fit: BoxFit.cover,
                                height: double.infinity,
                                width: double.infinity,
                              ),
                            ),
                          ),
                          if (imageCount > 4)
                            Positioned.fill(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.6),
                                  borderRadius: const BorderRadius.only(
                                    bottomRight: Radius.circular(8),
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    '+${imageCount - 4}',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
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

  void _showAllImages(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ImageGalleryView(
          imageUrls: post.imageUrls,
          initialIndex: 0,
          heroTag: index.toString(),
        ),
      ),
    );
  }
}

// Separate widget for viewing all images
class ImageGalleryView extends StatelessWidget {
  final List<String> imageUrls;
  final int initialIndex;
  final String heroTag;

  const ImageGalleryView({
    super.key,
    required this.imageUrls,
    required this.initialIndex,
    required this.heroTag,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: PageView.builder(
        controller: PageController(initialPage: initialIndex),
        itemCount: imageUrls.length,
        itemBuilder: (context, index) {
          return Center(
            child: Hero(
              tag: '${heroTag}_$index',
              child: InteractiveViewer(
                child: Image.network(
                  imageUrls[index],
                  fit: BoxFit.contain,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
