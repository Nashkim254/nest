import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:logger/logger.dart';
import 'package:nest/app/app.locator.dart';
import 'package:nest/models/create_post.dart';
import 'package:nest/models/profile.dart';
import 'package:nest/services/social_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:path/path.dart' as p;
import 'package:video_player/video_player.dart';
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

  late VideoPlayerController _controller;
  bool isInitialized = false;

  bool isVideoByExtension(File file) {
    final extension = file.path.toLowerCase().split('.').last;
    const videoExtensions = ['mp4', 'mov', 'avi', 'mkv', 'webm', 'flv', '3gp'];
    return videoExtensions.contains(extension);
  }

  String getVideoContentType(File file) {
    final extension = file.path.toLowerCase().split('.').last;
    switch (extension) {
      case 'mp4':
        return 'video/mp4';
      case 'mov':
        return 'video/quicktime';
      case 'avi':
        return 'video/x-msvideo';
      case 'mkv':
        return 'video/x-matroska';
      case 'webm':
        return 'video/webm';
      case 'flv':
        return 'video/x-flv';
      case '3gp':
        return 'video/3gpp';
      default:
        return 'video/mp4';
    }
  }

  Future<bool> isVideoUnder30Seconds(File videoFile) async {
    try {
      final controller = VideoPlayerController.file(videoFile);
      await controller.initialize();
      final duration = controller.value.duration;
      await controller.dispose();

      return duration.inSeconds <= 30;
    } catch (e) {
      logger.e('Error checking video duration: $e');
      return false;
    }
  }

  Future<void> _initializeVideo(File file) async {
    _controller = VideoPlayerController.file(file);
    await _controller.initialize();
    await _controller.seekTo(const Duration(seconds: 1));
    isInitialized = true;
    notifyListeners();
  }

  List<File> get selectedImages => fileService.selectedImages;
  String location = '';
  bool get hasImages => selectedImages.isNotEmpty;
  List<String> uploadImageUrls = [];
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
        List<File> invalidVideos = [];
        for (var file in selectedImages) {
          if (isVideoByExtension(file)) {
            final isValidDuration = await isVideoUnder30Seconds(file);
            if (!isValidDuration) {
              invalidVideos.add(file);
            } else {
              await _initializeVideo(file);
              break;
            }
          }
        }

        if (invalidVideos.isNotEmpty) {
          for (var invalidVideo in invalidVideos) {
            fileService.selectedImages.remove(invalidVideo);
          }
          locator<SnackbarService>().showSnackbar(
            message:
                'Videos must be 30 seconds or less. ${invalidVideos.length} video(s) removed.',
            duration: const Duration(seconds: 4),
          );
          notifyListeners();
        }

        if (selectedImages.isNotEmpty) {
          await uploadMixedMedia();
        }
      }
    }
  }

  Logger logger = Logger();
  String? videoUrl;
  double uploadProgress = 0.0;

  Future getSignedURL() async {
    setBusy(true);
    try {
      final response = await socialService.claudFlareSignVideo();
      if (response.statusCode == 200 || response.statusCode == 201) {
        logger.i('Signed URL response:', response.data);

        File? videoFile;
        for (var file in selectedImages) {
          if (isVideoByExtension(file)) {
            videoFile = file;
            break;
          }
        }
        if (videoFile != null) {
          logger.i('Uploading video file: ${videoFile.path}');
          await uploadVideoToCloudflareWithSignedData(response.data, videoFile);
        }

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
    } finally {
      setBusy(false);
    }
  }

  Future uploadVideoToCloudflareWithSignedData(
      dynamic signedUrlData, File videoFile) async {
    return await uploadVideoUsingCloudflarePackage(signedUrlData, videoFile);
  }

  Future uploadVideoUsingCloudflarePackage(
      dynamic signedUrlData, File videoFile) async {
    try {
      final result = signedUrlData['result'];
      final uid = result['uid'];
      final uploadUrl = result['uploadURL'];

      uploadProgress = 0.0;
      notifyListeners();

      logger.i('Using multipart form upload for UID: $uid');

      final dio = Dio();
      dio.options.connectTimeout = const Duration(minutes: 5);
      dio.options.sendTimeout = const Duration(minutes: 10);
      dio.options.receiveTimeout = const Duration(minutes: 5);

      final fileName = videoFile.path.split('/').last;

      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(
          videoFile.path,
          filename: fileName,
        ),
      });

      final response = await dio.post(
        uploadUrl,
        data: formData,
        onSendProgress: (sent, total) {
          if (total > 0) {
            uploadProgress = (sent / total * 100).clamp(0.0, 100.0);
            notifyListeners();
            logger.i('Upload progress: ${uploadProgress.toStringAsFixed(1)}%');
          }
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        uploadProgress = 100.0;
        notifyListeners();

        final videoPlaybackUrl = 'https://videodelivery.net/$uid/manifest/video.m3u8';
        uploadImageUrls.add(videoPlaybackUrl);

        logger.i('Upload successful. Video URL: $videoPlaybackUrl');
        logger.w('Upload successful. Video response: ${response.data}');

        locator<SnackbarService>().showSnackbar(
          message: 'Video uploaded successfully',
          duration: const Duration(seconds: 3),
        );
      } else {
        throw Exception('Upload failed: ${response.statusCode} - ${response.statusMessage}');
      }
    } catch (e, s) {
      logger.e('Upload failed: $e\n$s');
      uploadProgress = 0.0;
      notifyListeners();
      rethrow;
    }
  }

// Alternative: Try with bytes instead of stream if the above fails
  Future uploadVideoWithBytes(dynamic signedUrlData, File videoFile) async {
    try {
      final result = signedUrlData['result'];
      final uid = result['uid'];
      final uploadUrl = result['uploadURL'];

      uploadProgress = 0.0;
      notifyListeners();

      // Read file as bytes
      final bytes = await videoFile.readAsBytes();
      logger.i('Video file loaded as bytes: ${bytes.length} bytes');

      final dio = Dio();
      dio.options.connectTimeout = const Duration(minutes: 5);
      dio.options.sendTimeout = const Duration(minutes: 10);
      dio.options.receiveTimeout = const Duration(minutes: 5);

      final response = await dio.post(
        uploadUrl,
        data: bytes,
        options: Options(
          headers: {
            'Content-Length': bytes.length.toString(),
          },
        ),
        onSendProgress: (sent, total) {
          if (total != -1) {
            uploadProgress = (sent / total * 100).clamp(0.0, 100.0);
            notifyListeners();
          }
        },
      );

      if (response.statusCode == 200) {
        uploadProgress = 100.0;
        notifyListeners();

        final videoPlaybackUrl = 'https://videodelivery.net/$uid/manifest/video.m3u8';
        uploadImageUrls.add(videoPlaybackUrl);

        locator<SnackbarService>().showSnackbar(
          message: 'Video uploaded successfully',
          duration: const Duration(seconds: 3),
        );
      } else {
        throw Exception('Upload failed: ${response.statusCode}');
      }
    } catch (e, s) {
      logger.e('Bytes upload failed: $e\n$s');
      rethrow;
    }
  }

// Updated mixed media upload with fallback
  Future uploadMixedMedia() async {
    setBusy(true);
    try {
      uploadImageUrls.clear();

      for (int i = 0; i < selectedImages.length; i++) {
        File currentFile = selectedImages[i];

        if (isVideoByExtension(currentFile)) {
          final response = await socialService.claudFlareSignVideo();
          if (response.statusCode == 200 || response.statusCode == 201) {
            try {
              // Try streaming upload first
              await uploadVideoToCloudflareWithSignedData(response.data, currentFile);
            } catch (e) {
              logger.w('Stream upload failed, trying bytes upload: $e');
              // Fallback to bytes upload
              await uploadVideoWithBytes(response.data, currentFile);
            }
          } else {
            throw Exception('Failed to get signed URL for video');
          }
        } else {
          await uploadImageFile(currentFile, i);
        }
      }

      // fileService.clearSelectedImages();
      logger.i('All media uploaded successfully. Total URLs: ${uploadImageUrls.length}');
    } catch (e, s) {
      logger.e('Failed to upload mixed media: $e\n$s');
      locator<SnackbarService>().showSnackbar(
        message: 'Failed to upload media: $e',
        duration: const Duration(seconds: 3),
      );
    } finally {
      setBusy(false);
    }
  }

  Future uploadImageFile(File imageFile, int index) async {
    try {
      String fileExtension = getFileExtension(imageFile);
      logger.i('Uploading image ${index + 1}: ${imageFile.path}');

      final response = await globalService.uploadFileGetURL(fileExtension,
          folder: 'profile');

      if (response.statusCode == 200 && response.data != null) {
        uploadImageUrls.add(response.data['url']);

        final result = await globalService.uploadFile(
          response.data['upload_url'],
          imageFile,
        );

        if (result.statusCode != 200 && result.statusCode != 201) {
          throw Exception('Failed to upload image file');
        }

        logger.i('Successfully uploaded image: ${response.data['url']}');
      } else {
        throw Exception(
            'Failed to get upload URL for image: ${response.message ?? 'Unknown error'}');
      }
    } catch (e) {
      logger.e('Failed to upload image file:', e);
      rethrow;
    }
  }

  Future getFileUploadUrl() async {
    setBusy(true);
    try {
      uploadImageUrls.clear();

      for (int i = 0; i < selectedImages.length; i++) {
        File currentImage = selectedImages[i];
        String fileExtension = getFileExtension(currentImage);

        logger.i(
            'Uploading image ${i + 1}/${selectedImages.length}: ${currentImage.path}');

        final response = await globalService.uploadFileGetURL(fileExtension,
            folder: 'profile');

        if (response.statusCode == 200 && response.data != null) {
          uploadImageUrls.add(response.data['url']);

          final result = await globalService.uploadFile(
            response.data['upload_url'],
            currentImage,
          );
          if (result.statusCode == 200 || result.statusCode == 201) {
            fileService.clearSelectedImages();
          }
          logger.i(
              'Successfully uploaded image ${i + 1}: ${response.data['url']}');
          notifyListeners();
        } else {
          throw Exception(
              'Failed to get upload URL for image ${i + 1}: ${response.message ?? 'Unknown error'}');
        }
      }

      logger.i(
          'All images uploaded successfully. Total: ${uploadImageUrls.length}');
    } catch (e, s) {
      logger.e('Failed to upload images: $e\n$s');
      locator<SnackbarService>().showSnackbar(
        message: 'Failed to upload images: $e',
        duration: const Duration(seconds: 3),
      );
    } finally {
      setBusy(false);
    }
  }

  String getFileExtension(File file) {
    return p.extension(file.path);
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

  void removeImage(int index) {
    if (index >= 0 && index < selectedImages.length) {
      fileService.removeAt(index);
      if (index < uploadImageUrls.length) {
        uploadImageUrls.removeAt(index);
      }
      notifyListeners();
    }
  }

  List<String> extractHashtagsFromContent(String content) {
    List<String> hashtags = [];
    RegExp hashtagRegex = RegExp(r'#\w+');
    List<Match> matches = hashtagRegex.allMatches(content).toList();
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
