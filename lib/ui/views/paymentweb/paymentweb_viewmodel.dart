import 'package:logger/logger.dart';
import 'package:nest/app/app.locator.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../models/payments.dart';

class PaymentwebViewModel extends BaseViewModel {
  late final WebViewController _controller;
  WebViewController get controller => _controller;

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  void init(String checkoutUrl) async {
    _isLoading = true;
    notifyListeners();
    await _initializeWebView(checkoutUrl).then((_) {
      _isLoading = false;
      notifyListeners();
    });
  }

  Logger logger = Logger();
  _initializeWebView(String checkoutUrl) {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            logger.w('Page started loading: $url');
          },
          onPageFinished: (String url) {
            _isLoading = false;
            notifyListeners();

            logger.i('Page finished loading: $url');
          },
          onNavigationRequest: (NavigationRequest request) {
            logger.wtf('Navigation request: ${request.url}');

            // Check if user is being redirected back to app
            if (request.url.isNotEmpty &&
                request.url.contains('payment/success')) {
              logger.w("Redirecting back to app from webview ${request.url}");
              _handlePaymentReturn(request.url);
              return NavigationDecision.prevent;
            }

            return NavigationDecision.navigate;
          },
          onWebResourceError: (WebResourceError error) {
            logger.e('Web resource error: ${error.description}');
          },
        ),
      )
      ..loadRequest(Uri.parse(checkoutUrl));
  }

  void _handlePaymentReturn(String url) {
    final uri = Uri.parse(url);
    final paymentStatus = uri.queryParameters['payment_intent_status'];

    PaymentResult result;

    if (paymentStatus == 'succeeded') {
      result = PaymentResult(
        success: true,
        message: 'Payment completed successfully',
      );
    } else {
      result = PaymentResult(
        success: false,
        message: 'Payment ${paymentStatus ?? 'failed'}',
      );
    }
    locator<NavigationService>().back(result: result);
  }
}
