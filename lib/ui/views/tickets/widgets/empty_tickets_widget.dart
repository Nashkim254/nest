import 'package:flutter/material.dart';
import 'package:nest/ui/common/app_colors.dart';
import 'package:nest/ui/common/app_styles.dart';
import 'package:nest/ui/common/ui_helpers.dart';

class EmptyTicketsWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;

  const EmptyTicketsWidget({
    Key? key,
    required this.title,
    required this.subtitle,
    this.icon = Icons.confirmation_num_outlined,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Empty state icon
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: kcMediumGrey.withOpacity(0.1),
                borderRadius: BorderRadius.circular(60),
              ),
              child: Icon(
                icon,
                size: 60,
                color: kcMediumGrey,
              ),
            ),
            verticalSpaceLarge,

            // Title
            Text(
              title,
              style: titleTextMedium.copyWith(
                color: kcWhiteColor,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            verticalSpaceSmall,

            // Subtitle
            Text(
              subtitle,
              style: bodyTextMedium.copyWith(
                color: kcMediumGrey,
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
