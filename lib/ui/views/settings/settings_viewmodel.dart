import 'package:nest/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.dialogs.dart';
import '../../../app/app.locator.dart';
import '../../../services/shared_preferences_service.dart';
import '../../../services/user_service.dart';

class SettingsViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final DialogService _dialogService = locator<DialogService>();
  final UserService _userService = locator<UserService>();
  final SharedPreferencesService _sharedPreferencesService = locator<SharedPreferencesService>();
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
