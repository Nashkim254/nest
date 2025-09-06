import 'package:flutter/material.dart';
import 'package:nest/models/events.dart';
import 'package:nest/ui/common/app_colors.dart';
import 'package:nest/ui/common/app_custom_button.dart';
import 'package:nest/ui/common/app_styles.dart';
import 'package:nest/ui/views/create_event/event_visuals.dart';
import 'package:nest/ui/views/create_event/progress_bar.dart';
import 'package:nest/ui/views/create_event/ticket_setup.dart';
import 'package:stacked/stacked.dart';

import '../../../models/page_item.dart';
import '../../common/ui_helpers.dart';
import 'edit_event_viewmodel.dart';
import '../create_event/event_details.dart';

class EditEventView extends StackedView<EditEventViewModel> {
  const EditEventView({Key? key, required this.event}) : super(key: key);
  final Event event;

  @override
  void onViewModelReady(EditEventViewModel viewModel) {
    // Use post frame callback to ensure widget tree is fully built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      viewModel.initializeWithEvent(event);
    });
    super.onViewModelReady(viewModel);
  }

  @override
  Widget builder(
    BuildContext context,
    EditEventViewModel viewModel,
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
            'Edit Event',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: kcWhiteColor,
            ),
          ),
          centerTitle: true,
          actions: [
            if (viewModel.hasChanges)
              TextButton(
                onPressed: () => viewModel.showUnsavedChangesDialog(context),
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: kcPrimaryColor),
                ),
              ),
          ],
        ),
        body: viewModel.isBusy
            ? const Center(
                child: CircularProgressIndicator(color: kcPrimaryColor),
              )
            : Column(
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
                ],
              ),
      ),
    );
  }

  Widget _buildPageView(EditEventViewModel viewModel) {
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
      PageItem item, int index, int totalItems, EditEventViewModel viewModel) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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

          // Page Content - Reusing existing widgets with modifications
          if (index == 0) _buildEventDetailsEdit(viewModel),
          if (index == 1) _buildTicketSetupEdit(viewModel),
          if (index == 2) _buildEventVisualsEdit(viewModel),
        ],
      ),
    );
  }

  Widget _buildEventDetailsEdit(EditEventViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
          // Show original event info for context
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: kcDarkGreyColor.withOpacity(0.5),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: kcPrimaryColor.withOpacity(0.3)),
            ),
            child: Row(
              children: [
                const Icon(Icons.info_outline, color: kcPrimaryColor, size: 16),
                horizontalSpaceSmall,
                Expanded(
                  child: Text(
                    'Editing: ${event.title}',
                    style: titleTextMedium.copyWith(
                      color: kcPrimaryColor,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
          verticalSpaceMedium,

          // Reuse the EventDetails widget but pass our EditEventViewModel
          // Since EditEventViewModel extends CreateEventViewModel, this should work
          EventDetails(viewModel: viewModel),
        ],
      );
  }

  Widget _buildTicketSetupEdit(EditEventViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Warning about ticket changes
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.orange.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.orange.withOpacity(0.3)),
          ),
          child: Row(
            children: [
              const Icon(Icons.warning_amber, color: Colors.orange, size: 16),
              horizontalSpaceSmall,
              Expanded(
                child: Text(
                  'Ticket changes may affect existing reservations',
                  style: titleTextMedium.copyWith(
                    color: Colors.orange,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
        verticalSpaceMedium,

        // Reuse TicketSetup widget
        TicketSetup(viewModel: viewModel),
      ],
    );
  }

  Widget _buildEventVisualsEdit(EditEventViewModel viewModel) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Current flyer preview
        if (event.flyerUrl.isNotEmpty) ...[
          Text(
            'Current Flyer',
            style: titleTextMedium.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: kcWhiteColor,
            ),
          ),
          verticalSpaceSmall,
          Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: kcContainerBorderColor),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                event.flyerUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: kcDarkGreyColor,
                    child: const Center(
                      child: Icon(Icons.broken_image, color: kcGreyColor),
                    ),
                  );
                },
              ),
            ),
          ),
          verticalSpaceMedium,
        ],

        // Reuse EventVisuals widget with custom save button
        EventVisuals(viewModel: viewModel),

        // Replace the finish button with update button
        verticalSpaceMedium,
        AppButton(
          labelText: 'Update Event',
          onTap: () => viewModel.updateEvent(),
          isBusy: viewModel.isBusy,
        ),
      ],
    );
  }

  @override
  EditEventViewModel viewModelBuilder(BuildContext context) =>
      EditEventViewModel();
}
