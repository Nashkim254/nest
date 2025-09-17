import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.dialogs.dart';
import '../../../app/app.locator.dart';
import '../../../models/api_exceptions.dart';
import '../../../models/confirmation_method.dart';
import '../../../models/payment_method.dart';
import '../../../models/payments.dart';
import '../../../models/ticket_item.dart';
import '../../../services/event_service.dart';
import '../../../services/payment_service.dart';
import '../../../services/shared_preferences_service.dart';
import '../../common/app_enums.dart';

class CheckoutViewModel extends BaseViewModel {
  final eventService = locator<EventService>();
  final Logger logger = Logger();

  // Support both single and multiple tickets
  List<TicketItem> _tickets = [];
  bool _isMultipleTickets = false;
  bool _requiresPassword = false;
  bool _isMixedProtection = false;

  List<TicketItem> get tickets => _tickets;
  bool get isMultipleTickets => _isMultipleTickets;
  bool get requiresPassword => _requiresPassword;
  bool get isMixedProtection => _isMixedProtection;

  // Legacy support - get first ticket for single ticket scenarios
  TicketItem get ticket => _tickets.isNotEmpty
      ? _tickets.first
      : TicketItem(name: '', price: 0, quantity: 0);

  void init(Map<dynamic, dynamic> ticketInfo) {
    try {
      if (ticketInfo.containsKey('tickets') && ticketInfo['tickets'] != null) {
        // New multi-ticket format
        _isMultipleTickets = true;
        _requiresPassword = ticketInfo['requires_password'] ?? false;
        _isMixedProtection = ticketInfo['is_mixed_protection'] ?? false;

        final ticketsData = ticketInfo['tickets'] as List;
        _tickets = ticketsData.map((ticketData) {
          final data = ticketData as Map<String, dynamic>;
          // Get ticket ID from data or SharedPreferences as fallback
          String? ticketId =
              data['ticket_id']?.toString() ?? data['id']?.toString();
          if (ticketId == null || ticketId.isEmpty) {
            final storedTicketId =
                locator<SharedPreferencesService>().getInt('ticketId');
            if (storedTicketId != null) {
              ticketId = storedTicketId.toString();
            }
          }

          return TicketItem(
            name: data['name']?.toString() ?? 'Ticket',
            price: _parseDouble(data['price']) ?? 0.0,
            quantity:
                _parseInt(data['selected_quantity'] ?? data['quantity']) ?? 1,
            passwordRequired: data['password_required'] ?? false,
            ticketId: ticketId ?? '',
            index: _parseInt(data['index']),
            type: data['type']?.toString() ?? 'paid',
          );
        }).toList();

        logger.i('Initialized with ${_tickets.length} tickets');
        logger.i('Requires password: $_requiresPassword');
        logger.i('Mixed protection: $_isMixedProtection');
      } else {
        // Legacy single ticket format
        _isMultipleTickets = false;

        // Get ticket ID from data or SharedPreferences as fallback
        String? ticketId =
            ticketInfo['ticket_id']?.toString() ?? ticketInfo['id']?.toString();
        if (ticketId == null || ticketId.isEmpty) {
          final storedTicketId =
              locator<SharedPreferencesService>().getInt('ticketId');
          if (storedTicketId != null) {
            ticketId = storedTicketId.toString();
          }
        }

        _tickets = [
          TicketItem(
            name: ticketInfo['name']?.toString() ?? 'Ticket',
            price: _parseDouble(ticketInfo['price']) ?? 0.0,
            quantity: _parseInt(ticketInfo['quantity']) ?? 1,
            passwordRequired: ticketInfo['password_required'] ?? false,
            ticketId: ticketId ?? '',
            type: ticketInfo['type']?.toString() ?? 'paid',
          )
        ];
      }

      // Validate that we have valid tickets
      if (_tickets.isEmpty) {
        throw Exception('No valid tickets found in ticket info');
      }

      // Remove any tickets with invalid data
      _tickets.removeWhere((ticket) =>
          ticket.name.isEmpty || ticket.price < 0 || ticket.quantity <= 0);

      if (_tickets.isEmpty) {
        throw Exception('All tickets have invalid data');
      }
    } catch (e, s) {
      logger.e('Error initializing checkout: $e');
      logger.e('Stack trace: $s');
      logger.e('Ticket info received: $ticketInfo');

      // Create a fallback ticket to prevent complete failure
      _tickets = [
        TicketItem(
          name: 'Error Ticket',
          price: 0.0,
          quantity: 1,
          passwordRequired: false,
          ticketId: '0',
          type: 'paid',
        )
      ];
      _isMultipleTickets = false;
    }

    notifyListeners();
  }

  // Helper methods for safe type conversion
  double? _parseDouble(dynamic value) {
    if (value == null) return null;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value);
    return null;
  }

  int? _parseInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is double) return value.toInt();
    if (value is String) return int.tryParse(value);
    return null;
  }

  // Agreement states
  bool _agreeWithNestTOS = false;
  bool _agreeWithOrgTOS = false;

  bool get agreeWithNestTOS => _agreeWithNestTOS;
  bool get agreeWithOrgTOS => _agreeWithOrgTOS;

  // Payment methods
  final List<PaymentMethod> _paymentMethods = [
    PaymentMethod(
      type: PaymentMethodType.applePay,
      displayName: 'Apple Pay',
      iconPath: 'assets/icons/apple_pay.png',
    ),
    PaymentMethod(
      type: PaymentMethodType.googlePay,
      displayName: 'Google Pay',
      iconPath: 'assets/icons/google_pay.png',
    ),
    PaymentMethod(
      type: PaymentMethodType.card,
      displayName: 'Card',
      iconPath: 'assets/icons/card.png',
    ),
  ];

  List<PaymentMethod> get paymentMethods =>
      _paymentMethods.where((p) => p.type.isEnabled).toList();

  PaymentMethod? _selectedPaymentMethod;
  PaymentMethod? get selectedPaymentMethod => _selectedPaymentMethod;

  // Confirmation methods
  final List<ConfirmationMethod> _confirmationMethods = [
    ConfirmationMethod(
      type: ConfirmationMethodType.sms,
      displayName: 'SMS',
      iconPath: 'assets/icons/sms.png',
    ),
    ConfirmationMethod(
      type: ConfirmationMethodType.email,
      displayName: 'Email',
      iconPath: 'assets/icons/email.png',
    ),
  ];

  List<ConfirmationMethod> get confirmationMethods => _confirmationMethods;

  ConfirmationMethod? _selectedConfirmationMethod;
  ConfirmationMethod? get selectedConfirmationMethod =>
      _selectedConfirmationMethod;

  // Order calculations - now supports multiple tickets
  double get subtotal =>
      _tickets.fold(0.0, (sum, ticket) => sum + ticket.totalPrice);
  double get serviceFee {
    // Get organization service fee from SharedPreferences
    final orgServiceFee = locator<SharedPreferencesService>().getDouble('service_fee');
    return orgServiceFee ?? 0.0; // Use organization's flat service fee or 0 if not set
  }
  double get total => subtotal + serviceFee;

  int get totalQuantity =>
      _tickets.fold(0, (sum, ticket) => sum + ticket.quantity);

  // Actions for single ticket (legacy support)
  void incrementQuantity() {
    if (_tickets.isNotEmpty) {
      _tickets.first.quantity++;
      notifyListeners();
    }
  }

  void decrementQuantity() {
    if (_tickets.isNotEmpty && _tickets.first.quantity > 1) {
      _tickets.first.quantity--;
      notifyListeners();
    }
  }

  // Actions for multiple tickets
  void incrementTicketQuantity(int ticketIndex) {
    if (ticketIndex < _tickets.length) {
      _tickets[ticketIndex].quantity++;
      notifyListeners();
    }
  }

  void decrementTicketQuantity(int ticketIndex) {
    if (ticketIndex < _tickets.length && _tickets[ticketIndex].quantity > 1) {
      _tickets[ticketIndex].quantity--;
      notifyListeners();
    }
  }

  void removeTicket(int ticketIndex) {
    if (ticketIndex < _tickets.length && _tickets.length > 1) {
      _tickets.removeAt(ticketIndex);
      notifyListeners();
    }
  }

  void toggleNestTOS(bool? value) {
    _agreeWithNestTOS = value ?? false;
    notifyListeners();
  }

  void toggleOrgTOS(bool? value) {
    _agreeWithOrgTOS = value ?? false;
    notifyListeners();
  }

  void selectPaymentMethod(PaymentMethod method) {
    _selectedPaymentMethod = method;
    notifyListeners();
  }

  void selectConfirmationMethod(ConfirmationMethod method) {
    _selectedConfirmationMethod = method;
    notifyListeners();
  }

  bool get canProceedToPayment {
    return _agreeWithNestTOS &&
        _agreeWithOrgTOS &&
        _selectedPaymentMethod != null &&
        _selectedConfirmationMethod != null &&
        _tickets.isNotEmpty;
  }

  void confirmAndGetTicket() async {
    if (canProceedToPayment) {
      // if (_requiresPassword || _isMixedProtection) {
      //   await _handlePasswordVerification();
      // } else {
      await _proceedWithBooking();
      // }
    }
  }

  Future<void> _handlePasswordVerification() async {
    // Check which tickets need password
    final passwordTickets = _tickets.where((t) => t.passwordRequired).toList();
    final openTickets = _tickets.where((t) => !t.passwordRequired).toList();

    if (passwordTickets.isNotEmpty) {
      // Show password verification dialog/screen
      final response = await dialogService.showCustomDialog(
        variant: DialogType.passwordProtected,
        title: 'Password Required',
        description: 'Some tickets require password verification',
        data: {
          'password_tickets': passwordTickets.map((t) => t.toMap()).toList(),
          'open_tickets': openTickets.map((t) => t.toMap()).toList(),
        },
      );

      if (response?.confirmed == true) {
        await _proceedWithBooking();
      }
    } else {
      await _proceedWithBooking();
    }
  }

  Future<void> _proceedWithBooking() async {
    try {
      if (_isMultipleTickets) {
        await _createMultipleBookings();
      } else {
        final bookingId = await createBooking();
        if (bookingId != null) {
          await processPayment(bookingId);
        }
      }
    } catch (e) {
      logger.e('Error in booking process: $e');
      _showErrorDialog('Failed to create booking: $e');
    }
  }

  Future<void> _createMultipleBookings() async {
    setBusy(true);

    try {
      final int? eventId =
          locator<SharedPreferencesService>().getInt('eventId');
      final List<int> bookingIds = [];

      // Validate eventId
      if (eventId == null) {
        throw Exception('Event ID not found. Please try again.');
      }

      // Create booking for each ticket type
      for (final ticket in _tickets) {
        // Validate ticket data
        if (ticket.ticketId == null || ticket.ticketId!.isEmpty) {
          throw Exception('Invalid ticket ID for ${ticket.name}');
        }

        final ticketId = int.tryParse(ticket.ticketId!);
        if (ticketId == null) {
          throw Exception(
              'Invalid ticket ID format for ${ticket.name}: ${ticket.ticketId}');
        }

        final body = {
          'ticket_id': ticketId,
          'quantity': ticket.quantity,
          'description': 'Booking for ${ticket.name}',
          'password_required': ticket.passwordRequired,
        };

        logger.i('Creating booking: $body');

        final response = await eventService.createBooking(
          eventId: eventId!,
          requestBody: body,
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          bookingIds.add(response.data['id']);
        } else {
          throw ApiException(response.message ??
              'Failed to create booking for ${ticket.name}');
        }
      }

      // Process payment for all bookings
      if (bookingIds.isNotEmpty) {
        await _processMultiplePayments(bookingIds);
      }
    } catch (e, s) {
      logger.e('Error creating multiple bookings: $e');
      logger.e(s.toString());
      _showErrorDialog('Failed to create bookings: $e');
    } finally {
      setBusy(false);
    }
  }

  Future<void> _processMultiplePayments(List<int> bookingIds) async {
    try {
      // You can either:
      // 1. Process as one combined payment
      final combinedResult = await _paymentService.processPayment(
        amount: total,
        currency: _selectedCurrency,
        bookingId: bookingIds.first, // Use first booking ID as reference
        provider: 'stripe',
        metadata: {
          'source': 'mobile_app',
          'booking_ids': bookingIds,
          'ticket_count': _tickets.length,
          'total_quantity': totalQuantity,
          'timestamp': DateTime.now().toIso8601String(),
        },
      );

      _lastPaymentResult = combinedResult;

      if (combinedResult.success) {
        _showSuccessDialog();
      } else {
        _showErrorDialog(combinedResult.message ?? 'Payment failed');
      }

      // 2. Or process separate payments for each booking
      // for (final bookingId in bookingIds) {
      //   final ticketForBooking = _tickets[bookingIds.indexOf(bookingId)];
      //   await processPayment(bookingId, ticketForBooking.totalPrice);
      // }
    } catch (e) {
      logger.e('Error processing payments: $e');
      _showErrorDialog('Payment processing failed: $e');
    }
  }

  void goBack() {
    locator<NavigationService>().back();
  }

  final PaymentService _paymentService = locator<PaymentService>();
  final SnackbarService _snackbarService = locator<SnackbarService>();
  final NavigationService _navigationService = locator<NavigationService>();
  final dialogService = locator<DialogService>();

  String _selectedCurrency = 'usd';
  PaymentResult? _lastPaymentResult;

  String get selectedCurrency => _selectedCurrency;
  PaymentResult? get lastPaymentResult => _lastPaymentResult;
  bool get canProcessPayment => total >= 0.5 && !isBusy;

  final List<String> currencies = ['usd', 'eur', 'gbp'];

  void updateCurrency(String currency) {
    _selectedCurrency = currency;
    notifyListeners();
  }

  Future<void> processPayment(int bookingId) async {
    if (total <= 0) {
      _showError('Invalid amount');
      return;
    }

    setBusy(true);

    try {
      final result = await _paymentService.processPayment(
        amount: total,
        currency: _selectedCurrency,
        bookingId: bookingId,
        provider: 'stripe',
        metadata: {
          'source': 'mobile_app',
          'ticket_count': _tickets.length,
          'total_quantity': totalQuantity,
          'timestamp': DateTime.now().toIso8601String(),
        },
      );

      _lastPaymentResult = result;

      if (result.success) {
        _showSuccessDialog();
      } else {
        _showErrorDialog(result.message ?? 'Payment failed');
      }
    } catch (e, s) {
      logger.e(e.toString());
      logger.e(s.toString());
      _showErrorDialog('An error occurred: ${e.toString()}');
    } finally {
      setBusy(false);
    }
  }

  void _showSuccess(String message) {
    _snackbarService.showSnackbar(
      message: message,
      duration: const Duration(seconds: 3),
    );
  }

  void _showError(String message) {
    _snackbarService.showSnackbar(
      message: message,
      duration: const Duration(seconds: 4),
    );
  }

  void _showSuccessDialog() async {
    final response = await dialogService.showCustomDialog(
      variant: DialogType.paymentSuccessful,
      title: 'Payment Successful',
      description: _isMultipleTickets
          ? 'Your payment for ${_tickets.length} ticket types has been processed successfully!'
          : 'Your payment has been processed successfully!',
      barrierDismissible: false,
    );
    if (response!.confirmed) {
      locator<NavigationService>().back();
    }
  }

  void _showErrorDialog(String message) {
    dialogService.showCustomDialog(
      variant: DialogType.paymentSuccessful,
      title: 'Payment Failed',
      description: message,
      barrierDismissible: true,
    );
  }

  // Legacy single booking method
  Future<int?> createBooking() async {
    if (_tickets.isEmpty) return null;

    int? bookingId;
    try {
      setBusy(true);

      final int? eventId =
          locator<SharedPreferencesService>().getInt('eventId');
      if (eventId == null) {
        throw Exception('Event ID not found. Please try again.');
      }

      final firstTicket = _tickets.first;

      // Try to get ticket ID from SharedPreferences first, then from ticket data
      int? ticketId = locator<SharedPreferencesService>().getInt('ticketId');
      if (ticketId == null) {
        if (firstTicket.ticketId != null && firstTicket.ticketId!.isNotEmpty) {
          ticketId = int.tryParse(firstTicket.ticketId!);
        }
      }

      if (ticketId == null) {
        throw Exception('Ticket ID not found for ${firstTicket.name}');
      }

      Map<String, dynamic> body = {
        'ticket_id': ticketId,
        'quantity': firstTicket.quantity,
        'description': 'Booking for ${firstTicket.name}',
      };

      logger.i('Booking: $body');
      final response =
          await eventService.createBooking(eventId: eventId, requestBody: body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        logger.i('Booking: ${response.data}');
        bookingId = response.data['id'];
        return bookingId;
      } else {
        throw ApiException(response.message ?? 'Failed to create booking');
      }
    } catch (e, s) {
      logger.e(s);
      _showErrorDialog('Failed to create booking: $e');
    } finally {
      setBusy(false);
    }
    return bookingId;
  }

  @override
  void dispose() {
    super.dispose();
  }
}
