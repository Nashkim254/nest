import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nest/models/event_activity.dart';
import 'package:nest/ui/common/app_strings.dart';
import 'package:nest/ui/common/ui_helpers.dart';
import '../../../common/app_colors.dart';
import '../../../common/app_styles.dart';

class EventActivityCard extends StatelessWidget {
  final EventActivity activity;
final int index;
  const EventActivityCard({super.key, required this.activity, required this.index});

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
                    backgroundImage: AssetImage(activity.userProfileImageUrl),
                    radius: 20,
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Text(activity.userName, style: titleTextMedium),
                ),
                Expanded(
                  flex: 2,
                  child: Text(
                    activity.timeAgo,
                    style: titleTextMedium.copyWith(color: Colors.grey),
                  ),
                ),
                if (activity.isEditable)
                  Expanded(
                    flex: 2,
                    child: TextButton(
                      onPressed: () {
                        // Edit action
                      },
                      child: Text('Edit',
                          style:
                              bodyTextMedium.copyWith(color: kcPrimaryColor)),
                    ),
                  ),
              ],
            ),
          ),

          // Event Image
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Hero(
              tag: index,
              child: Image.asset(
                activity.eventImageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),

          // Actions
           Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                SvgPicture.asset(like),
                horizontalSpaceMedium,
                SvgPicture.asset(comment),
                horizontalSpaceMedium,
                SvgPicture.asset(send),
              ],
            ),
          ),

          // Liked by
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              'Liked by ${activity.likedByUser} and ${activity.likeCount} others',
              style: bodyTextMedium.copyWith(color: Colors.grey.shade400),
            ),
          ),

          const SizedBox(height: 6),

          // Caption
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            child: RichText(
              text: TextSpan(
                style: titleTextMedium.copyWith(color: kcWhiteColor),
                children: [
                  TextSpan(
                    text: '${activity.captionTitle} ',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: activity.captionDescription),
                  if (activity.hashtags.isNotEmpty) ...[
                    const TextSpan(text: '  '),
                    TextSpan(
                      text: activity.hashtags.join(' '),
                      style: const TextStyle(color: kcPrimaryColor),
                    ),
                  ],
                ],
              ),
            ),
          ),

          const SizedBox(height: 12),
        ],
      ),
    );
  }
}
