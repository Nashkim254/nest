import 'package:flutter/material.dart';
import 'package:nest/ui/common/app_colors.dart';
import 'package:nest/ui/common/app_custom_button.dart';
import 'package:nest/ui/common/app_styles.dart';
import 'package:nest/ui/common/ui_helpers.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../common/app_inputdecoration.dart';
import 'fin_events_sheet_model.dart';

class FinEventsSheet extends StackedView<FinEventsSheetModel> {
  final Function(SheetResponse response)? completer;
  final SheetRequest request;
  const FinEventsSheet({
    Key? key,
    required this.completer,
    required this.request,
  }) : super(key: key);
  @override
  onViewModelReady(FinEventsSheetModel viewModel) {
    viewModel.initialize(completer!);
    super.onViewModelReady(viewModel);
  }

  @override
  Widget builder(
    BuildContext context,
    FinEventsSheetModel viewModel,
    Widget? child,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: const BoxDecoration(
        color: kcDarkColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            FindEventsHeaderWidget(
              onClose: viewModel.closeSheet,
              request: request,
            ),
            const Divider(
              color: kcContainerBorderColor,
            ),
            verticalSpaceSmall,
            TextFormField(
              controller: viewModel.searchController,
              decoration: AppInputDecoration.standard(
                hintText: 'Search events',
                prefixIcon: const Icon(
                  Icons.search,
                  color: kcGreyColor,
                ),
              ),
              onChanged: viewModel.onSearchChanged,
            ),
            verticalSpaceSmall,
            const FilterView(),
            verticalSpaceLarge,
            const Divider(
              color: kcContainerBorderColor,
            ),
            verticalSpaceMedium,
            const BottomActionButtons(),
          ],
        ),
      ),
    );
  }

  @override
  FinEventsSheetModel viewModelBuilder(BuildContext context) =>
      FinEventsSheetModel();
}

class FindEventsHeaderWidget extends StatelessWidget {
  final VoidCallback onClose;
  final SheetRequest request;

  const FindEventsHeaderWidget({
    Key? key,
    required this.onClose,
    required this.request,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            request.title ?? 'Events',
            style: const TextStyle(
              color: kcWhiteColor,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          GestureDetector(
            onTap: onClose,
            child: const Icon(
              Icons.close,
              color: kcWhiteColor,
              size: 24,
            ),
          ),
        ],
      ),
    );
  }
}

class FilterView extends StatelessWidget {
  const FilterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FinEventsSheetModel>.reactive(
      viewModelBuilder: () => FinEventsSheetModel(),
      builder: (context, model, child) => Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: kcDarkColor, // Dark gray background
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildFilterSection(
              context: context,
              model: model,
              title: 'Date',
              filters: model.dateFilters,
              selectedFilter: model.selectedDateFilter,
              onFilterSelected: model.setSelectedDateFilter,
              showNotification: true,
            ),
            const SizedBox(height: 24),
            _buildFilterSection(
              context: context,
              model: model,
              title: 'Location',
              filters: model.locationFilters,
              selectedFilter: model.selectedLocationFilter,
              onFilterSelected: model.setSelectedLocationFilter,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterSection({
    required BuildContext context,
    required FinEventsSheetModel model,
    required String title,
    required List<String> filters,
    required String selectedFilter,
    required Function(String) onFilterSelected,
    bool showNotification = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: titleTextMedium.copyWith(
            color: kcWhiteColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: filters
              .map((filter) => _buildFilterChip(
                    filter: filter,
                    isSelected: filter == selectedFilter,
                    onTap: () => onFilterSelected(filter),
                    showNotification: showNotification && filter == 'This Week',
                  ))
              .toList(),
        ),
      ],
    );
  }

  Widget _buildFilterChip({
    required String filter,
    required bool isSelected,
    required VoidCallback onTap,
    bool showNotification = false,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? kcPrimaryColor : kcWhiteColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(7),
          border: Border.all(
            color: isSelected ? const Color(0xFF5A5A5A) : Colors.transparent,
            width: 1,
          ),
        ),
        child: Text(
          filter,
          style: TextStyle(
            color: isSelected ? Colors.white : const Color(0xFFB0B0B0),
            fontSize: 14,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
    );
  }
}

class BottomActionButtons extends StatelessWidget {
  const BottomActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<FinEventsSheetModel>.reactive(
      viewModelBuilder: () => FinEventsSheetModel(),
      builder: (context, model, child) => Row(
        children: [
          Expanded(
            child: AppButton(
              buttonColor: kcClearColor,
              labelText: 'Clear All',
              onTap: () => model.clearFilters(),
            ),
          ),
          const Spacer(),
          Expanded(
            child: AppButton(
              isBusy: model.isBusy,
              labelText: 'Apply Filters',
              onTap: () => model.applyFilters(),
            ),
          ),
        ],
      ),
    );
  }
}
