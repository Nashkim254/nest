// widgets/overview_widget.dart
import 'package:flutter/material.dart';

import '../../../common/app_colors.dart';
import '../../../common/app_styles.dart';

class OverviewWidget extends StatelessWidget {
  final String title;
  final String value;

  const OverviewWidget({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 146,
      width: 155,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
          color: kcDarkGreyColor,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(color: kcContainerBorderColor)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            title,
            style: titleTextMedium.copyWith(
              fontSize: 16,
              color: kcUnselectedColor,
            ),
          ),
          Text(
            value.toString(),
            style: titleTextMedium.copyWith(
              fontSize: 16,
              color: kcPrimaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
