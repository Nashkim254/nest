import 'package:nest/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.dialogs.dart';
import '../../../app/app.locator.dart';
import '../../../models/password_reset_model.dart';
import '../../../services/auth_service.dart';
import '../../../services/shared_preferences_service.dart';
import '../../../services/user_service.dart';

class SettingsViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final DialogService _dialogService = locator<DialogService>();
  final UserService _userService = locator<UserService>();
  final SharedPreferencesService _sharedPreferencesService = locator<SharedPreferencesService>();
  final AuthService _authService = locator<AuthService>();
  void navigateToEditProfile() {
    _navigationService.navigateToEditProfileView();
  }

  bool isPushNotificationsEnabled = true;
  bool isEmailNotificationsEnabled = true;
  void toggleEmailNotifications(bool value) {
    isEmailNotificationsEnabled = value;
    notifyListeners();
  }

  void togglePushNotifications(bool value) {
    isPushNotificationsEnabled = value;
    notifyListeners();
  }

  void navigateToNotifications() {
    // Navigate to the notifications view
  }
  showChangePasswordDialog() async {
    await _dialogService.showCustomDialog(
      variant: DialogType.changePassword,
      title: 'Change Password',
      description: 'Please enter your new password.',
      barrierDismissible: true,
    );
  }

  void openPrivacyPolicy() {
    _userService.openSocialLink('https://nesthaps.com/privacy');
  }

  void openTermsOfService() {
    _userService.openSocialLink('https://nesthaps.com/terms');
  }

  void sendFeedback() {
    _userService.openSocialLink('mailto:support@nestapp.com?subject=App Feedback');
  }

  Future<void> showPasswordResetDialog() async {
    final result = await _dialogService.showCustomDialog(
      variant: DialogType.changePassword,
      title: 'Reset Password',
      description: 'Enter your new password. We will send you a confirmation email.',
      barrierDismissible: true,
    );

    if (result?.confirmed == true && result?.data != null) {
      final newPassword = result!.data['newPassword'] as String?;
      final confirmPassword = result.data['confirmPassword'] as String?;

      if (newPassword != null && confirmPassword != null) {
        await _requestPasswordResetWithPassword(newPassword, confirmPassword);
      }
    }
  }

  Future<void> _requestPasswordResetWithPassword(String newPassword, String confirmPassword) async {
    setBusy(true);

    try {
      // Get user email from shared preferences
      final userInfo = _sharedPreferencesService.getUserInfo();
      final email = userInfo?['email'] as String?;

      if (email == null || email.isEmpty) {
        locator<SnackbarService>().showSnackbar(
          message: 'User email not found. Please login again.',
          duration: const Duration(seconds: 3),
        );
        return;
      }

      // Save the password temporarily for when we get the token back
      await _sharedPreferencesService.setString('temp_reset_password', newPassword);
      await _sharedPreferencesService.setString('temp_reset_confirm_password', confirmPassword);

      final resetRequestModel = PasswordResetRequestModel(
        email: email,
        appLaunch: 'api.nesthaps.com',
      );

      await _authService.requestChangePassword(resetRequestModel);

      locator<SnackbarService>().showSnackbar(
        message: 'Password reset email sent! Check your email and click the link to confirm.',
        duration: const Duration(seconds: 5),
      );
    } catch (e) {
      // Clear temp passwords on error
      await _sharedPreferencesService.remove('temp_reset_password');
      await _sharedPreferencesService.remove('temp_reset_confirm_password');

      locator<SnackbarService>().showSnackbar(
        message: 'Failed to send password reset email: $e',
        duration: const Duration(seconds: 3),
      );
    } finally {
      setBusy(false);
    }
  }

  Future<void> resetPasswordWithToken(String token, String password) async {
    setBusy(true);

    try {
      final resetModel = PasswordResetModel(
        token: token,
        password: password,
      );

      await _authService.resetPassword(resetModel);

      locator<SnackbarService>().showSnackbar(
        message: 'Password reset successfully! Please login with your new password.',
        duration: const Duration(seconds: 3),
      );

      // Navigate to login after successful reset
      _navigationService.clearStackAndShow('/login-view');
    } catch (e) {
      locator<SnackbarService>().showSnackbar(
        message: 'Failed to reset password: $e',
        duration: const Duration(seconds: 3),
      );
    } finally {
      setBusy(false);
    }
  }

  Future<void> logout() async {
    setBusy(true);

    try {
      // Clear all user-related data from SharedPreferences
      await _sharedPreferencesService.clearAuthToken();
      await _sharedPreferencesService.setIsLoggedIn(false);

      // Clear user info and other stored data
      await _sharedPreferencesService.remove('userInfo');
      await _sharedPreferencesService.remove('service_fee');
      await _sharedPreferencesService.remove('token_expiry');
      await _sharedPreferencesService.remove('eventId');
      await _sharedPreferencesService.remove('ticketId');

      // Navigate back to login screen
      _navigationService.replaceWithLoginView();
    } catch (e) {
      // Show error if logout fails
      locator<SnackbarService>().showSnackbar(
        message: 'Failed to logout: $e',
        duration: const Duration(seconds: 3),
      );
    } finally {
      setBusy(false);
    }
  }
}
