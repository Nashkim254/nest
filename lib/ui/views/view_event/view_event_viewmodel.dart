import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.dialogs.dart';
import '../../../app/app.locator.dart';
import '../../../models/events.dart';
import '../../../services/event_service.dart';
import '../../../services/location_service.dart';

class ViewEventViewModel extends BaseViewModel {
  final locationService = locator<LocationService>();
  Map? coordinates = {'latitude': 0.0, 'longitude': 0.0};
  getCurrentLocation() async {
    setBusy(true);
    try {
      coordinates = await locationService.getCoordinatesFromCurrentLocation();
      notifyListeners();
    } catch (e) {
      locator<DialogService>().showDialog(
        title: 'Error',
        description: 'Could not get current location. Please try again later.',
      );
    } finally {
      setBusy(false);
    }
  }

  init(Event event) async {
    await getCurrentLocation();
    await getSingleEvent(event.id);
  }

  int page = 1;
  int size = 10;
  Event? event;
  final eventService = locator<EventService>();
  Logger logger = Logger();
  Future getSingleEvent(int id) async {
    setBusy(true);
    try {
      final response = await eventService.getSingleEvent(id: id);
      if (response.statusCode == 200 || response.statusCode == 201) {
        logger.i('Upcoming Events: ${response.data['event']}');

        final result = response.data;
        logger.i('event: ${event}');
        event = Event.fromJson(result);
        logger.w('Event: ${event!.toJson()}');
        notifyListeners();
        return response.data;
      } else {
        logger.e('Failed to load upcoming events: ${response.message}');
        locator<SnackbarService>().showSnackbar(
          message: response.message ?? 'Failed to load upcoming events',
          duration: const Duration(seconds: 3),
        );
      }
    } catch (e, s) {
      logger.e('Error fetching upcoming events: $e');
      locator<SnackbarService>().showSnackbar(
        message: 'Error fetching upcoming events: $e',
        duration: const Duration(seconds: 3),
      );
    } finally {
      setBusy(false);
    }
  }

  bool isPasswordProtected = true;

  String getButtonTitle() {
    if (event!.ticketPricing.first.type == 'rsvp') {
      return 'RSVP';
    } else if (event!.ticketPricing.first.type == 'paid') {
      return 'Buy Ticket';
    } else {
      return 'Get Ticket';
    }
  }

  final dialogService = locator<DialogService>();
  passwordProtected() async {
    final response = await dialogService.showCustomDialog(
      variant: DialogType.passwordProtected,
      title: 'Type the event password to have purchase the ticket',
      description:
          'This event is password protected. Please enter the password to continue.',
      barrierDismissible: false,
    );
    if (response!.confirmed) {
      final password = response.responseData['password'];
      if (password == event!.password) {

        notifyListeners();
      } else {
        locator<SnackbarService>().showSnackbar(
          message: 'Incorrect password. Please try again.',
          duration: const Duration(seconds: 3),
        );
      }
    } else {
      locator<SnackbarService>().showSnackbar(
        message: 'You cancelled the password entry.',
        duration: const Duration(seconds: 3),
      );
    }
  }
}
