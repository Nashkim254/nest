import 'package:logger/logger.dart';
import 'package:nest/services/event_service.dart';
import 'package:nest/ui/common/app_strings.dart';
import 'package:stacked/stacked.dart';

import '../../../app/app.locator.dart';
import '../../../models/ticket.dart';
import '../../../services/user_service.dart';

class TicketsViewModel extends BaseViewModel {
  final userService = locator<UserService>();
  final eventService = locator<EventService>();
  Logger logger = Logger();
  List<Ticket> tickets = [];

  init() async {
    setBusy(true);
    try {
      await getTickets();
      notifyListeners();
    } catch (e) {
      logger.e('Error initializing userServicetickets: $e');
    } finally {
      setBusy(false);
    }
  }

  Future<void> getTickets() async {
    setBusy(true);
    try {
      final response = await userService.getMyTickets();
      if (response.statusCode == 200 || response.statusCode == 201) {
        tickets = (response.data as List)
            .map((ticket) => Ticket.fromJson(ticket))
            .toList();
        logger.i('Tickets fetched successfully: ${tickets.length} tickets');
      } else {
        throw Exception(response.message ?? 'Failed to fetch tickets');
      }
      notifyListeners();
    } catch (e) {
      logger.e('Error fetching tickets: $e');
    } finally {
      setBusy(false);
    }
  }

  //verify tickets

  Future<void> verifyTicket(String qr, int eventId) async {
    setBusy(true);
    try {
      final response =
          await eventService.validateTicket(qrData: qr, eventId: eventId);
      if (response.statusCode == 200 || response.statusCode == 201) {
        logger.i('Ticket validated successfully: ${response.data}');
      } else {
        throw Exception(response.message ?? 'Failed to validate ticket');
      }
      notifyListeners();
    } catch (e) {
      logger.e('Error  validating ticket: $e');
    } finally {
      setBusy(false);
    }
  }
}
