import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:nest/app/app.bottomsheets.dart';
import 'package:nest/app/app.dialogs.dart';
import 'package:nest/app/app.locator.dart';
import 'package:nest/app/app.router.dart';
import 'package:nest/services/api_service.dart';
import 'package:stacked_services/stacked_services.dart';

import 'abstractClasses/abstract_class.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  setupDialogUi();
  setupBottomSheetUi();
  setupServiceLocator();
  await dotenv.load(fileName: '.env');
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

class MainApp extends StatelessWidget {
  const MainApp({super.key});

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
