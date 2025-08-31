import 'package:geolocator/geolocator.dart';
import 'package:logger/logger.dart';
import 'package:nest/services/shared_preferences_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.bottomsheets.dart';
import '../../../app/app.dialogs.dart';
import '../../../app/app.locator.dart';
import '../../../models/events.dart';
import '../../../services/event_service.dart';
import '../../../services/location_service.dart';

class ViewEventViewModel extends BaseViewModel {
  final locationService = locator<LocationService>();
  Position? coordinates;
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

  setIsPasswordRequired() {
    if (event!.ticketPricing.any((t) => t.isPasswordProtected == false)) {
      isPasswordProtected =
          false; // At least one ticket is open, handle individually later
    } else {
      isPasswordProtected =
          true; // All tickets require password, can handle globally
    }
  }

  init(Event event) async {
    logger.wtf('$isPasswordProtected');
    await getCurrentLocation();
    await getSingleEvent(event.id).then(
      (_) => setIsPasswordRequired(),
    );
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
        logger.i('event: ${result['']}');
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
    if (isPasswordProtected) {
      return 'Enter Password';
    } else if (event!.ticketPricing.first.type == 'rsvp') {
      return 'RSVP';
    } else if (event!.ticketPricing.first.type == 'paid') {
      return 'Buy Ticket';
    } else {
      return 'Get Ticket';
    }
  }

  final dialogService = locator<DialogService>();
  final bottomSheetService = locator<BottomSheetService>();
  passwordProtected() async {
    if (isPasswordProtected) {
      final response = await dialogService.showCustomDialog(
        variant: DialogType.passwordProtected,
        title: 'Type the event password to have purchase the ticket',
        description:
            'This event is password protected. Please enter the password to continue.',
        barrierDismissible: true,
      );
      if (response!.confirmed) {
        logger.i(response.data);
        final password = response.data['password'];

        await validateTicketPassword(
          password,
          event!.id,
          event!.ticketPricing.first.id,
        );
        notifyListeners();
      } else {
        locator<SnackbarService>().showSnackbar(
          message: 'You cancelled the password entry.',
          duration: const Duration(seconds: 3),
        );
      }
    } else {
      final formattedTickets =
          event!.ticketPricing.asMap().entries.map((entry) {
        final index = entry.key;
        final ticket = entry.value;

        return {
          'index': index,
          'name': ticket.name ?? '',
          'price': ticket.price ?? 0.0,
          'type': ticket.type ?? 'paid',
          'available': (ticket.quantity ?? 0) > 0,
          'limit': ticket.quantity ?? 10,
          'password_required': ticket.isPasswordProtected ?? false,
          'description': '',
        };
      }).toList();
      final result = await bottomSheetService
          .showCustomSheet(variant: BottomSheetType.tickets, data: {
        'tickets': formattedTickets, // Multiple tickets
      });
    }
  }

  bool isValidating = false;
  Future validateTicketPassword(
      String password, int eventId, int ticketId) async {
    isValidating = true;
    notifyListeners();
    try {
      final response = await eventService.validateTicketPassword(
          password: password, eventId: eventId, ticketId: ticketId);
      if (response.statusCode == 200 || response.statusCode == 201) {
        logger.w(response.data['ticket']);
        locator<SharedPreferencesService>().setInt('eventId', eventId);
        locator<SharedPreferencesService>().setInt('ticketId', ticketId);
        logger.i('Ticket id-------: ${ticketId}');
        final result = await bottomSheetService.showCustomSheet(
          variant: BottomSheetType.tickets,
          data: {
            'ticket': response.data['ticket'], // Single ticket
          },
        );
        if (result != null) {
          logger.i(result.data);
        }
      } else {
        logger.e(response.message);
        locator<SnackbarService>().showSnackbar(
          message: response.message ?? 'Failed to validate ticket password',
          duration: const Duration(seconds: 3),
        );
      }
    } catch (e, s) {
      logger.e(s.toString());
      locator<SnackbarService>().showSnackbar(
        message: '$e',
        duration: const Duration(seconds: 3),
      );
    } finally {
      isValidating = false;
      notifyListeners();
    }
  }
}
