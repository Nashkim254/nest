import 'package:logger/logger.dart';
import 'package:nest/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.dialogs.dart';
import '../../../app/app.locator.dart';
import '../../../services/event_service.dart';
import '../../../services/shared_preferences_service.dart';

class TicketsSheetModel extends BaseViewModel {
  List<Map<String, dynamic>> _tickets = [];
  List<Map<String, dynamic>> get tickets => _tickets;

  Function(SheetResponse)? completer;
  bool _isPasswordProtected = false;
  bool get isPasswordProtected => _isPasswordProtected;

  // Track selected tickets and their quantities
  Map<String, int> _selectedTickets = {};
  Map<String, int> get selectedTickets => _selectedTickets;

  // Track unlocked tickets (for password-protected ones)
  Set<String> _unlockedTickets = {};

  bool get hasSelectedTickets => _selectedTickets.isNotEmpty;
  bool get allTicketsPasswordProtected =>
      _tickets.isNotEmpty &&
      _tickets.every((ticket) => ticket['password_required'] == true);

  Logger logger = Logger();
  final _dialogService = locator<DialogService>();

  void init(dynamic ticketData, completer) {
    this.completer = completer;

    if (ticketData is List) {
      _tickets = List<Map<String, dynamic>>.from(ticketData);
      _isPasswordProtected =
          _tickets.every((ticket) => ticket['password_required'] == true);
    } else if (ticketData is Map) {
      _tickets = [Map<String, dynamic>.from(ticketData)];
      _isPasswordProtected = ticketData['password_required'] ?? false;
    }

    logger.i('Initialized with ${_tickets.length} tickets');
    notifyListeners();
  }

  int getQuantity(String ticketId) => _selectedTickets[ticketId] ?? 0;
  bool isSelected(String ticketId) => _selectedTickets.containsKey(ticketId);
  bool isTicketUnlocked(String ticketId) => _unlockedTickets.contains(ticketId);

  void selectTicket(String ticketId) {
    final ticket =
        _tickets.firstWhere((t) => t['index'].toString() == ticketId);
    final requiresPassword = ticket['password_required'] ?? false;

    // Only allow selection if ticket doesn't require password OR is already unlocked
    if (!requiresPassword || isTicketUnlocked(ticketId)) {
      _selectedTickets[ticketId] = 1;
      logger.d('Selected ticket: $ticketId');
      notifyListeners();
    }
  }

  Future<void> requestPasswordForTicket(String ticketId) async {
    final ticket =
        _tickets.firstWhere((t) => t['index'].toString() == ticketId);

    final response = await _dialogService.showCustomDialog(
        variant: DialogType.passwordProtected,
        title: 'Password for ${ticket['name'] ?? 'Ticket'}',
        description: 'Enter the password for this specific ticket.',
        barrierDismissible: true,
        data: {
          'ticket_id': ticket['id'],
          'ticket_index': ticketId,
        });

    if (response?.confirmed == true) {
      final enteredPassword = response!.data['password'];

      // Simulate password validation (replace with your actual validation)
      final isValid = await validateTicketPassword(
          enteredPassword,
          ticket['event_id'] ?? 0, // You'll need event_id in ticket data
          ticket['id']);

      if (isValid) {
        // Unlock the ticket
        _unlockedTickets.add(ticketId);

        // Show success message
        locator<SnackbarService>().showSnackbar(
          message: 'Ticket unlocked successfully!',
          duration: const Duration(seconds: 2),
        );

        notifyListeners();
      } else {
        // Show error message
        locator<SnackbarService>().showSnackbar(
          message: 'Incorrect password for this ticket.',
          duration: const Duration(seconds: 3),
        );
      }
    }
  }

  bool isValidating = false;
  Map<int, Map<String, dynamic>> validatedTicketsData =
      {}; // Store validated ticket data

  Future<bool> validateTicketPassword(
      String password, int eventId, int ticketId) async {
    isValidating = true;
    bool isValid = false;
    notifyListeners();
    try {
      final response = await locator<EventService>().validateTicketPassword(
          password: password, eventId: eventId, ticketId: ticketId);
      if (response.statusCode == 200 || response.statusCode == 201) {
        logger.w(response.data['ticket']);
        logger.i('Ticket id-------: ${ticketId}');
        var ticket = response.data['ticket'];

        isValid = true;
        if (isValid) {
          final validatedData = getValidatedTicketData(ticket['id']);
          if (validatedData != null) {
            // Update the ticket in the bottom sheet with real data
            _updateTicketWithValidatedData(
                ticket['index'].toString(), validatedData);
          }
        }
      } else {
        logger.e(response.message);
        locator<SnackbarService>().showSnackbar(
          message: response.message ?? 'Failed to validate ticket password',
          duration: const Duration(seconds: 3),
        );
        isValid = false;
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
    return isValid;
  }

  void _updateTicketWithValidatedData(
      String ticketId, Map<String, dynamic> validatedData) {
    final ticketIndex =
        _tickets.indexWhere((t) => t['index'].toString() == ticketId);
    if (ticketIndex != -1) {
      // Update with real data from API response
      _tickets[ticketIndex] = {
        ..._tickets[ticketIndex],
        'price': validatedData['price'] ?? _tickets[ticketIndex]['price'],
        'name': validatedData['name'] ?? _tickets[ticketIndex]['name'],
        'description': validatedData['description'] ??
            _tickets[ticketIndex]['description'],
        'quantity':
            validatedData['quantity'] ?? _tickets[ticketIndex]['quantity'],
        'available': (validatedData['quantity'] ?? 0) > 0,
        'limit': validatedData['limit'] ?? _tickets[ticketIndex]['limit'],
        'type': validatedData['type'] ?? _tickets[ticketIndex]['type'],
        // Add any other fields that come from the API
      };

      logger.i(
          'Updated ticket $ticketId with validated data: ${_tickets[ticketIndex]}');
    }
  }

  Map<String, dynamic>? getValidatedTicketData(int ticketId) {
    return validatedTicketsData[ticketId];
  }

  void increaseQuantity(String ticketId) {
    final currentQuantity = _selectedTickets[ticketId] ?? 0;
    final ticket =
        _tickets.firstWhere((t) => t['index'].toString() == ticketId);
    final limit = ticket['limit'] ?? 10;

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

  int get totalQuantity {
    return _selectedTickets.values.fold(0, (sum, quantity) => sum + quantity);
  }

  bool ticketRequiresPassword(String ticketId) {
    final ticket = _tickets.firstWhere(
      (t) => t['index'].toString() == ticketId,
      orElse: () => {},
    );
    return ticket['password_required'] ?? false;
  }

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
          'is_unlocked': isTicketUnlocked(entry.key),
        });
      }
    }

    return selectedDetails;
  }

  void checkout() {
    if (!hasSelectedTickets) return;

    final selectedDetails = getSelectedTicketsDetails();
    final requiresPassword =
        selectedDetails.any((ticket) => ticket['password_required'] == true);

    final checkoutData = {
      'tickets': selectedDetails,
      'total_price': totalPrice,
      'total_quantity': totalQuantity,
      'requires_password': requiresPassword,
      'is_mixed_protection': !_isPasswordProtected && requiresPassword,
      'unlocked_tickets': _unlockedTickets.toList(),
    };

    logger.i('Checkout data: $checkoutData');

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
    _unlockedTickets.clear();
    notifyListeners();
  }
}
