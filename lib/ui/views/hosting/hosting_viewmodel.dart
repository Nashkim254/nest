import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:nest/app/app.router.dart';
import 'package:nest/ui/views/hosting/widgets/event_card.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../services/user_service.dart';
import '../../common/app_colors.dart';
import '../../common/app_enums.dart';

class HostingViewModel extends BaseViewModel {
  HostingSelector? get selectedSelector => _selectedSelector;
  HostingSelector? _selectedSelector = HostingSelector.events;
  final userService = locator<UserService>();
  final navigationService = locator<NavigationService>();
  Logger logger = Logger();
  bool hasOrganizations = false;
  void selectType(HostingSelector type) {
    _selectedSelector = type;
    notifyListeners();
  }

  navigateToCreateOrganization() {
    navigationService.navigateTo(Routes.createOrganizationView);
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
  Future getMyOrganizations() async {
    setBusy(true);
    try {
      final response = await userService.getMyOrganization();
      if (response.statusCode == 200 && response.data != null) {
        hasOrganizations = true;
        notifyListeners();
        logger.i('My Organizations: ${response.data}');
      } else if (response.statusCode == 404) {
        hasOrganizations = false;
        logger.w('No organizations found');
        notifyListeners();
      } else {
        // Handle error response
        logger.e('Failed to load organizations: ${response.message}');
        locator<SnackbarService>().showSnackbar(
          message: response.message ?? 'Failed to load organizations',
          duration: const Duration(seconds: 3),
        );
      }
    } catch (e) {
      // Handle exception
    } finally {
      setBusy(false);
    }
  }

  navigateToCreateEvent() {
    locator<NavigationService>().navigateToCreateEventView();
  }
}
