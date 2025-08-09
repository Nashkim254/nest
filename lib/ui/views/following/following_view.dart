import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'following_viewmodel.dart';

class FollowingView extends StackedView<FollowingViewModel> {
  const FollowingView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    FollowingViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
        child: const Center(child: Text("FollowingView")),
      ),
    );
  }

  @override
  FollowingViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      FollowingViewModel();
}
