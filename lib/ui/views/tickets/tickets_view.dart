import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'tickets_viewmodel.dart';

class TicketsView extends StackedView<TicketsViewModel> {
  const TicketsView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    TicketsViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        padding: const EdgeInsets.only(left: 25.0, right: 25.0),
        child: const Center(child: Text("TicketsView")),
      ),
    );
  }

  @override
  TicketsViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      TicketsViewModel();
}
