import 'dart:io';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:nest/models/update_profile_input.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.bottomsheets.dart';
import '../../../app/app.locator.dart';
import '../../../models/profile.dart';
import '../../../services/file_service.dart';
import '../../../services/shared_preferences_service.dart';
import '../../../services/user_service.dart';
import '../../common/app_enums.dart';

class EditProfileViewModel extends ReactiveViewModel {
  final userService = locator<UserService>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController igController = TextEditingController();
  TextEditingController xController = TextEditingController();
  TextEditingController linkedInController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  Logger logger = Logger();
  String profilePicture = '';
  SettingsType settingsType = SettingsType.everyone;
  selectSettingsType(SettingsType type) {
    settingsType = type;
    notifyListeners();
  }

  final fileService = locator<FileService>();

  List<File> get selectedImages => fileService.selectedImages;

  bool get hasImages => selectedImages.isNotEmpty;

  final _bottomSheetService = locator<BottomSheetService>();

  Future<void> showImageSourceSheet() async {
    SheetResponse? response = await _bottomSheetService.showCustomSheet(
      variant: BottomSheetType.imageSource,
      isScrollControlled: true,
    );

    if (response?.confirmed == true && response?.data != null) {
      ImageSourceType sourceType = response!.data as ImageSourceType;

      switch (sourceType) {
        case ImageSourceType.camera:
          await fileService.pickImageFromCamera();
          break;
        case ImageSourceType.gallery:
          await fileService.pickImageFromGallery();
          break;
        case ImageSourceType.multiple:
          await fileService.pickMultipleImages();
          break;
      }
    }
  }

  Profile? profile;
  getUser() {
    var user = locator<SharedPreferencesService>().getUserInfo();
    profile = Profile.fromJson(user!);
    notifyListeners();
  }

  Future getUserProfile() async {
    getUser().then((value) {
      if (profile != null) {
        logger.i('User profile already loaded: ${profile!.toJson()}');
        return;
      }
    });
    setBusy(true);
    try {
      final response = await userService.getUserProfile();
      if (response.statusCode == 200 && response.data != null) {
        profile = Profile.fromJson(response.data);
        usernameController.text = profile!.displayName;
        bioController.text = profile!.interests.join(', ');

        locator<SharedPreferencesService>().setUserInfo(response.data);
        logger.i('User profile loaded successfully: ${response.data}');
      } else {
        throw Exception(response.message ?? 'Failed to load user profile');
      }
    } catch (e, s) {
      logger.i('error: $e');
      logger.e('error: $s');

      locator<SnackbarService>().showSnackbar(
        message: 'Failed to load user profile: $e',
        duration: const Duration(seconds: 3),
      );
    } finally {
      setBusy(false);
    }
  }

  bool isPrivateAccount = false;
  togglePrivateAccount() {
    isPrivateAccount = !isPrivateAccount;
    notifyListeners();
  }

  Future followUnfollowUser() async {
    setBusy(true);
    try {
      UpdateProfileInput profileUpdateInput = UpdateProfileInput(
        displayName: usernameController.text,
        bio: bioController.text,
        firstName: profile!.firstName,
        lastName: profile!.lastName,
        profilePicture: profilePicture,
        location: profile!.location,
        interests: profile!.interests,
        privacySettings: PrivacySettings(
          isPrivate: isPrivateAccount,
          showOnGuestList: settingsType == SettingsType.everyone,
          showEvents: settingsType == SettingsType.everyone,
        ),
      );
      final response = await userService.editUserProfile(
          profileUpdateInput: profileUpdateInput);
      if (response.statusCode == 200 && response.data != null) {
        logger.i('User profile updated successfully: ${response.data}');
      } else {
        throw Exception(response.message ?? 'Failed to profile update');
      }
    } catch (e, s) {
      logger.i('error: $e');
      logger.e('error: $s');

      locator<SnackbarService>().showSnackbar(
        message: 'Failed to update user profile: $e',
        duration: const Duration(seconds: 3),
      );
    } finally {
      setBusy(false);
    }
  }
  //function to get interests from input textfield by puting them in a list of strings by comma separators or space
  // List<String> getInterestsFromInput() {
  //   String input = bioController.text;
  //   List<String> interests = input.split(RegExp(r'[,\s]+')).where((i) => i.isNotEmpty).toList();
  //   return interests;
  // }
  @override
  List<ListenableServiceMixin> get listenableServices => [fileService];
}
