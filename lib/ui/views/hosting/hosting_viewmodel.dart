import 'package:flutter/material.dart';
import 'package:nest/ui/views/hosting/widgets/event_card.dart';
import 'package:stacked/stacked.dart';

import '../../common/app_colors.dart';
import '../../common/app_enums.dart';

class HostingViewModel extends BaseViewModel {
  HostingSelector? get selectedSelector => _selectedSelector;
  HostingSelector? _selectedSelector = HostingSelector.events;

  void selectType(HostingSelector type) {
    _selectedSelector = type;
    notifyListeners();
  }

  String getSelectorLabel(HostingSelector type) {
    switch (type) {
      case HostingSelector.events:
        return 'Events';
      case HostingSelector.analytics:
        return 'Analytics';
      case HostingSelector.quickActions:
        return 'Quick Actions';
    }
  }

  List sampleData = [
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
  ];
}
