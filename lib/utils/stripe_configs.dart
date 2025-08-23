import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:nest/ui/common/app_urls.dart';

class StripeConfig {
  static final String publishableKey = dotenv.env['STRIPE_PUBLISHABLE_KEY']!;
  static String secretKey = dotenv.env['STRIPE_SECRET_KEY']!;
  static final String baseUrl = AppUrls.baseUrl;
}
