import 'package:flutter/material.dart';
import 'package:nest/ui/common/app_colors.dart';
import 'package:nest/ui/common/app_styles.dart';
import 'package:nest/ui/views/discover_find_people/widgets/selector_widget.dart';

import '../../../common/ui_helpers.dart';

Widget buildPeopleCard(
    {required String avatar, required String name, required String role}) {
  return Card(
    color: kcContainerColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          // Avatar - fixed width
          CircleAvatar(
            radius: 30.0,
            backgroundImage: AssetImage(avatar),
          ),
          const SizedBox(width: 16), // Spacing

          // Name and role - flexible to take available space
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize:
                  MainAxisSize.min, // Important: prevents unbounded height
              children: [
                Text(
                  name,
                  style: titleTextMedium.copyWith(),
                  overflow: TextOverflow.ellipsis, // Handle long names
                ),
                const SizedBox(height: 4),
                Text(
                  role,
                  style: titleTextMedium.copyWith(color: kcSubtitleColor),
                  overflow: TextOverflow.ellipsis, // Handle long roles
                ),
              ],
            ),
          ),

          horizontalSpaceMedium, // Spacing

          // Follow button - fixed width
          buildSelector(
            label: 'Follow',
            isSelected: true,
            onTap: () {},
          ),
        ],
      ),
    ),
  );
}
