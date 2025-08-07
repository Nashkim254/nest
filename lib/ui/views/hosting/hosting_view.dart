import 'package:flutter/material.dart';
import 'package:nest/ui/common/app_colors.dart';
import 'package:nest/ui/common/app_custom_button.dart';
import 'package:nest/ui/common/app_enums.dart';
import 'package:nest/ui/common/app_styles.dart';
import 'package:nest/ui/common/ui_helpers.dart';
import 'package:nest/ui/views/hosting/widgets/analytics.dart';
import 'package:nest/ui/views/hosting/widgets/events.dart';
import 'package:stacked/stacked.dart';

import 'hosting_viewmodel.dart';

class HostingView extends StackedView<HostingViewModel> {
  const HostingView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    HostingViewModel viewModel,
    Widget? child,
  ) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kcDarkColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: kcDarkColor,
          title: Text(
            "Host Dashboard",
            style: titleTextMedium.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: kcWhiteColor,
            ),
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 25,
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                verticalSpaceMedium,
                Container(
                  height: 47,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: kcDarkGreyColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(
                      HostingSelector.values.length,
                      (int index) => buildSelector(
                        label: viewModel.getSelectorLabel(
                          HostingSelector.values[index],
                        ),
                        isSelected: viewModel.selectedSelector ==
                            HostingSelector.values[index],
                        onTap: () =>
                            viewModel.selectType(HostingSelector.values[index]),
                      ),
                    ),
                  ),
                ),
                verticalSpaceMedium,
                buildView(viewModel),
              ],
            ),
          ),
        ),
      ),
    );
  }

  buildView(HostingViewModel viewModel) {
    switch (viewModel.selectedSelector) {
      case HostingSelector.events:
        return EventTab(
          viewModel: viewModel,
        );
      case HostingSelector.analytics:
        return const AnalyticsTab();
      case HostingSelector.quickActions:
        return const Placeholder();

      case null:
        throw UnimplementedError();
    }
  }

  @override
  HostingViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      HostingViewModel();
}
