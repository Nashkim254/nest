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

        // Just notify that files are selected - don't upload yet
        notifyListeners();
      }
    }
  }

  Logger logger = Logger();
  String? videoUrl;
  double uploadProgress = 0.0;

  Future uploadVideoToCloudflareWithSignedData(
      dynamic signedUrlData, File videoFile) async {
    return await uploadVideoUsingCloudflarePackage(signedUrlData, videoFile);
  }

  Future uploadVideoUsingCloudflarePackage(
    dynamic signedUrlData,
    File videoFile,
  ) async {
    try {
      final result = signedUrlData['result'];
      final uid = result['uid'];
      final uploadUrl = result['uploadURL'];

      uploadProgress = 0.0;
      notifyListeners();

      logger.i('Using multipart form upload for UID: $uid');
      logger.i('Upload URL: $uploadUrl');
      logger.i('File size: ${await videoFile.length()} bytes');
      logger.i('File path: ${videoFile.path}');

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

        logger.i('Upload successful for UID: $uid');
        logger.w('Upload response status: ${response.statusCode}');
        logger.w('Upload response data: ${response.data}');
        logger.w('Upload response headers: ${response.headers}');
        
        // Check if response actually indicates success
        if (response.data == null || response.data.toString().trim().isEmpty) {
          logger.e('Warning: Upload returned 200 but with empty response body - this may indicate a failed upload');
        }

        locator<SnackbarService>().showSnackbar(
          message: 'Video uploaded successfully',
          duration: const Duration(seconds: 3),
        );
      } else {
        throw Exception(
            'Upload failed: ${response.statusCode} - ${response.statusMessage}');
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

        logger.i('Bytes upload successful for UID: $uid');

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

// Prepare media before post creation - gets UID for first video, uploads images
  Future prepareAllMedia() async {
    setBusy(true);
    try {
      uploadImageUrls.clear();
      videoUploadData.clear();
      videoMediaId = null;
      bool hasProcessedVideo = false;

      for (int i = 0; i < selectedImages.length; i++) {
        File currentFile = selectedImages[i];

        if (isVideoByExtension(currentFile)) {
          if (!hasProcessedVideo) {
            // Process only the first video (one video per post)
            final response = await socialService.claudFlareSignVideo();
            if (response.statusCode == 200 || response.statusCode == 201) {
              final result = response.data['result'];
              final uid = result['uid'];
              final uploadUrl = result['uploadURL'];

              // Store only one video data for later upload
              videoUploadData.add({
                'file': currentFile,
                'uid': uid,
                'uploadUrl': uploadUrl,
                'signedData': response.data,
              });

              // Store the video UID for mediaId field
              videoMediaId = uid;
              hasProcessedVideo = true;

              logger.i('Got video UID for mediaId: $uid');
            } else {
              throw Exception('Failed to get signed URL for video');
            }
          } else {
            // Skip additional videos and notify user
            logger.w('Skipping additional video: ${currentFile.path}');
          }
        } else {
          // Upload images immediately
          await uploadImageFile(currentFile, i);
        }
      }

      // Count total videos selected
      int totalVideos = selectedImages.where((file) => isVideoByExtension(file)).length;
      if (totalVideos > 1) {
        locator<SnackbarService>().showSnackbar(
          message: 'Only one video per post is supported. Using the first video selected.',
          duration: const Duration(seconds: 3),
        );
      }

      logger.i(
          'Media prepared successfully. Images: ${uploadImageUrls.length}, Video UID: $videoMediaId, Videos processed: ${hasProcessedVideo ? 1 : 0}/$totalVideos');
    } catch (e, s) {
      logger.e('Failed to prepare media: $e\n$s');
      locator<SnackbarService>().showSnackbar(
        message: 'Failed to prepare media: $e',
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
  List<dynamic> videoUploadData =
      []; // Store video upload data for later upload
  String? videoMediaId; // Store video UID for mediaId field

  Future createPost() async {
    isLoading = true;
    notifyListeners();
    try {
      // First prepare all media (get video UIDs, upload images)
      await prepareAllMedia();

      // Create the post with media UIDs/URLs
      CreatePostRequest post = CreatePostRequest(
          location: location,
          imageUrls: uploadImageUrls.isNotEmpty ? uploadImageUrls : null,
          content: postController.text,
          isPrivate: profile!.isPrivate,
          mediaId: videoMediaId,
          hashtags: extractHashtagsFromContent(postController.text));

      final response = await socialService.createPost(
        post: post,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Post created successfully, now upload videos in background
        if (videoUploadData.isNotEmpty) {
          // Make a copy of video data before clearing to avoid concurrent modification
          final videosToUpload = List<Map<String, dynamic>>.from(videoUploadData);
          
          // Clear form data immediately
          clearAllImages();
          postController.clear();
          location = '';
          
          // Upload videos using the copy
          _uploadVideosInBackground(videosToUpload);
        } else {
          // No videos to upload, just clear and navigate
          clearAllImages();
          postController.clear();
          location = '';
        }

        // Navigate back immediately
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
      logger.e('Error creating post: $e');
      locator<SnackbarService>().showSnackbar(
        message: 'Failed to create post: $e',
        duration: const Duration(seconds: 3),
      );
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future _uploadVideosInBackground(List<Map<String, dynamic>> videosToUpload) async {
    logger.i('Starting background video upload for ${videosToUpload.length} video(s)');
    
    try {
      await _processVideoUploads(videosToUpload);
      logger.i('All videos uploaded successfully in background');
      locator<SnackbarService>().showSnackbar(
        message: 'Video uploaded successfully',
        duration: const Duration(seconds: 2),
      );
    } catch (e) {
      logger.e('Background video upload failed: $e');
      locator<SnackbarService>().showSnackbar(
        message: 'Video upload failed. Please try again.',
        duration: const Duration(seconds: 3),
      );
    }
  }

  Future _processVideoUploads(List<Map<String, dynamic>> videosToUpload) async {
    for (var videoData in videosToUpload) {
      try {
        final file = videoData['file'] as File;
        final signedData = videoData['signedData'];

        logger.i('Uploading video to Cloudflare for UID: ${videoData['uid']}');

        try {
          // Try streaming upload first
          await uploadVideoToCloudflareWithSignedData(signedData, file);
        } catch (e) {
          logger.w('Stream upload failed, trying bytes upload: $e');
          // Fallback to bytes upload
          await uploadVideoWithBytes(signedData, file);
        }

        logger.i('Successfully uploaded video: ${videoData['uid']}');
      } catch (e) {
        logger.e('Failed to upload video ${videoData['uid']}: $e');
        // Continue with other videos even if one fails
      }
    }
  }

  // Legacy method for backward compatibility
  Future uploadVideosToCloudflare() async {
    final typedVideoData = videoUploadData.cast<Map<String, dynamic>>();
    await _processVideoUploads(typedVideoData);
  }

  void clearAllImages() {
    fileService.clearSelectedImages();
    uploadImageUrls.clear();
    videoUploadData.clear();
    videoMediaId = null;
    uploadProgress = 0.0;
    notifyListeners();
  }

  @override
  List<ListenableServiceMixin> get listenableServices =>
      [globalService, fileService];
}
