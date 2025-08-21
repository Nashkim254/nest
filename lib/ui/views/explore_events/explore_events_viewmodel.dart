import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:nest/models/events.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';
import '../../../models/event_data.dart';
import '../../../services/event_service.dart';
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
  void init() async {
    logger.w('Events back');
    await getUpcomingEvents();
  }

  onSearchChanged(String value) {

    searchQuery = value;
    if(searchQuery.isEmpty) {
      init(); // Notify listeners to update UI
      return;
    }
    //debounce the search to avoid too many requests
    Future.delayed(const Duration(milliseconds: 500), () {
      if (searchQuery.isNotEmpty) {
        searchEvent();
      } else {
        getUpcomingEvents();
      }
    });
  }

  int page = 1;
  int size = 10;
  List<Event> upcomingEvents = [];
  final eventService = locator<EventService>();
  final navigationService = locator<NavigationService>();
  Logger logger = Logger();
  Future getUpcomingEvents({bool isLoadMore = false}) async {
    logger.w('Fetching upcoming events, page: $page, size: $size, isLoadMore: $isLoadMore');
    setBusy(true);
    try {
      final response = await eventService.getMyEvents(page: page, size: size);
      if (response.statusCode == 200 || response.statusCode == 201) {
        final eventsList = response.data['events'];

        final parsedEvents = eventsList
            .map<Event?>((event) {
              try {
                return Event.fromJson(event);
              } catch (e) {
                logger.e('Failed to parse event: $event\nError: $e');
                return null;
              }
            })
            .whereType<Event>()
            .toList();

        if (isLoadMore) {
          upcomingEvents.addAll(parsedEvents);
        } else {
          upcomingEvents = parsedEvents;
        }

        notifyListeners();
      } else {
        locator<SnackbarService>().showSnackbar(
          message: response.message ?? 'Failed to load upcoming events',
          duration: const Duration(seconds: 3),
        );
      }
    } catch (e, s) {
      logger.e('Error fetching events: $s');
      locator<SnackbarService>().showSnackbar(
        message: 'Error fetching upcoming events: $e',
        duration: const Duration(seconds: 3),
      );
    } finally {
      setBusy(false);
    }
  }

  Future searchEvent() async {
    setBusy(true);
    try {
      final response = await eventService.searchEvents(
        query: searchQuery,
        page: page,
        size: size,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        final eventsList = response.data['events'];

        final parsedEvents = eventsList
            .map<Event?>((event) {
              try {
                return Event.fromJson(event);
              } catch (e) {
                logger.e('Failed to parse event: $event\nError: $e');
                return null;
              }
            })
            .whereType<Event>()
            .toList();

        upcomingEvents = parsedEvents;
        notifyListeners();
      } else {
        locator<SnackbarService>().showSnackbar(
          message: response.message ?? 'Failed to search events',
          duration: const Duration(seconds: 3),
        );
      }
    } catch (e, s) {
      logger.e('Error searching events: $s');
      locator<SnackbarService>().showSnackbar(
        message: 'Error searching events: $e',
        duration: const Duration(seconds: 3),
      );
    } finally {
      setBusy(false);
    }
  }

  Future<void> onRefresh() async {
    page = 1;
    await getUpcomingEvents();
  }

  Future<void> onLoadMore() async {
    page++;
    await getUpcomingEvents(isLoadMore: true);
  }

  navigateToCreateEvent() {
    locator<NavigationService>().navigateTo(Routes.createEventView);
  }
  navigateToViewEvent(Event event) {
    locator<NavigationService>().navigateToViewEventView(event: event);
  }
}
