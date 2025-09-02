import 'package:geolocator/geolocator.dart';
import 'package:logger/logger.dart';
import 'package:nest/app/app.router.dart';
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
          false; // This means "at least one ticket is NOT protected"
    } else {
      isPasswordProtected = true; // This means "ALL tickets ARE protected"
    }
  }

  init(Event event, String password) async {
    logger.wtf('$isPasswordProtected');
    await getCurrentLocation();
    await getSingleEvent(event.id, password).then(
      (_) => setIsPasswordRequired(),
    );
  }

  int page = 1;
  int size = 10;
  Event? event;
  final eventService = locator<EventService>();
  Logger logger = Logger();
  Future getSingleEvent(int id, String password) async {
    //X-Event-Password
    setBusy(true);
    try {
      final response =
          await eventService.getSingleEvent(id: id, password: password);
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
    locator<SharedPreferencesService>().setInt('eventId', event!.id);
    final passwordProtectedTickets = event!.ticketPricing
        .where((t) => t.isPasswordProtected == true)
        .toList();

    final totalTickets = event!.ticketPricing.length;

    // Single password-protected ticket → Direct password dialog
    if (totalTickets == 1 && passwordProtectedTickets.length == 1) {
      final ticket = passwordProtectedTickets.first;
      final response = await dialogService.showCustomDialog(
        variant: DialogType.passwordProtected,
        title: 'Password Required for ${ticket.name ?? 'This Ticket'}',
        description:
            'This ticket requires a password. Please enter the password to continue.',
        barrierDismissible: true,
      );

      if (response!.confirmed) {
        final password = response.data['password'];
        final isValid =
            await validateTicketPassword(password, event!.id, ticket.id);

        if (isValid) {
          // Proceed with purchase
          await _processPurchase(ticket);
        } else {
          locator<SnackbarService>().showSnackbar(
            message: 'Incorrect password for this ticket.',
            duration: const Duration(seconds: 3),
          );
        }
      }
    }
    // Multiple tickets OR single non-protected → Bottom sheet handles everything
    else {
      await _showTicketBottomSheet();
    }
  }

// Simplified bottom sheet - handles all multi-ticket scenarios
  Future<void> _showTicketBottomSheet() async {
    final formattedTickets = event!.ticketPricing.asMap().entries.map((entry) {
      final index = entry.key;
      final ticket = entry.value;

      return {
        'index': index,
        'id': ticket.id,
        'event_id': event!.id,
        'name': ticket.name ?? 'Ticket ${index + 1}',
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
      'tickets': formattedTickets,
      'event_id': event!.id,
    });

    // The enhanced bottom sheet will handle password dialogs internally
    if (result != null && result.confirmed) {
      // Checkout data already includes unlocked tickets
      final checkoutData = result.data;
      logger.i('Proceeding to checkout: $checkoutData');

      // Navigate to checkout or handle purchase
      locator<NavigationService>().navigateToCheckoutView(
        ticketInfo: checkoutData,
      );
    }
  }

// Process purchase for direct single ticket flow
  Future<void> _processPurchase(dynamic ticket) async {
    logger.i('Processing purchase for ticket: ${ticket.id}');

    // Create checkout data for single ticket
    final checkoutData = {
      'tickets': [
        {
          ...ticket.toJson(), // or however you convert ticket to map
          'selected_quantity': 1,
          'subtotal': ticket.price ?? 0.0,
        }
      ],
      'total_price': ticket.price ?? 0.0,
      'total_quantity': 1,
      'requires_password': false, // Already validated
    };

    locator<NavigationService>().navigateToCheckoutView(
      ticketInfo: checkoutData,
    );
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
  goToEdit(Event event) {
    locator<NavigationService>().navigateToEditEventView(event: event);
  }
}
