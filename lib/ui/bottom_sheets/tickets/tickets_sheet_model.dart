import 'package:logger/logger.dart';
import 'package:nest/app/app.locator.dart';
import 'package:nest/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class TicketsSheetModel extends BaseViewModel {
  var ticket = {};
  init(var tick) {
    ticket = tick;
  }

  Map<String, int> _selectedTickets = {};
  Map<String, int> get selectedTickets => _selectedTickets;

  bool get hasSelectedTickets => _selectedTickets.isNotEmpty;

  int getQuantity(String ticketId) => _selectedTickets[ticketId] ?? 0;

  bool isSelected(String ticketId) => _selectedTickets.containsKey(ticketId);

  void selectTicket(String ticketId) {
    _selectedTickets[ticketId] = 1;
    notifyListeners();
  }

  void increaseQuantity(String ticketId) {
    _selectedTickets[ticketId] = (_selectedTickets[ticketId] ?? 0) + 1;
    notifyListeners();
  }

  void decreaseQuantity(String ticketId) {
    if (_selectedTickets[ticketId] != null) {
      if (_selectedTickets[ticketId]! > 1) {
        _selectedTickets[ticketId] = _selectedTickets[ticketId]! - 1;
      } else {
        _selectedTickets.remove(ticketId);
      }
      notifyListeners();
    }
  }

  Logger logger = Logger();
  void checkout() {
    if (hasSelectedTickets) {
      String ticketInfo =
          _selectedTickets.entries.map((entry) => '${entry.value}').join(', ');
      logger.w(ticket);
      ticket.addEntries({'quantity': ticketInfo}.entries);
      logger.i('Checkout: $ticket');
      locator<NavigationService>().back();
      locator<NavigationService>().navigateToCheckoutView(ticketInfo: ticket);
      clearSelection();
    }
  }

  void clearSelection() {
    _selectedTickets.clear();
    notifyListeners();
  }
}
