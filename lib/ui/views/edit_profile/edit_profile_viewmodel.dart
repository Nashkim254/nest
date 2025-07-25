import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../common/app_enums.dart';

class EditProfileViewModel extends BaseViewModel {
  TextEditingController usernameController =
      TextEditingController(text: '@johndoe');
  TextEditingController igController =
      TextEditingController(text: 'johndoe_official');
  TextEditingController xController = TextEditingController(text: 'johndoe_x');
  TextEditingController linkedInController =
      TextEditingController(text: 'URL (Optional)');
  TextEditingController bioController = TextEditingController(
      text: 'Nightlife enthusiast, music lover, and event explorer! 🎶✨');

  SettingsType settingsType = SettingsType.everyone;
  selectSettingsType(SettingsType type) {
    settingsType = type;
    notifyListeners();
  }

  bool isPrivateAccount = false;
  togglePrivateAccount() {
    isPrivateAccount = !isPrivateAccount;
    notifyListeners();
  }
}
