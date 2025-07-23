import 'package:flutter/material.dart';
import 'package:nest/ui/common/app_colors.dart';
import 'package:stacked/stacked.dart';

import 'messages_viewmodel.dart';

class MessagesView extends StackedView<MessagesViewModel> {
  const MessagesView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    MessagesViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: kcDarkColor,
      body: Container(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
        child: const Center(child: Text("MessagesView")),
      ),
    );
  }

  @override
  MessagesViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      MessagesViewModel();
}
