import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../common/app_strings.dart';
import '../../../common/app_styles.dart';
import '../../../common/ui_helpers.dart';

class FeedTopBarWidget extends StatelessWidget {
  const FeedTopBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'My Nest',
                style: titleTextMedium.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      // Handle search action
                    },
                    child: SvgPicture.asset(notification),
                  ),
                  horizontalSpaceSmall,
                  const CircleAvatar(
                    radius: 16,
                    backgroundImage: AssetImage(avatar),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
