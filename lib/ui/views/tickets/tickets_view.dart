import 'package:flutter/material.dart';
import 'package:nest/ui/common/app_colors.dart';
import 'package:nest/ui/views/tickets/widgets/past_tab.dart';
import 'package:nest/ui/views/tickets/widgets/upcoming_tab.dart';
import 'package:stacked/stacked.dart';

import '../../common/app_styles.dart';
import 'tickets_viewmodel.dart';

class TicketsView extends StackedView<TicketsViewModel> {
  const TicketsView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    TicketsViewModel viewModel,
    Widget? child,
  ) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: kcDarkColor,
        appBar: AppBar(
          backgroundColor: kcDarkColor,
          automaticallyImplyLeading: false,
          elevation: 0,
          title: Text(
            'My Tickets',
            style: titleTextMedium.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: kcWhiteColor,
            ),
          ),
          centerTitle: true,
          bottom: TabBar(
            indicatorColor: kcPrimaryColor,
            indicatorWeight: 2,
            labelColor: kcPrimaryColor,
            indicatorSize: TabBarIndicatorSize.tab,
            unselectedLabelColor: kcDisableIconColor,
            labelStyle: titleTextMedium,
            tabs: const [
              Tab(text: 'Upcoming'),
              Tab(text: 'Past'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            UpcomingTicketsTab(
              viewModel: viewModel,
            ),
            PastTicketsTab(
              viewModel: viewModel,
            ),
          ],
        ),
      ),
    );
  }

  @override
  TicketsViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      TicketsViewModel();
}
