// analytics_view.dart
import 'package:flutter/material.dart';
import 'package:nest/ui/common/app_colors.dart';
import 'package:nest/ui/common/ui_helpers.dart';
import 'package:nest/ui/views/analytics/widgets/breakdown.dart';
import 'package:nest/ui/views/analytics/widgets/overview.dart';
import 'package:nest/ui/views/analytics/widgets/performance.dart';
import 'package:stacked/stacked.dart';
import 'analytics_viewmodel.dart';

class AnalyticsView extends StackedView<AnalyticsViewModel> {
  const AnalyticsView({super.key, required this.organizationId});
  final int organizationId;
  @override
  void onViewModelReady(AnalyticsViewModel viewModel) {
    viewModel.initialize(organizationId);
    super.onViewModelReady(viewModel);
  }

  @override
  Widget builder(
    BuildContext context,
    AnalyticsViewModel viewModel,
    Widget? child,
  ) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kcDarkColor,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => viewModel.navigationService.back(),
            icon: const Icon(
              Icons.arrow_back,
              color: kcWhiteColor,
            ),
          ),
          backgroundColor: kcDarkColor,
          title: const Text(
            'Analytics',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          actions: [
            IconButton(
              onPressed: viewModel.toggleFilter,
              icon: const Icon(Icons.filter_list, color: Colors.white),
            ),
          ],
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Filter Controls
              _buildFilterControls(viewModel),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 4,
                    child: OverviewWidget(
                      title: 'Total Events',
                      value: viewModel.totalEvents.toString(),
                    ),
                  ),
                  const Spacer(),
                  Expanded(
                    flex: 4,
                    child: OverviewWidget(
                      title: 'Total Revenue',
                      value: viewModel.totalRevenue,
                    ),
                  ),
                ],
              ),
              verticalSpaceMedium,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 4,
                    child: OverviewWidget(
                      title: 'Tickets Sold',
                      value: viewModel.totalTickets.toString(),
                    ),
                  ),
                  const Spacer(),
                  Expanded(
                    flex: 4,
                    child: OverviewWidget(
                      title: 'Validated',
                      value: viewModel.validatedTickets.toString(),
                    ),
                  ),
                ],
              ),
              verticalSpaceMedium,
              if (viewModel.totalGuestEntries > 0) ...[
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 4,
                      child: OverviewWidget(
                        title: 'Guest Entries',
                        value: viewModel.totalGuestEntries.toString(),
                      ),
                    ),
                    const Spacer(),
                    Expanded(
                      flex: 4,
                      child: OverviewWidget(
                        title: 'Approved',
                        value: viewModel.approvedEntries.toString(),
                      ),
                    ),
                  ],
                )
              ],

              verticalSpaceMedium,

              // Performance Trends
              PerformanceTrendsWidget(
                viewModel: viewModel,
              ),
              verticalSpaceMedium,

              // Breakdowns
              BreakdownsWidget(
                viewModel: viewModel,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilterControls(AnalyticsViewModel viewModel) {
    return Row(
      children: [
        Expanded(
          child: _buildFilterButton(
            'Event: ${viewModel.selectedEvent}',
            () => viewModel.showEventFilter(organizationId),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildFilterButton(
            'Date: ${viewModel.selectedDateRange}',
            () => viewModel.showDateFilter(organizationId),
          ),
        ),
      ],
    );
  }

  Widget _buildFilterButton(String text, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: const Color(0xFF2A2A2A),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 14,
              ),
            ),
            const Icon(
              Icons.keyboard_arrow_down,
              color: Colors.white70,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  @override
  AnalyticsViewModel viewModelBuilder(BuildContext context) =>
      AnalyticsViewModel();
}
