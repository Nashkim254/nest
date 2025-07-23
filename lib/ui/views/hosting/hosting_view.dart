import 'package:flutter/material.dart';
import 'package:nest/ui/common/app_colors.dart';
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
    return Scaffold(
      backgroundColor: kcDarkColor,
      body: Container(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
        child: const Center(child: Text("HostingView")),
      ),
    );
  }

  @override
  HostingViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      HostingViewModel();
}
