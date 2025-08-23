import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart' hide PaymentIntent;
import 'package:logger/logger.dart';
import 'package:nest/app/app.router.dart';
import 'package:nest/services/shared_preferences_service.dart';
import 'package:nest/services/stripe_service.dart';
import 'package:stacked_services/stacked_services.dart';

import '../abstractClasses/abstract_class.dart';
import '../app/app.locator.dart';
import '../models/payments.dart';

class PaymentService {
  static final apiService = locator<IApiService>();
  final StripeService _stripeApiService = locator<StripeService>();
  final SnackbarService _snackbarService = locator<SnackbarService>();

  Future<PaymentResult> processPayment({
    required double amount,
    required String currency,
    required String provider,
    required int bookingId,
    Map<String, dynamic>? metadata,
  }) async {
    try {
      // Convert amount to cents
      final amountInCents = (amount * 100).toInt();

      // Create payment intent
      PaymentIntent? paymentIntent =
          await _stripeApiService.createPaymentIntent(
        amount: amountInCents,
        currency: currency,
        provider: provider,
        bookingId: bookingId,
        metadata: metadata,
      );

      if (paymentIntent!.checkoutURl == null) {
        return PaymentResult(
          success: false,
          message: 'Failed to create payment intent',
        );
      }
      Logger().i(paymentIntent.clientSecret);
      final paymentResult = await locator<NavigationService>()
          .navigateToPaymentwebView(checkoutURL: paymentIntent.checkoutURl);
      if (paymentResult == null) {
        return PaymentResult(
          success: false,
          message: 'Payment failed',
        );
      }

// String? email =locator<SharedPreferencesService>()
//     .getUserInfo()!['email'] ;
//       Logger().w(email);

      // Initialize payment sheet
      // await Stripe.instance.initPaymentSheet(
      //   paymentSheetParameters: SetupPaymentSheetParameters(
      //     paymentIntentClientSecret: paymentIntent.clientSecret,
      //     merchantDisplayName: 'Nest',
      //     style: ThemeMode.dark,
      //     returnURL: 'com.example.nest://payment-return',
      //     billingDetails: const BillingDetails(
      //       email: '', // You can make this dynamic
      //     ),
      //   ),
      // );

      // Present payment sheet
      // await Stripe.instance.presentPaymentSheet();

      return PaymentResult(
        success: true,
        message: 'Payment successful',
        paymentIntent: paymentIntent,
      );
    } on StripeException catch (e) {
      return PaymentResult(
        success: false,
        message: _handleStripeError(e),
      );
    } catch (e) {
      return PaymentResult(
        success: false,
        message: 'An unexpected error occurred: ${e.toString()}',
      );
    }
  }

  Future<PaymentResult> processCustomPayment({
    required double amount,
    required String currency,
    required String provider,
    required int bookingId,
    required PaymentMethodParams paymentMethodParams,
    Map<String, dynamic>? metadata,
  }) async {
    try {
      final amountInCents = (amount * 100).toInt();

      PaymentIntent? paymentIntent =
          await _stripeApiService.createPaymentIntent(
        amount: amountInCents,
        currency: currency,
        provider: provider,
        bookingId: bookingId,
        metadata: metadata,
      );
      Logger().w(paymentIntent!.toJson());
      if (paymentIntent == null) {
        return PaymentResult(
          success: false,
          message: 'Failed to create payment intent',
        );
      }
      Logger().w(paymentIntent.clientSecret);
      // Confirm payment with custom payment method
      final result = await Stripe.instance.confirmPayment(
        paymentIntentClientSecret: paymentIntent.clientSecret,
        data: paymentMethodParams,
      );

      return PaymentResult(
        success: true,
        message: 'Payment successful',
        paymentIntent: paymentIntent,
      );
    } on StripeException catch (e) {
      return PaymentResult(
        success: false,
        message: _handleStripeError(e),
      );
    } catch (e) {
      return PaymentResult(
        success: false,
        message: 'An unexpected error occurred: ${e.toString()}',
      );
    }
  }

  String _handleStripeError(StripeException error) {
    switch (error.error.code) {
      case FailureCode.Canceled:
        return 'Payment was canceled';
      case FailureCode.Failed:
        return 'Payment failed';
      case FailureCode.Unknown:
        return 'Invalid payment request';
      default:
        return error.error.message ?? 'Payment error occurred';
    }
  }
}
