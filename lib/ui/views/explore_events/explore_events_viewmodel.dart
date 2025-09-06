import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:nest/models/events.dart';
import 'package:nest/services/share_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';
import '../../../models/profile.dart';
import '../../../services/event_service.dart';
import '../../../services/shared_preferences_service.dart';

class ExploreEventsViewModel extends BaseViewModel {
  final searchController = TextEditingController();
  final passwordController = TextEditingController();
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

  bool _isLoadingMore = false;
  bool _hasMoreData = true;
  bool _showPasswordDialogState = false;
  bool _showPassword = false;
  bool _isValidatingPassword = false;
  String _passwordError = '';
  Event? _currentPasswordProtectedEvent;

  bool get isLoadingMore => _isLoadingMore;
  bool get hasMoreData => _hasMoreData;
  bool get showPasswordDialogState => _showPasswordDialogState;
  bool get showPassword => _showPassword;
  bool get isValidatingPassword => _isValidatingPassword;
  String get passwordError => _passwordError;

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
    await getUser();
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

        if (parsedEvents.length < size) {
          _hasMoreData = false;
        }

        if (isLoadMore) {
          upcomingEvents.addAll(parsedEvents);
        } else {
          upcomingEvents = parsedEvents;
        }
        logger.wtf('Upcoming events: ${upcomingEvents.last.toJson()}');
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
    if (_isLoadingMore || !_hasMoreData) {
      return;
    }

    page++;
    await getUpcomingEvents(isLoadMore: true);
  }

  // Password dialog methods
  void showPasswordDialog(BuildContext context, Event event) {
    _currentPasswordProtectedEvent = event;
    _showPasswordDialogState = true;
    _passwordError = '';
    passwordController.clear();
    notifyListeners();
  }

  void closePasswordDialog() {
    _showPasswordDialogState = false;
    // _currentPasswordProtectedEvent = null;
    _passwordError = '';
    _showPassword = false;
    // passwordController.clear();
    notifyListeners();
  }

  void togglePasswordVisibility() {
    _showPassword = !_showPassword;
    notifyListeners();
  }

  Future<void> validatePassword() async {
    if (passwordController.text.isEmpty) {
      _passwordError = 'Please enter a password';
      notifyListeners();
      return;
    }

    if (_currentPasswordProtectedEvent == null) {
      _passwordError = 'Event not found';
      notifyListeners();
      return;
    }

    _isValidatingPassword = true;
    _passwordError = '';
    notifyListeners();

    try {
      closePasswordDialog();
      logger.wtf(
          '_currentPasswordProtectedEvent: ${_currentPasswordProtectedEvent!}');
      navigateToViewEvent(_currentPasswordProtectedEvent!);
    } catch (e, s) {
      _passwordError = 'Error validating password. Please try again.';
      logger.e('Password validation error: $s');
    } finally {
      _isValidatingPassword = false;
      notifyListeners();
    }
  }

  navigateToCreateEvent() {
    locator<NavigationService>().navigateTo(Routes.createEventView);
  }

  navigateToViewEvent(Event event) {
    locator<NavigationService>().navigateToViewEventView(
      event: event,
      password: passwordController.text.trim(),
    );
  }

  Profile? profile;
  getUser() {
    var user = locator<SharedPreferencesService>().getUserInfo();
    profile = Profile.fromJson(user!);
    notifyListeners();
  }

  // Share event functionality
  void shareEvent(Event event) {
    ShareService.shareEvent(
      eventId: event.id.toString(),
      title: event.title,
      description: event.description,
      imageUrl: event.flyerUrl,
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    passwordController.dispose();
    searchFocusNode.dispose();
    super.dispose();
  }
}
