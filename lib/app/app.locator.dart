// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedLocatorGenerator
// **************************************************************************

// ignore_for_file: public_member_api_docs, implementation_imports, depend_on_referenced_packages

import 'package:stacked_services/src/bottom_sheet/bottom_sheet_service.dart';
import 'package:stacked_services/src/dialog/dialog_service.dart';
import 'package:stacked_services/src/navigation/navigation_service.dart';
import 'package:stacked_shared/stacked_shared.dart';

import '../services/api_service.dart';
import '../services/auth_service.dart';
import '../services/comments_service.dart';
import '../services/deep_link_generator_service.dart';
import '../services/deep_link_service.dart';
import '../services/event_service.dart';
import '../services/file_service.dart';
import '../services/global_service.dart';
import '../services/image_service.dart';
import '../services/location_service.dart';
import '../services/message_service.dart';
import '../services/payment_service.dart';
import '../services/share_service.dart';
import '../services/shared_coordinates_service.dart';
import '../services/shared_preferences_service.dart';
import '../services/social_service.dart';
import '../services/stripe_service.dart';
import '../services/user_service.dart';
import '../services/websocket_service.dart';

final locator = StackedLocator.instance;

Future<void> setupLocator({
  String? environment,
  EnvironmentFilter? environmentFilter,
}) async {
// Register environments
  locator.registerEnvironment(
      environment: environment, environmentFilter: environmentFilter);

// Register dependencies
  locator.registerLazySingleton(() => BottomSheetService());
  locator.registerLazySingleton(() => DialogService());
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => GlobalService());
  locator.registerLazySingleton(() => ImageService());
  locator.registerLazySingleton(() => WebsocketService());
  locator.registerLazySingleton(() => MessageService());
  locator.registerLazySingleton(() => ApiService());
  locator.registerLazySingleton(() => AuthService());
  locator.registerLazySingleton(() => LocationService());
  final sharedPreferencesService = SharedPreferencesService();
  await sharedPreferencesService.init();
  locator.registerSingleton(sharedPreferencesService);

  locator.registerLazySingleton(() => DeepLinkService());
  locator.registerLazySingleton(() => DeepLinkGeneratorService());
  locator.registerLazySingleton(() => ShareService());
  locator.registerLazySingleton(() => UserService());
  locator.registerLazySingleton(() => FileService());
  locator.registerLazySingleton(() => EventService());
  locator.registerLazySingleton(() => PaymentService());
  locator.registerLazySingleton(() => StripeService());
  locator.registerLazySingleton(() => SocialService());
  locator.registerLazySingleton(() => CommentsService());
  locator.registerLazySingleton(() => SharedCoordinatesService());
}
