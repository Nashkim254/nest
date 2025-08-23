class PaymentIntent {
  final String clientSecret;
  final String checkoutURl;
  final String id;
  final int amount;
  final String currency;
  final String status;

  PaymentIntent({
    required this.clientSecret,
    required this.checkoutURl,
    required this.id,
    required this.amount,
    required this.currency,
    required this.status,
  });

  factory PaymentIntent.fromJson(Map<String, dynamic> json) {
    return PaymentIntent(
      clientSecret: json['client_secret'] ?? '',
      checkoutURl: json['checkout_url'] ?? '',
      id: json['id'] ?? '',
      amount: json['amount'] ?? 0,
      currency: json['currency'] ?? 'usd',
      status: json['status'] ?? '',
    );
  }
  //to json
  Map<String, dynamic> toJson() {
    return {
      'client_secret': clientSecret,
      'checkout_url': checkoutURl,
      'id': id,
      'amount': amount,
      'currency': currency,
      'status': status,
    };
  }
}

class PaymentResult {
  final bool success;
  final String? message;
  final PaymentIntent? paymentIntent;

  PaymentResult({
    required this.success,
    this.message,
    this.paymentIntent,
  });
}
