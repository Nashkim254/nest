import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../common/app_colors.dart';
import '../../../common/app_styles.dart';
import '../../../common/ui_helpers.dart';

class BuildOptions extends StatelessWidget {
  BuildOptions({
    super.key,
    this.trailing,
    this.secondaryTrailing,
    required this.assetUrl,
    required this.title,
    required this.onTap,
    required this.secondaryAssetUrl,
    required this.secondaryTitle,
    required this.secondaryOnTap,
  });
  final String assetUrl;
  final String secondaryAssetUrl;
  final String secondaryTitle;
  final String title;
  final VoidCallback onTap;
  final VoidCallback secondaryOnTap;
  Widget? trailing;
  Widget? secondaryTrailing;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kcContainerColor,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: SvgPicture.asset(assetUrl),
            title: Text(
              title,
              style: titleTextMedium.copyWith(
                fontSize: 16,
                color: kcProfileColor,
              ),
            ),
            trailing: trailing ??
                const Icon(
                  Icons.chevron_right,
                  color: kcSubtitleColor,
                ),
            onTap: onTap,
          ),
          spacedDivider,
          ListTile(
            leading: SvgPicture.asset(secondaryAssetUrl),
            title: Text(
              secondaryTitle,
              style: titleTextMedium.copyWith(
                fontSize: 16,
                color: kcProfileColor,
              ),
            ),
            trailing: secondaryTrailing ??
                const Icon(
                  Icons.chevron_right,
                  color: kcSubtitleColor,
                ),
            onTap: secondaryOnTap,
          ),
        ],
      ),
    );
  }
}
