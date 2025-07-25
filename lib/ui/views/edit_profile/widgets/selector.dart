import 'package:flutter/material.dart';

import '../../../common/app_colors.dart';
import '../../../common/app_styles.dart';

Widget buildSettingsSelector(
    {required String label,
    required bool isSelected,
    required VoidCallback onTap}) {
  return InkWell(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.only(right: 16, top: 8, bottom: 8, left: 16),
      margin: const EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
        color: isSelected ? kcPrimaryColor : Colors.transparent,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Center(
        child: Text(
          label,
          style: titleTextMedium.copyWith(
            fontSize: 16,
            color: kcSubtitleTextColor,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    ),
  );
}
