import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:nest/app/app.locator.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:nest/services/global_service.dart';
import 'package:nest/services/image_service.dart';
import 'package:nest/services/websocket_service.dart';
import 'package:nest/services/message_service.dart';
import 'package:nest/services/api_service.dart';
import 'package:nest/services/auth_service.dart';
import 'package:nest/services/location_service.dart';
import 'package:nest/services/shared_preferences_service.dart';
// @stacked-import

import 'test_helpers.mocks.dart';

@GenerateMocks(
  [],
  customMocks: [
    MockSpec<NavigationService>(onMissingStub: OnMissingStub.returnDefault),
    MockSpec<BottomSheetService>(onMissingStub: OnMissingStub.returnDefault),
    MockSpec<DialogService>(onMissingStub: OnMissingStub.returnDefault),
    MockSpec<GlobalService>(onMissingStub: OnMissingStub.returnDefault),
    MockSpec<ImageService>(onMissingStub: OnMissingStub.returnDefault),
    MockSpec<WebsocketService>(onMissingStub: OnMissingStub.returnDefault),
    MockSpec<MessageService>(onMissingStub: OnMissingStub.returnDefault),
    MockSpec<ApiService>(onMissingStub: OnMissingStub.returnDefault),
    MockSpec<AuthService>(onMissingStub: OnMissingStub.returnDefault),
    MockSpec<LocationService>(onMissingStub: OnMissingStub.returnDefault),
    MockSpec<SharedPreferencesService>(
        onMissingStub: OnMissingStub.returnDefault),
// @stacked-mock-spec
  ],
)
void registerServices() {
  getAndRegisterNavigationService();
  getAndRegisterBottomSheetService();
  getAndRegisterDialogService();
  getAndRegisterGlobalService();
  getAndRegisterImageService();
  getAndRegisterWebsocketService();
  getAndRegisterMessageService();
  getAndRegisterApiService();
  getAndRegisterAuthService();
  getAndRegisterLocationService();
  getAndRegisterSharedPreferencesService();
// @stacked-mock-register
}

MockNavigationService getAndRegisterNavigationService() {
  _removeRegistrationIfExists<NavigationService>();
  final service = MockNavigationService();
  locator.registerSingleton<NavigationService>(service);
  return service;
}

MockBottomSheetService getAndRegisterBottomSheetService<T>({
  SheetResponse<T>? showCustomSheetResponse,
}) {
  _removeRegistrationIfExists<BottomSheetService>();
  final service = MockBottomSheetService();

  when(
    service.showCustomSheet<T, T>(
      enableDrag: anyNamed('enableDrag'),
      enterBottomSheetDuration: anyNamed('enterBottomSheetDuration'),
      exitBottomSheetDuration: anyNamed('exitBottomSheetDuration'),
      ignoreSafeArea: anyNamed('ignoreSafeArea'),
      isScrollControlled: anyNamed('isScrollControlled'),
      barrierDismissible: anyNamed('barrierDismissible'),
      additionalButtonTitle: anyNamed('additionalButtonTitle'),
      variant: anyNamed('variant'),
      title: anyNamed('title'),
      hasImage: anyNamed('hasImage'),
      imageUrl: anyNamed('imageUrl'),
      showIconInMainButton: anyNamed('showIconInMainButton'),
      mainButtonTitle: anyNamed('mainButtonTitle'),
      showIconInSecondaryButton: anyNamed('showIconInSecondaryButton'),
      secondaryButtonTitle: anyNamed('secondaryButtonTitle'),
      showIconInAdditionalButton: anyNamed('showIconInAdditionalButton'),
      takesInput: anyNamed('takesInput'),
      barrierColor: anyNamed('barrierColor'),
      barrierLabel: anyNamed('barrierLabel'),
      customData: anyNamed('customData'),
      data: anyNamed('data'),
      description: anyNamed('description'),
    ),
  ).thenAnswer(
    (realInvocation) =>
        Future.value(showCustomSheetResponse ?? SheetResponse<T>()),
  );

  locator.registerSingleton<BottomSheetService>(service);
  return service;
}

MockDialogService getAndRegisterDialogService() {
  _removeRegistrationIfExists<DialogService>();
  final service = MockDialogService();
  locator.registerSingleton<DialogService>(service);
  return service;
}

MockGlobalService getAndRegisterGlobalService() {
  _removeRegistrationIfExists<GlobalService>();
  final service = MockGlobalService();
  locator.registerSingleton<GlobalService>(service);
  return service;
}

MockImageService getAndRegisterImageService() {
  _removeRegistrationIfExists<ImageService>();
  final service = MockImageService();
  locator.registerSingleton<ImageService>(service);
  return service;
}

MockWebsocketService getAndRegisterWebsocketService() {
  _removeRegistrationIfExists<WebsocketService>();
  final service = MockWebsocketService();
  locator.registerSingleton<WebsocketService>(service);
  return service;
}

MockMessageService getAndRegisterMessageService() {
  _removeRegistrationIfExists<MessageService>();
  final service = MockMessageService();
  locator.registerSingleton<MessageService>(service);
  return service;
}

MockApiService getAndRegisterApiService() {
  _removeRegistrationIfExists<ApiService>();
  final service = MockApiService();
  locator.registerSingleton<ApiService>(service);
  return service;
}

MockAuthService getAndRegisterAuthService() {
  _removeRegistrationIfExists<AuthService>();
  final service = MockAuthService();
  locator.registerSingleton<AuthService>(service);
  return service;
}

MockLocationService getAndRegisterLocationService() {
  _removeRegistrationIfExists<LocationService>();
  final service = MockLocationService();
  locator.registerSingleton<LocationService>(service);
  return service;
}

MockSharedPreferencesService getAndRegisterSharedPreferencesService() {
  _removeRegistrationIfExists<SharedPreferencesService>();
  final service = MockSharedPreferencesService();
  locator.registerSingleton<SharedPreferencesService>(service);
  return service;
}
// @stacked-mock-create

void _removeRegistrationIfExists<T extends Object>() {
  if (locator.isRegistered<T>()) {
    locator.unregister<T>();
  }
}
