import 'package:flutter/material.dart';
import 'package:nest/models/events.dart';
import 'package:nest/ui/common/app_custom_appbar.dart';
import 'package:nest/ui/views/manage_events/widgets/bottom_bar.dart';
import 'package:nest/ui/views/manage_events/widgets/event_card.dart';
import 'package:nest/ui/views/manage_events/widgets/event_fab.dart';
import 'package:nest/ui/views/manage_events/widgets/filter_bar.dart';
import 'package:stacked/stacked.dart';

import 'manage_events_viewmodel.dart';

class ManageEventsView extends StackedView<ManageEventsViewModel> {
  const ManageEventsView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    ManageEventsViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F0F),
      appBar: CustomAppBar(
        title: 'Manage Events',
        onSearchPressed: () {
          // Implement search functionality
        },
      ),
      body: Column(
        children: [
          FilterTabBar(
            selectedFilter: viewModel.selectedFilter,
            onFilterChanged: viewModel.setFilter,
          ),
          Expanded(
            child: viewModel.filteredEvents.isEmpty
                ? const Center(
                    child: Text(
                      'No events found',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 16,
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: viewModel.filteredEvents.length,
                    itemBuilder: (context, index) {
                      final event = viewModel.filteredEvents[index];
                      return EventCard(
                        event: event,
                        onMorePressed: () {
                          _showEventOptions(context, viewModel, event);
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: CreateEventFAB(
        onPressed: viewModel.createNewEvent,
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: 1, // Hosting tab is selected
        onTap: (index) {
          // Handle navigation
        },
      ),
    );
  }

  void _showEventOptions(
    BuildContext context,
    ManageEventsViewModel viewModel,
    Event event,
  ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: const Color(0xFF2A2A2A),
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.edit, color: Colors.white),
              title: const Text(
                'Edit Event',
                style: TextStyle(color: Colors.white),
              ),
              onTap: () {
                Navigator.pop(context);
                // Navigate to edit event
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete, color: Colors.red),
              title: const Text(
                'Delete Event',
                style: TextStyle(color: Colors.red),
              ),
              onTap: () {
                Navigator.pop(context);
                viewModel.deleteEvent(event.id);
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  ManageEventsViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      ManageEventsViewModel();
}
