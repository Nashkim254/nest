import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:nest/models/events.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';
import '../../../services/event_service.dart';

class ExploreEventsViewModel extends BaseViewModel {
  final searchController = TextEditingController();
  String _searchQuery = '';
  final searchFocusNode = FocusNode();

  String get searchQuery => _searchQuery;

  set searchQuery(String value) {
    _searchQuery = value;
    notifyListeners();
  }

  int page = 1;
  int size = 10;
  List<Event> upcomingEvents = [];

  // Add these new properties
  bool _isLoadingMore = false;
  bool _hasMoreData = true;

  bool get isLoadingMore => _isLoadingMore;
  bool get hasMoreData => _hasMoreData;

  final eventService = locator<EventService>();
  final navigationService = locator<NavigationService>();
  Logger logger = Logger();

  void init() async {
    logger.w('Events back');
    page = 1;
    _hasMoreData = true;
    await getUpcomingEvents();
    Future.delayed(const Duration(milliseconds: 300), () {
      searchFocusNode.requestFocus();
    });
  }

  onSearchChanged(String value) {
    searchQuery = value;
    if (searchQuery.isEmpty) {
      page = 1;
      _hasMoreData = true;
      init();
      return;
    }

    Future.delayed(const Duration(milliseconds: 500), () {
      if (searchQuery.isNotEmpty) {
        page = 1;
        _hasMoreData = true;
        searchEvent();
      } else {
        getUpcomingEvents();
      }
    });
  }

  Future getUpcomingEvents({bool isLoadMore = false}) async {
    logger.w(
        'Fetching upcoming events, page: $page, size: $size, isLoadMore: $isLoadMore');

    if (isLoadMore) {
      _isLoadingMore = true;
      notifyListeners();
    } else {
      setBusy(true);
    }

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

        // Check if we have more data
        if (parsedEvents.length < size) {
          _hasMoreData = false;
        }

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
      if (isLoadMore) {
        _isLoadingMore = false;
      } else {
        setBusy(false);
      }
      notifyListeners();
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

        // Check if we have more data for search results too
        if (parsedEvents.length < size) {
          _hasMoreData = false;
        }

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
    _hasMoreData = true;
    await getUpcomingEvents();
  }

  Future<void> onLoadMore() async {
    // Prevent multiple simultaneous load more calls
    if (_isLoadingMore || !_hasMoreData) {
      return;
    }

    page++;
    await getUpcomingEvents(isLoadMore: true);
  }

  navigateToCreateEvent() {
    locator<NavigationService>().navigateTo(Routes.createEventView);
  }

  navigateToViewEvent(Event event) {
    locator<NavigationService>().navigateToViewEventView(event: event);
  }

  @override
  void dispose() {
    searchController.dispose();
    searchFocusNode.dispose();
    super.dispose();
  }
}
