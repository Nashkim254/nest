import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import 'package:nest/app/app.locator.dart';
import 'package:nest/models/create_post.dart';
import 'package:nest/models/profile.dart';
import 'package:nest/services/social_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:path/path.dart' as p;
import '../../../app/app.bottomsheets.dart';
import '../../../services/file_service.dart';
import '../../../services/global_service.dart';
import '../../../services/shared_preferences_service.dart';
import '../../common/app_enums.dart';

class CreatePostViewModel extends ReactiveViewModel {
  TextEditingController postController = TextEditingController();
  final fileService = locator<FileService>();
  final globalService = locator<GlobalService>();
  final socialService = locator<SocialService>();
  Profile? profile;
  getUser() {
    var user = locator<SharedPreferencesService>().getUserInfo();
    profile = Profile.fromJson(user!);
    notifyListeners();
  }

  List<File> get selectedImages => fileService.selectedImages;
  String location = '';
  bool get hasImages => selectedImages.isNotEmpty;
  List<String> uploadImageUrls = [];
  final _bottomSheetService = locator<BottomSheetService>();
  Future<void> showImageSourceSheet(FileType fileType) async {
    SheetResponse? response = await _bottomSheetService.showCustomSheet(
      variant: BottomSheetType.imageSource,
      isScrollControlled: true,
    );

    if (response?.confirmed == true && response?.data != null) {
      ImageSourceType sourceType = response!.data as ImageSourceType;

      switch (sourceType) {
        case ImageSourceType.camera:
          await fileService.pickImageFromCamera(fileType);
          break;
        case ImageSourceType.gallery:
          await fileService.pickImageFromGallery();
          break;
        case ImageSourceType.multiple:
          await fileService.pickMultipleImages();
          break;
      }
      if (selectedImages.isNotEmpty) {
        if (fileType == FileType.video) {
          await getSignedURL();
          return;
        }
        await getFileUploadUrl();
      }
    }
  }

  Logger logger = Logger();
  Future getSignedURL() async {
    try {
      final response = await socialService.claudFlareSignVideo();
      if (response.statusCode == 200 && response.data != null) {
        logger.i(response.data);
        return response.data;
      } else {
        throw Exception(
            'Failed to get signed URL: ${response.message ?? 'Unknown error'}');
      }
    } catch (e) {
      logger.e('Failed to get signed URL:', e);
      locator<SnackbarService>().showSnackbar(
        message: 'Failed to get signed URL: $e',
        duration: const Duration(seconds: 3),
      );
    }
  }

  Future getFileUploadUrl() async {
    setBusy(true);
    try {
      // Clear previous upload URLs if needed
      uploadImageUrls.clear();

      // Loop through each selected image
      for (int i = 0; i < selectedImages.length; i++) {
        File currentImage = selectedImages[i];
        String fileExtension = getFileExtension(currentImage);

        logger.i(
            'Uploading image ${i + 1}/${selectedImages.length}: ${currentImage.path}');
        logger.wtf(fileExtension);

        // Get upload URL for current image
        final response = await globalService.uploadFileGetURL(fileExtension,
            folder: 'profile');

        if (response.statusCode == 200 && response.data != null) {
          // Store the final URL
          uploadImageUrls.add(response.data['url']);

          // Upload the actual file
          await globalService.uploadFile(
            response.data['upload_url'],
            currentImage,
          );

          logger.i(
              'Successfully uploaded image ${i + 1}: ${response.data['url']}');

          // Notify listeners after each successful upload (optional)
          notifyListeners();
        } else {
          throw Exception(
              'Failed to get upload URL for image ${i + 1}: ${response.message ?? 'Unknown error'}');
        }
      }

      logger.i(
          'All images uploaded successfully. Total: ${uploadImageUrls.length}');
    } catch (e, s) {
      logger.e('Failed to upload images:', e, s);
      locator<SnackbarService>().showSnackbar(
        message: 'Failed to upload images: $e',
        duration: const Duration(seconds: 3),
      );
    } finally {
      setBusy(false);
    }
  }

  String getFileExtension(File file) {
    return p.extension(file.path); // includes the dot, e.g. ".jpg"
  }

  Future<void> showAddLocationSheet() async {
    SheetResponse? response = await _bottomSheetService.showCustomSheet(
      variant: BottomSheetType.addLocation,
      isScrollControlled: true,
    );

    if (response?.confirmed == true && response?.data != null) {
      location = response!.data as String;
      notifyListeners();
    }
  }

  Future<void> showTagPeopleSheet() async {
    SheetResponse? response = await _bottomSheetService.showCustomSheet(
      variant: BottomSheetType.tagPeople,
      isScrollControlled: true,
    );

    if (response?.confirmed == true && response?.data != null) {}
  }

  // Rest of your existing methods...

  void removeImage(int index) {
    if (index >= 0 && index < selectedImages.length) {
      selectedImages.removeAt(index);
      uploadImageUrls.removeAt(index);
      notifyListeners();
    }
  }

  List<String> extractHashtagsFromContent(String content) {
    List<String> hashtags = [];
    // Regular expression to match hashtags
    RegExp hashtagRegex = RegExp(r'#\w+');
    // Find all matches in the content
    List<Match> matches = hashtagRegex.allMatches(content).toList();
    // Extract the hashtags from the matches
    for (Match match in matches) {
      hashtags.add(match.group(0)!);
    }
    return hashtags;
  }

  bool isLoading = false;
  Future createPost() async {
    isLoading = true;
    notifyListeners();
    try {
      CreatePostRequest post = CreatePostRequest(
          location: location,
          imageUrls: uploadImageUrls,
          content: postController.text,
          isPrivate: profile!.isPrivate,
          hashtags: extractHashtagsFromContent(postController.text));
      final response = await socialService.createPost(
        post: post,
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        clearAllImages();
        postController.clear();
        locator<NavigationService>().back(result: true);
        locator<SnackbarService>().showSnackbar(
          message: 'Post created successfully',
          duration: const Duration(seconds: 3),
        );
        return response;
      } else {
        locator<SnackbarService>().showSnackbar(
          message: response.message ?? 'Failed to create post',
          duration: const Duration(seconds: 3),
        );
      }
    } catch (e) {
      logger.e(e.toString());
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void clearAllImages() {
    selectedImages.clear();
    notifyListeners();
  }

  @override
  List<ListenableServiceMixin> get listenableServices =>
      [globalService, fileService];
}
