import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logger/logger.dart';
import 'package:nest/models/organization_model.dart';
import 'package:nest/services/global_service.dart';
import 'package:nest/services/user_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.bottomsheets.dart';
import '../../../app/app.dialogs.dart';
import '../../../app/app.locator.dart';
import 'package:path/path.dart' as p;

import '../../../models/people_model.dart';
import '../../../services/file_service.dart';
import '../../common/app_enums.dart';

class CreateOrganizationViewModel extends ReactiveViewModel {
  final navigationService = locator<NavigationService>();
  final userService = locator<UserService>();
  final globalService = locator<GlobalService>();
  final TextEditingController organizationNameController =
      TextEditingController();
  final TextEditingController organizationSocialController =
      TextEditingController();
  final TextEditingController organizationContactController =
      TextEditingController();
  final TextEditingController businessController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  final TextEditingController genreController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  Logger logger = Logger();
  final formKey = GlobalKey<FormState>();
  final dialogService = locator<DialogService>();
  final bottomSheet = locator<BottomSheetService>();
  String socialLink = '';
  String profilePic = '';
  String profilePicUploadUrl = '';
  String banner = '';
  String bannerUploadUrl = '';
  File? selectedBannerImage;
  File? selectedProfileImage;

  List<TeamMember> teamMembers = [];
  addTeamMember(TeamMember member) {
    if (!teamMembers.contains(member)) {
      teamMembers.add(member);
      organizationContactController.clear();
      notifyListeners();
    }
  }

  removeTeamMember(int index) {
    teamMembers.removeAt(index);
    notifyListeners();
  }

//get list of strings from comma separated string or space
  List<String> getTeamMembersFromString(String members) {
    return members.split(',').map((e) => e.trim()).toList();
  }

  //genres
  List<String> getGenresFromString(String genres) {
    return genres.split(',').map((e) => e.trim()).toList();
  }

  //countries
  List<String> getCountriesFromString(String countries) {
    return countries.split(',').map((e) => e.trim()).toList();
  }

  addPeople() {
    final response = bottomSheet.showCustomSheet(
      variant: BottomSheetType.tagPeople,
      title: 'Add Team Member',
      isScrollControlled: true,
      barrierDismissible: true,
    );
    response.then((sheetResponse) {
      if (sheetResponse?.confirmed == true && sheetResponse?.data != null) {
        var data = sheetResponse!.data as List<People>;
        logger.i('Data from sheet: ${data.first.toJson()}');
        TeamMember newMember = TeamMember(
          name: data.first.name,
          role: data.first.role,
        );
        teamMembers.add(newMember);
        notifyListeners();
      }
    });
  }

  addSocialMediaLink() {
    final response = dialogService.showCustomDialog(
      variant: DialogType.addSocial,
      title: 'Add Social Media Link',
      barrierDismissible: true,
    );
    response.then((dialogResponse) {
      if (dialogResponse?.confirmed == true && dialogResponse?.data != null) {
        var data = dialogResponse!.data as Map;
        socialLink = data['socialLink'] as String;
        var socialName = data['socialName'] as String;
        getSocialMediaFromResponse(dialogResponse);
        organizationSocialController.text += '$socialName, ';
        notifyListeners();
      }
    });
  }

  // Function to get name of social and link from dialog response
  Map<String, String> getSocialMediaFromResponse(DialogResponse response) {
    if (response.confirmed && response.data != null) {
      var data = response.data as Map<String, String>;
      return {
        'name': data['socialName'] ?? '',
        'link': data['socialLink'] ?? '',
      };
    }
    return {};
  }

  //function that return social link as the value and name as the key
  Map<String, String> getSocialMediaLinks() {
    Map<String, String> socialMediaLinks = {};
    List<String> links = organizationSocialController.text.split(', ');
    for (String link in links) {
      if (link.isNotEmpty) {
        // Assuming the format is "name:link"
        List<String> parts = link.split(':');
        if (parts.length == 2) {
          socialMediaLinks[parts[0].trim()] = parts[1].trim();
        } else {
          socialMediaLinks[link.trim()] = '';
        }
      }
    }
    return socialMediaLinks;
  }

  List<String> countries = [];
  String? selectedCountry;

  Future<void> loadCountries() async {
    final String response =
        await rootBundle.loadString('assets/countries.json');
    final List data = json.decode(response);
    countries = data.map((c) => c['name'] as String).toList();
    notifyListeners();
  }

  Future createOrganizations() async {
    setBusy(true);
    if (!formKey.currentState!.validate()) {
      setBusy(false);
      return;
    }
    try {
      Organization organization = Organization(
        name: organizationNameController.text,
        profilePic: profilePic,
        bio: bioController.text,
        genres: getGenresFromString(genreController.text),
        countries: getCountriesFromString(countryController.text),
        teamMembers: teamMembers,
        banner: banner,
        instagram: getSocialMediaLinks()['Instagram'],
        twitter: getSocialMediaLinks()['Twitter'],
        linkedIn: getSocialMediaLinks()['LinkedIn'],
        facebook: getSocialMediaLinks()['Facebook'],
        website: organizationContactController.text.contains('http')
            ? organizationContactController.text
            : '',
        whatsApp: organizationContactController.text,
        phoneNumber: getSocialMediaLinks()['Phone'],
        email: organizationContactController.text.contains('@')
            ? organizationContactController.text
            : '',
        description: businessController.text,
      );
      logger.i('Creating organization: ${organization.toJson()}');
      final response =
          await userService.createOrganization(organization: organization);
      if (response.statusCode == 200 || response.statusCode == 201) {
        logger.i('My Organizations: ${response.data}');
        navigationService.back(result: true);
        locator<SnackbarService>().showSnackbar(
          message: 'Organization created successfully',
          duration: const Duration(seconds: 3),
        );

      } else {
        // Handle error response
        logger.e('Failed to load organizations: ${response.message}');
        locator<SnackbarService>().showSnackbar(
          message: response.message ?? 'Failed to load organizations',
          duration: const Duration(seconds: 3),
        );
      }
    } catch (e) {
      // Handle exception
    } finally {
      setBusy(false);
    }
  }

  final fileService = locator<FileService>();

  List<File> get selectedImages => fileService.selectedImages;

  bool get hasImages => selectedImages.isNotEmpty;

  final _bottomSheetService = locator<BottomSheetService>();

  Future<void> showImageSourceSheet(String type, FileType fileType) async {
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
        // Store the selected image for the specific type
        if (type == 'banner') {
          selectedBannerImage = selectedImages.last;
        } else if (type == 'profile') {
          selectedProfileImage = selectedImages.last;
        }
        await getProfileUploadUrl(type);
      }
    }
  }

  String getFileExtension(File file) {
    return p.extension(file.path);
  }

  Future getProfileUploadUrl(String type) async {
    setBusy(true);
    try {
      // Determine which file to upload based on type and upload URLs
      File imageFile = _getImageFileForUpload(type);
      
      final response = await globalService.uploadFileGetURL(
          getFileExtension(imageFile),
          folder: 'profile');
      
      if (response.statusCode == 200 && response.data != null) {
        if (type == 'profile') {
          profilePic = response.data['url'];
          profilePicUploadUrl = response.data['upload_url'];
        } else if (type == 'banner') {
          banner = response.data['url'];
          bannerUploadUrl = response.data['upload_url'];
        }
        
        // Now actually upload the file
        final result = await globalService.uploadFile(
          response.data['upload_url'],
          imageFile,
        );
        
        if (result.statusCode != 200 && result.statusCode != 201) {
          throw Exception('Failed to upload $type image');
        }
        
        logger.i('Successfully uploaded $type image: ${response.data['url']}');

      } else {
        throw Exception(response.message ?? 'Failed to get upload URL for $type image');
      }
    } catch (e) {
      logger.e('Error uploading $type image: $e');
      rethrow;
    } finally {
      setBusy(false);
    }
  }

  File _getImageFileForUpload(String type) {
    // Use the specific image selected for this type
    if (type == 'banner' && selectedBannerImage != null) {
      return selectedBannerImage!;
    } else if (type == 'profile' && selectedProfileImage != null) {
      return selectedProfileImage!;
    }
    // Fallback to most recent selection
    return selectedImages.last;
  }

  @override
  List<ListenableServiceMixin> get listenableServices =>
      [globalService, fileService];
}
