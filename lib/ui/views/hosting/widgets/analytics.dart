import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../common/app_colors.dart';
import '../../../common/app_custom_button.dart';
import '../../../common/app_strings.dart';
import '../../../common/app_styles.dart';
import '../../../common/ui_helpers.dart';

class AnalyticsTab extends StatelessWidget {
  const AnalyticsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Performance Overview",
          style: titleTextMedium.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: kcWhiteColor,
          ),
        ),
        verticalSpaceMedium,
        buildPlaceHolder(context, "Ticket Sales", "Graph Placeholder"),
        verticalSpaceMedium,
        buildPlaceHolder(context, "Traffic", "Graph Placeholder"),
        verticalSpaceMedium,
        buildPlaceHolder(context, "RsvPs", "Graph Placeholder"),
        verticalSpaceMedium,
        Text(
          "Key Insights",
          style: titleTextMedium.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: kcWhiteColor,
          ),
        ),
        verticalSpaceMedium,
        buildInsightWidget(
          context,
          "Top Promoter",
          "Nightlife King",
          kcPrimaryColor,
          prize,
        ),
        verticalSpaceMedium,
        buildInsightWidget(
          context,
          "Active Events",
          "5 Events",
          kcSecondaryColor,
          prize,
        ),
        verticalSpaceMedium,
        AppButton(
          labelText: 'Create New Event',
          onTap: () {},
        ),
      ],
    );
  }
}

Widget buildSelector({
  required String label,
  required bool isSelected,
  required VoidCallback onTap,
}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      decoration: BoxDecoration(
        color: isSelected ? kcPrimaryColor : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: titleTextMedium.copyWith(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: isSelected ? kcWhiteColor : kcDisableIconColor,
        ),
      ),
    ),
  );
}

Widget buildPlaceHolder(BuildContext context, String title, String icon) {
  return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
      decoration: BoxDecoration(
        color: kcDarkGreyColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: titleTextMedium.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: kcWhiteColor,
            ),
          ),
          verticalSpaceMedium,
          Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.09,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 16),
              decoration: BoxDecoration(
                color: kcGrey3Color,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  icon,
                  style: titleTextMedium.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: kcWhiteColor,
                  ),
                ),
              )),
        ],
      ));
}

Widget buildInsightWidget(
  BuildContext context,
  String title,
  String description,
  Color color,
  String icon,
) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(
      horizontal: 10,
    ),
    decoration: BoxDecoration(
      color: kcDarkGreyColor,
      borderRadius: BorderRadius.circular(10),
    ),
    child: ListTile(
      leading: Container(
        height: 40,
        width: 40,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        child: Center(
          child: SvgPicture.asset(icon),
        ),
      ),
      title: Text(
        title,
        style: titleTextMedium.copyWith(
          fontSize: 13,
          fontWeight: FontWeight.w400,
          color: kcGrey4Color,
        ),
      ),
      subtitle: Text(
        description,
        style: titleTextMedium.copyWith(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: kcWhiteColor,
        ),
      ),
    ),
  );
}
