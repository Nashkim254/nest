// Updated TicketsSheetModel to handle multiple tickets
import 'package:logger/logger.dart';
import 'package:nest/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';

class TicketsSheetModel extends BaseViewModel {
  List<Map<String, dynamic>> _tickets = [];
  List<Map<String, dynamic>> get tickets => _tickets;
//completer
  Function(SheetResponse)? completer;
  bool _isPasswordProtected = false;
  bool get isPasswordProtected => _isPasswordProtected;

  // Track selected tickets and their quantities
  Map<String, int> _selectedTickets = {};
  Map<String, int> get selectedTickets => _selectedTickets;

  bool get hasSelectedTickets => _selectedTickets.isNotEmpty;

  Logger logger = Logger();

  void init(dynamic ticketData, completer) {
    this.completer = completer;
    if (ticketData is List) {
      // Multiple tickets from ticketPricing array
      _tickets = List<Map<String, dynamic>>.from(ticketData);

      // Check if any ticket requires password
      _isPasswordProtected =
          _tickets.every((ticket) => ticket['password_required'] == true);
    } else if (ticketData is Map) {
      // Single ticket
      _tickets = [Map<String, dynamic>.from(ticketData)];
      _isPasswordProtected = ticketData['password_required'] ?? false;
    }

    logger.i('Initialized with ${_tickets.length} tickets');
    logger.i('Password protected: $_isPasswordProtected');
    notifyListeners();
  }

  int getQuantity(String ticketId) => _selectedTickets[ticketId] ?? 0;

  bool isSelected(String ticketId) => _selectedTickets.containsKey(ticketId);

  void selectTicket(String ticketId) {
    _selectedTickets[ticketId] = 1;
    logger.d('Selected ticket: $ticketId');
    notifyListeners();
  }

  void increaseQuantity(String ticketId) {
    final currentQuantity = _selectedTickets[ticketId] ?? 0;
    final ticket =
        _tickets.firstWhere((t) => t['index'].toString() == ticketId);
    final limit = ticket['limit'] ?? 10; // Default limit if not specified

    if (currentQuantity < limit) {
      _selectedTickets[ticketId] = currentQuantity + 1;
      notifyListeners();
    }
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

  // Get total price for selected tickets
  double get totalPrice {
    double total = 0;
    for (var entry in _selectedTickets.entries) {
      final ticket = _tickets.firstWhere(
        (t) => t['index'].toString() == entry.key,
        orElse: () => {},
      );
      if (ticket.isNotEmpty) {
        total += (ticket['price'] ?? 0) * entry.value;
      }
    }
    return total;
  }

  // Get total quantity of selected tickets
  int get totalQuantity {
    return _selectedTickets.values.fold(0, (sum, quantity) => sum + quantity);
  }

  // Check if a specific ticket requires password
  bool ticketRequiresPassword(String ticketId) {
    final ticket = _tickets.firstWhere(
      (t) => t['index'].toString() == ticketId,
      orElse: () => {},
    );
    return ticket['password_required'] ?? false;
  }

  // Get selected tickets with their details
  List<Map<String, dynamic>> getSelectedTicketsDetails() {
    List<Map<String, dynamic>> selectedDetails = [];

    for (var entry in _selectedTickets.entries) {
      final ticket = _tickets.firstWhere(
        (t) => t['index'].toString() == entry.key,
        orElse: () => {},
      );

      if (ticket.isNotEmpty) {
        selectedDetails.add({
          ...ticket,
          'selected_quantity': entry.value,
          'subtotal': (ticket['price'] ?? 0) * entry.value,
        });
      }
    }

    return selectedDetails;
  }

  void checkout() {
    if (!hasSelectedTickets) return;

    final selectedDetails = getSelectedTicketsDetails();

    // Check if any selected ticket requires password
    final requiresPassword =
        selectedDetails.any((ticket) => ticket['password_required'] == true);

    final checkoutData = {
      'tickets': selectedDetails,
      'total_price': totalPrice,
      'total_quantity': totalQuantity,
      'requires_password': requiresPassword,
      'is_mixed_protection': !_isPasswordProtected && requiresPassword,
    };

    logger.i('Checkout data: $checkoutData');

    // Complete the sheet with the data
    completer?.call(SheetResponse(
      confirmed: true,
      data: checkoutData,
    ));
    locator<NavigationService>().navigateToCheckoutView(
      ticketInfo: checkoutData,
    );
    clearSelection();
  }

  void clearSelection() {
    _selectedTickets.clear();
    notifyListeners();
  }
}
