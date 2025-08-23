import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:nest/utils/stripe_configs.dart';

import '../abstractClasses/abstract_class.dart';
import '../app/app.locator.dart';
import '../models/payments.dart';

class StripeService {
  final apiService = locator<IApiService>();
  Future<PaymentIntent?> createPaymentIntent({
    required int amount,
    required String currency,
    required String provider,
    required int bookingId,
    Map<String, dynamic>? metadata,
  }) async {
    try {
      final response = await apiService.post(
        '${StripeConfig.baseUrl}/payments/create-payment-intent',
        data: json.encode({
          'amount': amount,
          'currency': currency,
          'provider': provider,
          'booking_id': bookingId,
          'metadata': metadata,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data;
        return PaymentIntent.fromJson(data);
      } else {
        throw Exception('Failed to create payment intent: ${response.data}');
      }
    } catch (error) {
      throw Exception('Error creating payment intent: $error');
    }
  }

  Future<bool> confirmPayment(String paymentIntentId) async {
    try {
      final response = await apiService.post(
        '${StripeConfig.baseUrl}/confirm-payment',
        data: json.encode({
          'payment_intent_id': paymentIntentId,
        }),
      );

      return response.statusCode == 200 || response.statusCode == 201;
    } catch (error) {
      return false;
    }
  }
}
