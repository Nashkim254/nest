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
  TicketItem? _ticket;
  init(Map<dynamic, dynamic> ticketInfo) {
    _ticket = TicketItem(
      name: ticketInfo['name'],
      price: double.parse(ticketInfo['price'].toString()),
      quantity: int.parse(ticketInfo['quantity'].toString()),
    );
    notifyListeners();
  }

  TicketItem get ticket => _ticket!;

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

  // Order calculations
  double get subtotal => _ticket!.totalPrice;
  double get serviceFee => 0.0;
  double get total => subtotal + serviceFee;

  // Actions
  void incrementQuantity() {
    _ticket!.quantity++;
    notifyListeners();
  }

  void decrementQuantity() {
    if (_ticket!.quantity > 1) {
      _ticket!.quantity--;
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
        _selectedConfirmationMethod != null;
  }

  void confirmAndGetTicket() async {
    if (canProceedToPayment) {
      createBooking().then((val) async {
        await processPayment(val!);
      });
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

  // Getters
  String get selectedCurrency => _selectedCurrency;
  PaymentResult? get lastPaymentResult => _lastPaymentResult;
  bool get canProcessPayment => ticket.price >= 0.5 && !isBusy;

  // Currency options
  final List<String> currencies = ['usd', 'eur', 'gbp'];

  void updateCurrency(String currency) {
    _selectedCurrency = currency;
    notifyListeners();
  }

  Future<void> processPayment(int bookingId) async {
    if (ticket.price <= 0) {
      _showError('Please enter an amount');
      return;
    }

    final amount = ticket.price;
    if (amount <= 0) {
      _showError('Please enter a valid amount');
      return;
    }

    setBusy(true);

    try {
      final result = await _paymentService.processPayment(
        amount: amount,
        currency: _selectedCurrency,
        bookingId: bookingId,
        provider: 'stripe',
        metadata: {
          'source': 'mobile_app',
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

  void _showSuccessDialog() async{
   final response = await dialogService.showCustomDialog(
      variant: DialogType.paymentSuccessful,
      title: 'Payment Successful',
      description: 'Your payment has been processed successfully!',
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
      barrierDismissible: false,
    );
  }

  Logger logger = Logger();
  Future<int?> createBooking() async {
    int? bookingId;
    try {
      setBusy(true);
      int? eventId = locator<SharedPreferencesService>().getInt('eventId');
      Map<String, dynamic> body = {
        'ticket_id': locator<SharedPreferencesService>().getInt('ticketId'),
        'quantity': ticket.quantity,
        'description': 'Booking for ${ticket.name}',
      };
      logger.i('Booking: $body');
      final response = await eventService.createBooking(
          eventId: eventId!, requestBody: body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        logger.i('Booking: ${response.data}');
        bookingId = response.data['id'];
        return bookingId;
      } else {
        throw ApiException(response.message ?? 'Failed to create user');
      }
    } catch (e, s) {
      logger.e(s);
    } finally {
      setBusy(false);
    }
    return bookingId!;
  }

  @override
  void dispose() {
    super.dispose();
  }
}
