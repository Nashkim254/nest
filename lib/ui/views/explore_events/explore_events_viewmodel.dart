import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';
import '../../../models/event_data.dart';
import '../../common/app_enums.dart';
import '../../common/app_strings.dart';

class ExploreEventsViewModel extends BaseViewModel {
  // This ViewModel can be extended with properties and methods
  // specific to the Explore Events view, such as fetching events,
  // filtering, or handling user interactions.
  final searchController = TextEditingController();
  // Example property
  String _searchQuery = '';

  // Example getter for search query
  String get searchQuery => _searchQuery;

  // Example setter for search query
  set searchQuery(String value) {
    _searchQuery = value;
    notifyListeners(); // Notify listeners about the change
  }

  // Example method to initialize data or fetch events
  void init() {
    // Initialization logic here
  }
  onSearchChanged(String value) {
    searchQuery = value;
  }

  List<EventCardData> events = [
    EventCardData(
      title: 'Techno Pulse',
      dateTime: 'Fri, Oct 27 • 9 PM',
      status: EventStatus.upcoming,
      statusText: 'Upcoming',
      imageUrl: ev3,
      location: 'Downtown Arena',
    ),
    EventCardData(
      title: 'Jazz Nights',
      dateTime: 'Sat, Oct 28 • 8 PM',
      status: EventStatus.live,
      statusText: 'Tickets Sold: 150/200',
      imageUrl: ev2,
      location: 'City Jazz Club',
    ),
    EventCardData(
      title: 'Rock Fest',
      dateTime: 'Sun, Oct 29 • 7 PM',
      status: EventStatus.soldOut,
      statusText: 'All 300 tickets sold',
      imageUrl: ev1,
      location: 'Stadium Grounds',
    ),
  ];
  navigateToCreateEvent() {
    locator<NavigationService>().navigateTo(Routes.createEventView);
  }
}
