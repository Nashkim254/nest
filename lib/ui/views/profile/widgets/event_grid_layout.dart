import 'package:flutter/material.dart';
import 'package:nest/models/event_activity.dart';

import '../../../common/app_colors.dart';
import '../../../common/app_styles.dart';

class EventGalleryGrid extends StatelessWidget {
  final List<EventActivity> eventActivities;
  final Function(EventActivity selectedActivity) onTap;
  const EventGalleryGrid(
      {super.key, required this.eventActivities, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: eventActivities.isNotEmpty
          ? null
          : 100, // Adjust height based on activity
      padding: const EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        color: kcOffWhite8Grey,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: kcContainerBorderColor),
      ),
      child: eventActivities.isNotEmpty
          ? GridView.builder(
              shrinkWrap: true,
              physics:
                  const NeverScrollableScrollPhysics(), // Prevent internal scrolling
              itemCount: eventActivities.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
              ),
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () => onTap(eventActivities[index]),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Hero(
                      tag: index,
                      child: Image.asset(
                        eventActivities[index].eventImageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
            )
          : Center(
              child: Text(
                'No public event activity to display.',
                style: titleTextMedium.copyWith(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  color: kcFollowColor,
                ),
              ),
            ),
    );
  }
}
