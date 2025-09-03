import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:nest/app/app.bottomsheets.dart';
import 'package:nest/app/app.dialogs.dart';
import 'package:nest/app/app.locator.dart';
import 'package:nest/app/app.router.dart';
import 'package:nest/services/api_service.dart';
import 'package:nest/services/deep_link_service.dart';
import 'package:nest/utils/env_config.dart';
import 'package:nest/utils/stripe_configs.dart';
import 'package:stacked_services/stacked_services.dart';

import 'abstractClasses/abstract_class.dart';
import 'handlers/post_deeplink_handler.dart';
import 'handlers/verification_handler.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  ApiConfig.setPhysicalDevice(true);
  await setupLocator();
  setupDialogUi();
  setupBottomSheetUi();
  setupServiceLocator();
  await dotenv.load(fileName: '.env');
  Stripe.publishableKey = StripeConfig.publishableKey;
  await Stripe.instance.applySettings();
  runApp(const MainApp());
}

void setupServiceLocator() {
  locator.registerLazySingleton<IApiService>(
    () => ApiService(
      connectTimeout: 30000,
      receiveTimeout: 30000,
    ),
  );
  locator.registerLazySingleton<SnackbarService>(() => SnackbarService());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  @override
  void initState() {
    super.initState();
    _initializeDeepLinks();
  }

  void _initializeDeepLinks() async {
    final DeepLinkService deepLinkService = locator<DeepLinkService>();
    await deepLinkService.initialize();

    // Register handlers
    deepLinkService.registerHandler(
      PostDeepLinkHandler(
        onPostRequested: (postId) {},
      ),
    );

    deepLinkService.registerHandler(
      VerificationDeepLinkHandler(
        onVerificationRequested: (token, email) {},
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: Routes.startupView,
      onGenerateRoute: StackedRouter().onGenerateRoute,
      navigatorKey: StackedService.navigatorKey,
      navigatorObservers: [StackedService.routeObserver],
    );
  }
}
