import 'package:flutter/material.dart';
import 'package:nest/ui/common/app_colors.dart';
import 'package:nest/ui/common/app_enums.dart';
import 'package:nest/ui/views/discover/widgets/feed_tab_bar.dart';
import 'package:nest/ui/views/discover/widgets/feed_topup.dart';
import 'package:stacked/stacked.dart';

import '../../common/ui_helpers.dart';
import 'discover_viewmodel.dart';

class DiscoverView extends StackedView<DiscoverViewModel> {
  const DiscoverView({Key? key}) : super(key: key);

  @override
  void onViewModelReady(DiscoverViewModel viewModel) {
    super.onViewModelReady(viewModel);

    viewModel.setContentType(ContentType.upcoming);
  }

  @override
  Widget builder(
    BuildContext context,
    DiscoverViewModel viewModel,
    Widget? child,
  ) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kcDarkColor,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const FeedTopBarWidget(),
            spacedDivider,
            const FeedTabBarWidget(),
            verticalSpaceSmall,
            const Divider(height: 1, color: kcContainerBorderColor),
            verticalSpaceMedium,
            Expanded(
              child: PageView.builder(
                controller: viewModel.pageController,
                itemCount: viewModel.tabPages.length,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: viewModel.onPageChanged,
                itemBuilder: (context, index) => viewModel.tabPages[index],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  DiscoverViewModel viewModelBuilder(BuildContext context) =>
      DiscoverViewModel();
}
