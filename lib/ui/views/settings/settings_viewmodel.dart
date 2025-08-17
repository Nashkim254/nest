import 'package:nest/app/app.router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.dialogs.dart';
import '../../../app/app.locator.dart';

class SettingsViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final DialogService _dialogService = locator<DialogService>();
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
}
