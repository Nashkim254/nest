import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../common/app_colors.dart';
import '../../../common/app_styles.dart';
import '../../../common/ui_helpers.dart';

class Socials extends StatelessWidget {
  const Socials({
    super.key,
    required this.avatar,
    required this.name,
    required this.handle,
    required this.onTap,
  });
  final String avatar;
  final String name;
  final String handle;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: SvgPicture.asset(avatar, width: 24, height: 24),
      title: Text(
        name,
        style: titleTextMedium.copyWith(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: kcWhiteColor,
        ),
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            handle,
            style: titleTextMedium.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: kcFollowColor,
            ),
          ),
          horizontalSpaceMedium,
          Icon(
            Icons.adaptive.arrow_forward,
            color: kcFollowColor,
          ),
        ],
      ),
    );
  }
}
