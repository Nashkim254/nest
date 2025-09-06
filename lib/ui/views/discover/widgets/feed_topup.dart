import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nest/app/app.locator.dart';
import 'package:nest/app/app.router.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../common/app_strings.dart';
import '../../../common/app_styles.dart';
import '../../../common/ui_helpers.dart';
import '../discover_viewmodel.dart';

class FeedTopBarWidget extends StatelessWidget {
  const FeedTopBarWidget({Key? key, required this.viewModel}) : super(key: key);
  final DiscoverViewModel viewModel;
  @override
  Widget build(BuildContext context) {
    return Container(
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
                onTap: () {},
                child: SvgPicture.asset(notification),
              ),
              horizontalSpaceSmall,
              InkWell(
                onTap: () {
                  locator<NavigationService>().navigateTo(Routes.settingsView);
                },
                child: viewModel.profile != null
                    ? CircleAvatar(
                        radius: 16,
                        backgroundImage:
                            NetworkImage(viewModel.profile!.profilePicture))
                    : const CircleAvatar(
                        radius: 16,
                      ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
