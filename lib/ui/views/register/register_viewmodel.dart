import 'package:logger/logger.dart';
import 'package:nest/app/app.router.dart';
import 'package:nest/models/registration_model.dart';
import 'package:nest/services/auth_service.dart';
import 'package:nest/ui/views/login/login_view.dart';
import 'package:nest/ui/views/register/register_view.form.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../models/api_response.dart';
import '../../../services/shared_preferences_service.dart';
import '../navigation/navigation_view.dart';

class RegisterViewModel extends BaseViewModel with $RegisterView {
  final navigationService = locator<NavigationService>();
  final authService = locator<AuthService>();
  signin() {
    navigationService.replaceWithLoginView();
  }

  register(RegistrationModel registrationModel) async {
    registrationModel = registrationModel.copyWith(
      email: emailController.text,
      password: passwordController.text,
      phoneNumber: phoneController.text,
      firstName: nameController.text.split(' ').first,
      lastName: nameController.text.split(' ').length > 1
          ? nameController.text.split(' ').sublist(1).join(' ')
          : '',
    );
    setBusy(true);
    Logger().i(registrationModel.toJson());
    try {
      final response = await authService.register(registrationModel);

      Logger().i(response);
      if (response.statusCode == 200) {
        Logger().i('Registration successful: ${response.data}');
        setBusy(false);

        navigationService.clearStackAndShowView(const LoginView());
      } else {
        setBusy(false);
        locator<SnackbarService>().showSnackbar(
          message: response.data['error'] ?? 'Registration failed',
          duration: const Duration(seconds: 3),
        );
      }
    } catch (e) {
      setBusy(false);
      Logger().e('Registration failed: $e');
      locator<SnackbarService>().showSnackbar(
        message: e.toString(),
        duration: const Duration(seconds: 3),
      );
      return;
    }

    setBusy(false);
  }

  Future sendAuthGoogleParams(Map<String, dynamic> params) async {
    setBusy(true);
    ApiResponse response =
        await locator<AuthService>().oAuthGoogle(queryParams: params);
    switch (response.statusCode) {
      case 200:
        setBusy(false);
        rebuildUi();
        DateTime tokenExpirationTime = DateTime.parse(response.data['expires']);
        locator<SharedPreferencesService>()
            .setExpiry(tokenExpirationTime.toString());
        locator<SharedPreferencesService>().setIsLoggedIn(true);
        locator<SharedPreferencesService>().setAuthToken(
          response.data['token'],
        );
        locator<SharedPreferencesService>().setUserInfo(
          response.data['user'],
        );
        locator<NavigationService>()
            .clearStackAndShowView(const NavigationView());
      default:
        setBusy(false);
        locator<SnackbarService>().showSnackbar(
          message: response.data['error'],
          duration: const Duration(
            seconds: 4,
          ),
        );
    }
  }
}
