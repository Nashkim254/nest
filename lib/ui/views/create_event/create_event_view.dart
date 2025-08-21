import 'package:flutter/material.dart';
import 'package:nest/ui/common/app_colors.dart';
import 'package:nest/ui/common/app_custom_button.dart';
import 'package:nest/ui/common/app_inputdecoration.dart';
import 'package:nest/ui/common/app_styles.dart';
import 'package:nest/ui/views/create_event/event_visuals.dart';
import 'package:nest/ui/views/create_event/progress_bar.dart';
import 'package:nest/ui/views/create_event/ticket_setup.dart';
import 'package:stacked/stacked.dart';

import '../../../models/page_item.dart';
import '../../../models/progress_segment.dart';
import '../../common/ui_helpers.dart';
import 'create_event_viewmodel.dart';
import 'event_details.dart';

class CreateEventView extends StackedView<CreateEventViewModel> {
  const CreateEventView({Key? key}) : super(key: key);
  @override
  void onViewModelReady(CreateEventViewModel viewModel) {
    viewModel.getCurrentLocation();
    super.onViewModelReady(viewModel);
  }

  @override
  Widget builder(
    BuildContext context,
    CreateEventViewModel viewModel,
    Widget? child,
  ) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kcDarkColor,
        appBar: AppBar(
          backgroundColor: kcDarkColor,
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: () => viewModel.previousPage(),
            icon: Icon(
              Icons.adaptive.arrow_back_outlined,
              color: kcWhiteColor,
            ),
          ),
          elevation: 0,
          title: const Text(
            'Create Event',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: kcWhiteColor,
            ),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            // Progress Bar
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: StackedProgressBar(
                totalSteps: viewModel.totalPages,
                currentStep: viewModel.currentPage + 1,
              ),
            ),

            // Page View
            Expanded(
              child: _buildPageView(viewModel),
            ),

            // Navigation Buttons
          ],
        ),
      ),
    );
  }

  @override
  CreateEventViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      CreateEventViewModel();
}

Widget _buildPageView(CreateEventViewModel viewModel) {
  return PageView.builder(
    controller: viewModel.pageController,
    onPageChanged: viewModel.onPageChanged,
    itemCount: viewModel.itemCount,
    physics: const NeverScrollableScrollPhysics(),
    itemBuilder: (context, index) {
      return _buildPageItem(
          viewModel.items[index], index, viewModel.itemCount, viewModel);
    },
  );
}

Widget _buildPageItem(
    PageItem item, int index, int totalItems, CreateEventViewModel viewModel) {
  return SingleChildScrollView(
    padding: const EdgeInsets.all(24),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      // Page Title
      Text(
        item.title,
        style: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: kcWhiteColor,
        ),
      ),

      verticalSpaceMedium,

      // Page Content
      if (index == 0) EventDetails(viewModel: viewModel),
      if (index == 1) TicketSetup(viewModel: viewModel),
      if (index == 2) EventVisuals(viewModel: viewModel),
    ]),
  );
}
