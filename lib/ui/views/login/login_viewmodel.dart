import 'package:logger/logger.dart';
import 'package:nest/app/app.locator.dart';
import 'package:nest/app/app.router.dart';
import 'package:nest/models/api_response.dart';
import 'package:nest/models/login_model.dart';
import 'package:nest/services/auth_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../services/shared_preferences_service.dart';
import '../navigation/navigation_view.dart';
import 'login_view.form.dart';

class LoginViewModel extends FormViewModel with $LoginView {
  final authService = locator<AuthService>();
  bool isGoogleSignIn = false;
  bool isAppleSignIn = false;
  bool isPasswordVisible = false;
  togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    rebuildUi();
  }

  login() async {
    LoginModel loginModel = LoginModel(
      email: emailController.text,
      password: passwordController.text,
    );
    setBusy(true);
    try {
      final response = await authService.sign(loginModel);
      Logger().i('Login successful: ${response.data}');

      if (response.statusCode == 200) {
        Logger().i('Login successful: ${response.data}');
        setBusy(false);
        locator<SharedPreferencesService>().setIsLoggedIn(true);
        locator<SharedPreferencesService>().setAuthToken(
          response.data['token'],
        );
        locator<SharedPreferencesService>().setUserInfo(
          response.data['user'],
        );

        locator<NavigationService>().navigateToNavigationView();
      } else {
        setBusy(false);
        await locator<DialogService>().showDialog(
          title: 'Login Failed',
          description:
              response.message ?? 'An error occurred while logging in.',
        );
      }
    } catch (e) {
      setBusy(false);
      Logger().e('Login failed: $e');
      locator<SnackbarService>().showSnackbar(
        message: e.toString(),
        duration: const Duration(seconds: 3),
      );
    }
  }

  Future sendAuthAppleParams(Map<String, dynamic> params) async {
    isAppleSignIn = (true);
    rebuildUi();
    ApiResponse response =
        await locator<AuthService>().oAuthApple(queryParams: params);
    switch (response.statusCode) {
      case 200:
        isAppleSignIn = (false);
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
        isAppleSignIn = (false);
        rebuildUi();
        locator<SnackbarService>().showSnackbar(
          message: response.data['error'],
          duration: const Duration(
            seconds: 4,
          ),
        );
    }
  }

  Future sendAuthGoogleParams(Map<String, dynamic> params) async {
    isGoogleSignIn = (true);
    ApiResponse response =
        await locator<AuthService>().oAuthGoogle(queryParams: params);
    switch (response.statusCode) {
      case 200:
        isGoogleSignIn = (false);
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
        isGoogleSignIn = (false);
        locator<SnackbarService>().showSnackbar(
          message: response.data['error'],
          duration: const Duration(
            seconds: 4,
          ),
        );
    }
  }

  void signup() {
    locator<NavigationService>().navigateToInterestSelectionView();
  }
}
