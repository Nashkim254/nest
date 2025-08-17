import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nest/ui/common/app_colors.dart';
import 'package:nest/ui/common/app_custom_button.dart';
import 'package:nest/ui/common/app_strings.dart';
import 'package:nest/ui/common/app_styles.dart';
import 'package:nest/ui/common/ui_helpers.dart';
import 'package:nest/ui/views/settings/widgets/build_options.dart';
import 'package:stacked/stacked.dart';

import 'settings_viewmodel.dart';

class SettingsView extends StackedView<SettingsViewModel> {
  const SettingsView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    SettingsViewModel viewModel,
    Widget? child,
  ) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kcDarkColor,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.adaptive.arrow_back, color: kcWhiteColor),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: kcDarkColor,
          title: Text(
            "Settings",
            style: titleTextMedium.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: kcWhiteColor,
            ),
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 20.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BuildOptions(
                  assetUrl: profile,
                  title: "Edit Profile",
                  onTap: () {
                    viewModel.navigateToEditProfile();
                  },
                  secondaryAssetUrl: lock,
                  secondaryTitle: 'Change Password',
                  secondaryOnTap: () {
                    viewModel.showChangePasswordDialog();
                  },
                ),
                verticalSpaceMedium,
                BuildOptions(
                  assetUrl: notification,
                  title: "Push Notifications",
                  onTap: () {
                    viewModel.navigateToEditProfile();
                  },
                  secondaryAssetUrl: email,
                  secondaryTitle: 'Email Notifications',
                  secondaryOnTap: () {
                    // viewModel.navigateToNotifications();
                  },
                  trailing: CupertinoSwitch(
                    activeTrackColor: kcPrimaryColor,
                    value: viewModel.isPushNotificationsEnabled,
                    onChanged: (viewModel.togglePushNotifications),
                  ),
                  secondaryTrailing: CupertinoSwitch(
                    activeTrackColor: kcPrimaryColor,
                    value: viewModel.isEmailNotificationsEnabled,
                    onChanged: (viewModel.toggleEmailNotifications),
                  ),
                ),
                verticalSpaceMedium,
                BuildOptions(
                  assetUrl: privacy,
                  title: "Privacy Policy",
                  onTap: () {
                    viewModel.navigateToEditProfile();
                  },
                  secondaryAssetUrl: terms,
                  secondaryTitle: 'Terms of Service',
                  secondaryOnTap: () {
                    viewModel.navigateToNotifications();
                  },
                ),
                verticalSpaceMedium,
                BuildOptions(
                  assetUrl: info,
                  title: "App Version",
                  onTap: () {
                    viewModel.navigateToEditProfile();
                  },
                  secondaryAssetUrl: feedback,
                  secondaryTitle: 'Send Feedback',
                  secondaryOnTap: () {
                    viewModel.navigateToNotifications();
                  },
                ),
                verticalSpaceMedium,
                AppButton(
                  labelText: 'Logout',
                  onTap: () {},
                  buttonColor: kcRedColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  SettingsViewModel viewModelBuilder(
    BuildContext context,
  ) =>
      SettingsViewModel();
}
