import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:nest/app/app.router.dart';
import 'package:nest/models/organization_model.dart';
import 'package:nest/services/event_service.dart';
import 'package:nest/ui/views/hosting/widgets/event_card.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../models/events.dart';
import '../../../models/organization_analytics.dart';
import '../../../services/user_service.dart';
import '../../common/app_enums.dart';

class HostingViewModel extends BaseViewModel {
  HostingSelector? get selectedSelector => _selectedSelector;
  HostingSelector? _selectedSelector = HostingSelector.events;
  final userService = locator<UserService>();
  final eventService = locator<EventService>();
  final navigationService = locator<NavigationService>();
  Logger logger = Logger();
  Organization? organization;
  OrganizationAnalytics? organizationAnalytics;
  List<Event> upcomingEvents = [];
  bool hasOrganizations = false;
  void selectType(HostingSelector type) {
    _selectedSelector = type;
    notifyListeners();
  }

  navigateToCreateOrganization() async {
    final result =
        await navigationService.navigateTo(Routes.createOrganizationView);
    if (result == true) {
      // If the user successfully created an organization, refresh the list
      await getMyOrganizations();
    }
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

  onRefresh() async {
    setBusy(true);
    try {
      await getMyOrganizations();
      if (hasOrganizations) {
        await getOrganizationAnalytics();
        await getUpcomingEvents();
      }
    } catch (e) {
      logger.e('Error refreshing data: $e');
      locator<SnackbarService>().showSnackbar(
        message: 'Error refreshing data: $e',
        duration: const Duration(seconds: 3),
      );
    } finally {
      setBusy(false);
    }
  }

  Future<Organization> getMyOrganizations() async {
    setBusy(true);
    try {
      final response = await userService.getMyOrganization();
      if (response.statusCode == 200 && response.data != null) {
        hasOrganizations = true;
        organization = Organization.fromJson(response.data['organization']);
        notifyListeners();
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
    return organization!;
  }

  init() async {
    getMyOrganizations().then((Organization organization) async {
      if (hasOrganizations) {
        logger.w('My Organization: ${organization.toJson()}');

        logger.wtf(organization.id);
        await getOrganizationAnalytics();
        await getUpcomingEvents();
      }
    });
  }

  Future getOrganizationAnalytics() async {
    setBusy(true);
    try {
      final response =
          await userService.getMyOrganizationAnalytics(organization?.id!);
      if (response.statusCode == 200 && response.data != null) {
        organizationAnalytics = OrganizationAnalytics.fromJson(response.data);
        notifyListeners();
        logger.i('My Organizations Analytics: ${response.data}');
      } else if (response.statusCode == 404) {
        hasOrganizations = false;
        logger.w('No organizations Analytics found');
        notifyListeners();
      } else {
        logger.e('Failed to load organization Analytics: ${response.message}');
        locator<SnackbarService>().showSnackbar(
          message: response.message ?? 'Failed to load organizations Analytics',
          duration: const Duration(seconds: 3),
        );
      }
    } catch (e) {
      // Handle exception
    } finally {
      setBusy(false);
    }
  }

  navigateToEventDetails(Event event) {
    locator<NavigationService>().navigateToViewEventView(event: event);
  }

  int page = 1;
  int size = 10;
  Future getUpcomingEvents() async {
    setBusy(true);
    try {
      final response = await eventService.getMyEvents(page: page, size: size);
      if (response.statusCode == 200 || response.statusCode == 201) {
        logger.i('Upcoming Events: ${response.data['events']}');

        final eventsList = response.data['events'];
        logger.i('Number of events: ${eventsList.length}');

        upcomingEvents = eventsList
            .map((event) {
              logger.i('Parsing event: $event');
              try {
                return Event.fromJson(event);
              } catch (e) {
                logger.e('Failed to parse event: $event');
                logger.e('Error: $e');
                return null;
              }
            })
            .whereType<Event>() // Only keep Event objects, filter out nulls
            .toList()
            .take(5)
            .toList();
        logger.w('Upcoming Events: $upcomingEvents');

        return response.data;
      } else {
        logger.e('Failed to load upcoming events: ${response.message}');
        locator<SnackbarService>().showSnackbar(
          message: response.message ?? 'Failed to load upcoming events',
          duration: const Duration(seconds: 3),
        );
      }
    } catch (e, s) {
      logger.e('Error fetching upcoming events: $s');
      locator<SnackbarService>().showSnackbar(
        message: 'Error fetching upcoming events: $e',
        duration: const Duration(seconds: 3),
      );
    } finally {
      setBusy(false);
    }
  }

  navigateToCreateEvent() async {
    final result =
        await locator<NavigationService>().navigateToCreateEventView();
    if (result == true) {
      // If the user successfully created an event, refresh the list
      await getUpcomingEvents();
    }
  }

  navigateToOrganizationAnalytics() {
    locator<NavigationService>()
        .navigateToAnalyticsView(organizationId: organization!.id!);
  }

  navigateToScanTicket() {
    locator<NavigationService>().navigateToTicketScanningView();
  }
}
