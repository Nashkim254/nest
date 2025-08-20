import 'dart:io';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:nest/models/update_profile_input.dart';
import 'package:nest/services/global_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.bottomsheets.dart';
import '../../../app/app.locator.dart';
import '../../../models/profile.dart';
import '../../../services/file_service.dart';
import '../../../services/shared_preferences_service.dart';
import '../../../services/user_service.dart';
import '../../common/app_enums.dart';
import 'package:path/path.dart' as p;

class EditProfileViewModel extends ReactiveViewModel {
  final userService = locator<UserService>();
  final globalService = locator<GlobalService>();
  TextEditingController usernameController = TextEditingController();
  TextEditingController igController = TextEditingController();
  TextEditingController xController = TextEditingController();
  TextEditingController linkedInController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  Logger logger = Logger();
  String profilePicture = '';
  String uploadProfilePictureUrl = '';
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
      if (selectedImages.isNotEmpty) {
        await getProfileUploadUrl();
      }
    }
  }

  String getFileExtension(File file) {
    return p.extension(file.path); // includes the dot, e.g. ".jpg"
  }

  Future getProfileUploadUrl() async {
    setBusy(true);
    try {
      final response = await globalService
          .uploadFileGetURL(getFileExtension(selectedImages.first));
      if (response.statusCode == 200 && response.data != null) {
        uploadProfilePictureUrl = response.data['upload_url'];
        profilePicture = response.data['url'];
        logger.i('upload url: ${response.data}');
      } else {
        throw Exception(response.message ?? 'Failed to load upload url:');
      }
    } catch (e, s) {
      logger.e('Failed to load upload url:', e, s);
      locator<SnackbarService>().showSnackbar(
        message: 'Failed to upload url:: $e',
        duration: const Duration(seconds: 3),
      );
    } finally {
      setBusy(false);
    }
  }

  Profile? profile;
  getUser() {
    var user = locator<SharedPreferencesService>().getUserInfo();
    if (user != null) {
      profile = Profile.fromJson(user);
      logger.w('Setting controllers...');
      _updateControllersFromProfile();
      notifyListeners();
    }
  }

  Future getUserProfile() async {
    getUser(); // will already set controllers from cached data
    if (profile != null) {
      logger.i('User profile already loaded: ${profile!.toJson()}');
      return;
    }

    logger.w('Loading user profile from service...');
    setBusy(true);
    try {
      final response = await userService.getUserProfile();
      if (response.statusCode == 200 && response.data != null) {
        profile = Profile.fromJson(response.data);
        _updateControllersFromProfile();

        locator<SharedPreferencesService>().setUserInfo(response.data);
        logger.i('User profile loaded successfully: ${response.data}');
      } else {
        throw Exception(response.message ?? 'Failed to load user profile');
      }
    } catch (e, s) {
      logger.e('Failed to load user profile', e, s);
      locator<SnackbarService>().showSnackbar(
        message: 'Failed to load user profile: $e',
        duration: const Duration(seconds: 3),
      );
    } finally {
      setBusy(false);
    }
  }

  void _updateControllersFromProfile() {
    if (profile == null) return;
    usernameController.text = profile!.displayName;
    bioController.text = profile!.bio;
    igController.text = profile!.instagram ?? '';
    xController.text = profile!.twitter ?? '';
    linkedInController.text = profile!.linkedIn ?? '';
    profilePicture = profile!.profilePicture ?? '';
    // isPrivateAccount = profile!.privacySettings?.isPrivate ?? false;
    logger.wtf('already set controllers...');
  }

  bool isPrivateAccount = false;
  togglePrivateAccount() {
    isPrivateAccount = !isPrivateAccount;
    notifyListeners();
  }

  bool isLoading = false;
  Future editProfile() async {
    isLoading = (true);
    notifyListeners();
    try {
      UpdateProfileInput profileUpdateInput = UpdateProfileInput(
        displayName: usernameController.text,
        bio: bioController.text,
        firstName: profile!.firstName,
        lastName: profile!.lastName,
        profilePicture: uploadProfilePictureUrl,
        location: profile!.location,
        interests: profile!.interests,
        twitter: xController.text.isNotEmpty ? xController.text : null,
        instagram: igController.text.isNotEmpty ? igController.text : null,
        linkedIn:
            linkedInController.text.isNotEmpty ? linkedInController.text : null,
        privacySettings: PrivacySettings(
          isPrivate: isPrivateAccount,
          showOnGuestList: settingsType == SettingsType.everyone,
          showEvents: settingsType == SettingsType.everyone,
        ),
      );
      logger.wtf('Updating user profile with: ${profileUpdateInput.toJson()}');
      final response = await userService.editUserProfile(
          profileUpdateInput: profileUpdateInput);
      if (response.statusCode == 200 && response.data != null) {
        logger.i('User profile updated successfully: ${response.data}');
        locator<NavigationService>().back(result: true);
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
      isLoading = (false);
      notifyListeners();
    }
  }

  //function to get interests from input textfield by puting them in a list of strings by comma separators or space
  // List<String> getInterestsFromInput() {
  //   String input = bioController.text;
  //   List<String> interests = input.split(RegExp(r'[,\s]+')).where((i) => i.isNotEmpty).toList();
  //   return interests;
  // }
  @override
  List<ListenableServiceMixin> get listenableServices =>
      [fileService, globalService];
}
