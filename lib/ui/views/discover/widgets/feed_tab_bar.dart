import 'package:flutter/material.dart';
import 'package:nest/ui/common/app_colors.dart';
import 'package:nest/ui/common/app_enums.dart';
import 'package:stacked/stacked.dart';

import '../../upcoming/upcoming_viewmodel.dart';
import '../discover_viewmodel.dart';

class FeedTabBarWidget extends StackedView<DiscoverViewModel> {
  const FeedTabBarWidget({Key? key}) : super(key: key);

  @override
  Widget builder(
      BuildContext context, DiscoverViewModel viewModel, Widget? child) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildTabItem(
            'For you',
            viewModel.contentType == ContentType.fyp,
            onPressed: () => viewModel.setContentType(ContentType.fyp),
          ),
          const SizedBox(width: 32),
          _buildTabItem(
              'Upcoming', viewModel.contentType == ContentType.upcoming,
              onPressed: () => viewModel.setContentType(ContentType.upcoming)),
          const SizedBox(width: 32),
          _buildTabItem(
              'Following', viewModel.contentType == ContentType.following,
              onPressed: () => viewModel.setContentType(ContentType.following)),
        ],
      ),
    );
  }

  @override
  DiscoverViewModel viewModelBuilder(BuildContext context) =>
      DiscoverViewModel();
}

Widget _buildTabItem(String title, bool isActive, {VoidCallback? onPressed}) {
  return InkWell(
    onTap: onPressed,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isActive ? kcPrimaryColor : Colors.transparent,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        title,
        style: TextStyle(
          color: isActive ? Colors.white : kcGreyColor,
          fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
        ),
      ),
    ),
  );
}
