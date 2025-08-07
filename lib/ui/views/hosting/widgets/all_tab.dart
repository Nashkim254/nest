import 'package:flutter/material.dart';
import 'package:nest/ui/common/app_colors.dart';
import 'package:nest/ui/common/app_custom_button.dart';
import 'package:nest/ui/common/app_strings.dart';
import 'package:nest/ui/common/ui_helpers.dart';

import '../../../common/app_enums.dart';
import '../hosting_viewmodel.dart';
import 'event_card.dart';

class AllTab extends StatelessWidget {
  const AllTab({super.key, required this.viewModel});
  final HostingViewModel viewModel;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kcDarkColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          verticalSpaceMedium,
          EventCardFactory.live(
            title: 'Summer Fest 2024',
            dateTime: 'Sat, Aug 10, 2024 - 7:00 PM',
            soldTickets: 150,
            totalTickets: 200,
            onTap: () => print('Summer Fest tapped'),
            onMenuTap: () => print('Menu tapped'),
          ),

          // Upcoming event
          EventCardFactory.upcoming(
            title: 'Winter Concert 2024',
            dateTime: 'Fri, Dec 15, 2024 - 8:00 PM',
            availableTickets: 50,
            totalTickets: 300,
            onTap: () => print('Winter Concert tapped'),
          ),

          // Sold out event
          EventCardFactory.soldOut(
            title: 'Rock Festival',
            dateTime: 'Sun, Sep 22, 2024 - 6:00 PM',
            totalTickets: 500,
            onTap: () => print('Rock Festival tapped'),
          ),

          // Custom event
          EventCardFactory.custom(
            title: 'Custom Event',
            dateTime: 'Mon, Jan 1, 2025 - 12:00 AM',
            status: EventStatus.cancelled,
            statusText: 'Event cancelled due to weather',
            backgroundColor: kcDarkGreyColor,
            titleStyle: const TextStyle(
              color: Colors.red,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      floatingActionButton: AppButton(
        width: 200,
        leadingIcon: add,
        labelText: 'Create New Event',
        onTap: () {},
      ),
    );
  }
}
