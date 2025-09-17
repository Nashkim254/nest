import 'package:logger/logger.dart';
import 'package:nest/app/app.locator.dart';
import 'package:nest/app/app.router.dart';
import 'package:nest/models/api_response.dart';
import 'package:nest/models/login_model.dart';
import 'package:nest/services/auth_service.dart';
import 'package:nest/services/user_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../services/shared_preferences_service.dart';
import '../navigation/navigation_view.dart';
import 'login_view.form.dart';

class LoginViewModel extends FormViewModel with $LoginView {
  final authService = locator<AuthService>();
  final userService = locator<UserService>();
  bool isGoogleSignIn = false;
  bool isAppleSignIn = false;
  bool isPasswordVisible = true;
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

        // Save token expiry
        if (response.data['token_expiry'] != null) {
          final expiryTimestamp = response.data['token_expiry'];
          final expiryDateTime =
              DateTime.fromMillisecondsSinceEpoch(expiryTimestamp * 1000);
          locator<SharedPreferencesService>()
              .setExpiry(expiryDateTime.toIso8601String());
        }

        // Fetch organization service fee
        await _fetchAndStoreServiceFee();

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

        // Save token expiry
        if (response.data['token_expiry'] != null) {
          final expiryTimestamp = response.data['token_expiry'];
          final expiryDateTime =
              DateTime.fromMillisecondsSinceEpoch(expiryTimestamp * 1000);
          locator<SharedPreferencesService>()
              .setExpiry(expiryDateTime.toIso8601String());
        }

        // Fetch organization service fee
        await _fetchAndStoreServiceFee();

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

        // Save token expiry
        if (response.data['token_expiry'] != null) {
          final expiryTimestamp = response.data['token_expiry'];
          final expiryDateTime =
              DateTime.fromMillisecondsSinceEpoch(expiryTimestamp * 1000);
          locator<SharedPreferencesService>()
              .setExpiry(expiryDateTime.toIso8601String());
        }

        // Fetch organization service fee
        await _fetchAndStoreServiceFee();

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

  // Fetch organization service fee and store in SharedPreferences
  Future<void> _fetchAndStoreServiceFee() async {
    try {
      final response = await userService.getMyOrganization();
      if (response.statusCode == 200 && response.data != null) {
        final organization = response.data['organization'];
        final serviceFee = organization['service_fee'];

        if (serviceFee != null) {
          // Store service fee in SharedPreferences
          await locator<SharedPreferencesService>()
              .setDouble('service_fee', double.parse(serviceFee.toString()));
          Logger().i('Service fee stored: $serviceFee');
        } else {
          // Default service fee if not provided
          await locator<SharedPreferencesService>()
              .setDouble('service_fee', 5.0);
          Logger().i('Default service fee stored: 5.0');
        }
      } else {
        // Default service fee if organization not found
        await locator<SharedPreferencesService>().setDouble('service_fee', 5.0);
        Logger().i('Organization not found, default service fee stored: 5.0');
      }
    } catch (e) {
      // Default service fee on error
      await locator<SharedPreferencesService>().setDouble('service_fee', 5.0);
      Logger().e('Error fetching organization service fee: $e');
      Logger().i('Default service fee stored: 5.0');
    }
  }
}
