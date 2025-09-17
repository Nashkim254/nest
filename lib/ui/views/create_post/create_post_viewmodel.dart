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
import 'package:ffmpeg_kit_flutter_new/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter_new/return_code.dart';
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

  Future<File?> trimVideoTo30Seconds(File videoFile) async {
    try {
      logger.i('🎬 STEP 1: Starting video trimming for ${videoFile.path}');

      final controller = VideoPlayerController.file(videoFile);
      await controller.initialize();
      final duration = controller.value.duration;
      await controller.dispose();

      logger.i('🎬 STEP 2: Original video duration: ${duration.inSeconds} seconds');

      if (duration.inSeconds <= 30) {
        logger.i('🎬 STEP 3: Video is already under 30 seconds, no trimming needed');
        return videoFile;
      }

      // Create output file path
      final directory = videoFile.parent;
      final fileName = p.basenameWithoutExtension(videoFile.path);
      final extension = p.extension(videoFile.path);
      final outputPath = '${directory.path}/${fileName}_trimmed$extension';

      logger.i('🎬 STEP 4: Trimming video to 30 seconds...');
      logger.i('🎬 Input: ${videoFile.path}');
      logger.i('🎬 Output: $outputPath');

      // FFmpeg command to trim video to first 30 seconds
      final command = '-i "${videoFile.path}" -t 30 -c copy "$outputPath"';

      logger.i('🎬 STEP 5: Executing FFmpeg command: $command');

      final session = await FFmpegKit.execute(command);
      final returnCode = await session.getReturnCode();

      if (ReturnCode.isSuccess(returnCode)) {
        logger.i('🎬 STEP 6: Video trimming successful!');
        final trimmedFile = File(outputPath);
        if (await trimmedFile.exists()) {
          logger.i('🎬 STEP 7: Trimmed file created successfully at: $outputPath');
          return trimmedFile;
        } else {
          logger.e('🎬 ERROR: Trimmed file was not created');
          return null;
        }
      } else {
        final logs = await session.getAllLogsAsString();
        logger.e('🎬 ERROR: Video trimming failed with return code: $returnCode');
        logger.e('🎬 FFmpeg logs: $logs');
        return null;
      }
    } catch (e, s) {
      logger.e('🎬 ERROR: Exception during video trimming: $e\n$s');
      return null;
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
    logger.i('📱 STEP 1: Showing image/video source selection sheet');

    SheetResponse? response = await _bottomSheetService.showCustomSheet(
      variant: BottomSheetType.imageSource,
      isScrollControlled: true,
    );

    if (response?.confirmed == true && response?.data != null) {
      ImageSourceType sourceType = response!.data as ImageSourceType;
      logger.i('📱 STEP 2: User selected source type: $sourceType');

      switch (sourceType) {
        case ImageSourceType.camera:
          logger.i('📱 STEP 3: Picking from camera...');
          await fileService.pickImageFromCamera();
          break;
        case ImageSourceType.gallery:
          logger.i('📱 STEP 3: Picking from gallery...');
          await fileService.pickImageFromGallery();
          break;
        case ImageSourceType.multiple:
          logger.i('📱 STEP 3: Picking multiple files...');
          await fileService.pickMultipleImages();
          break;
      }

      if (selectedImages.isNotEmpty) {
        logger.i('📱 STEP 4: Processing ${selectedImages.length} selected files');
        await _processSelectedFiles();
      } else {
        logger.i('📱 STEP 4: No files were selected');
      }
    } else {
      logger.i('📱 User cancelled file selection');
    }
  }

  Future<void> _processSelectedFiles() async {
    List<File> processedVideos = [];

    for (int i = 0; i < selectedImages.length; i++) {
      File file = selectedImages[i];
      logger.i('📁 STEP ${i + 1}: Processing file: ${file.path}');

      if (isVideoByExtension(file)) {
        logger.i('🎥 STEP ${i + 1}A: Detected video file');
        final processedVideo = await _processVideoFile(file);
        if (processedVideo != null) {
          processedVideos.add(processedVideo);
          // Replace original with processed video
          fileService.selectedImages[i] = processedVideo;
          logger.i('🎥 STEP ${i + 1}B: Video processed and replaced in list');
        }
      } else {
        logger.i('🖼️ STEP ${i + 1}A: Detected image file - no processing needed');
      }
    }

    // Get upload URL for first video immediately
    if (processedVideos.isNotEmpty) {
      await _getVideoUploadUrlImmediately(processedVideos.first);
    }

    notifyListeners();
  }

  Future<File?> _processVideoFile(File videoFile) async {
    try {
      logger.i('🎬 PROCESSING VIDEO: ${videoFile.path}');

      final isValidDuration = await isVideoUnder30Seconds(videoFile);

      if (!isValidDuration) {
        logger.i('🎬 Video is longer than 30 seconds, trimming...');

        locator<SnackbarService>().showSnackbar(
          message: 'Video is longer than 30 seconds. Trimming to 30 seconds...',
          duration: const Duration(seconds: 3),
        );

        final trimmedVideo = await trimVideoTo30Seconds(videoFile);
        if (trimmedVideo != null) {
          logger.i('🎬 ✅ Video successfully trimmed');
          await _initializeVideo(trimmedVideo);
          return trimmedVideo;
        } else {
          logger.e('🎬 ❌ Failed to trim video');
          locator<SnackbarService>().showSnackbar(
            message: 'Failed to trim video. Please try a different video.',
            duration: const Duration(seconds: 4),
          );
          return null;
        }
      } else {
        logger.i('🎬 ✅ Video is within 30 seconds limit');
        await _initializeVideo(videoFile);
        return videoFile;
      }
    } catch (e) {
      logger.e('🎬 ❌ Error processing video: $e');
      return null;
    }
  }

  Future<void> _getVideoUploadUrlImmediately(File videoFile) async {
    try {
      logger.i('🌐 STEP 1: Getting upload URL immediately for video...');

      setBusy(true);

      final response = await socialService.claudFlareSignVideo();

      if (response.statusCode == 200 || response.statusCode == 201) {
        final result = response.data['result'];
        final uid = result['uid'];
        final uploadUrl = result['uploadURL'];

        logger.i('🌐 STEP 2: ✅ Got upload URL successfully');
        logger.i('🌐 Video UID: $uid');
        logger.i('🌐 Upload URL: $uploadUrl');

        // Store video upload data immediately
        videoUploadData.clear();
        videoUploadData.add({
          'file': videoFile,
          'uid': uid,
          'uploadUrl': uploadUrl,
          'signedData': response.data,
        });

        videoMediaId = uid;

        logger.i('🌐 STEP 3: ✅ Video upload data stored with UID: $uid');

        locator<SnackbarService>().showSnackbar(
          message: 'Video ready for upload!',
          duration: const Duration(seconds: 2),
        );
      } else {
        logger.e('🌐 ❌ Failed to get upload URL: ${response.statusCode}');
        throw Exception('Failed to get signed URL for video');
      }
    } catch (e) {
      logger.e('🌐 ❌ Error getting upload URL: $e');
      locator<SnackbarService>().showSnackbar(
        message: 'Failed to prepare video upload. Please try again.',
        duration: const Duration(seconds: 3),
      );
    } finally {
      setBusy(false);
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
      final contentType = getVideoContentType(videoFile);

      final formData = FormData.fromMap({
        'file': await MultipartFile.fromFile(
          videoFile.path,
          filename: fileName,
          contentType: DioMediaType.parse(contentType),
        ),
      });

      final response = await dio.post(
        uploadUrl,
        data: formData,
        options: Options(
          headers: {
            'Content-Type': 'multipart/form-data',
          },
        ),
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
        logger.i('Upload response status: ${response.statusCode}');

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
      final contentType = getVideoContentType(videoFile);
      logger.i('Video file loaded as bytes: ${bytes.length} bytes');
      logger.i('Content type: $contentType');

      final dio = Dio();
      dio.options.connectTimeout = const Duration(minutes: 5);
      dio.options.sendTimeout = const Duration(minutes: 10);
      dio.options.receiveTimeout = const Duration(minutes: 5);

      final response = await dio.post(
        uploadUrl,
        data: bytes,
        options: Options(
          headers: {
            'Content-Type': contentType,
            'Content-Length': bytes.length.toString(),
          },
        ),
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

        logger.i('Bytes upload successful for UID: $uid');
        logger.i('Upload response status: ${response.statusCode}');

        locator<SnackbarService>().showSnackbar(
          message: 'Video uploaded successfully',
          duration: const Duration(seconds: 3),
        );
      } else {
        throw Exception(
            'Upload failed: ${response.statusCode} - ${response.statusMessage}');
      }
    } catch (e, s) {
      logger.e('Bytes upload failed: $e\n$s');
      uploadProgress = 0.0;
      notifyListeners();
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
    logger.i('📝 ========== STARTING POST CREATION ==========');
    logger.i('📝 STEP 1: Setting loading state and preparing data...');

    isLoading = true;
    notifyListeners();

    try {
      logger.i('📝 STEP 2: Current state check:');
      logger.i('📝 - Selected files: ${selectedImages.length}');
      logger.i('📝 - Upload image URLs: ${uploadImageUrls.length}');
      logger.i('📝 - Video media ID: $videoMediaId');
      logger.i('📝 - Video upload data ready: ${videoUploadData.isNotEmpty}');
      logger.i('📝 - Content: "${postController.text}"');
      logger.i('📝 - Location: "$location"');

      // Only prepare media if we haven't already (video URLs should be ready immediately)
      if (selectedImages.isNotEmpty && uploadImageUrls.isEmpty && videoUploadData.isEmpty) {
        logger.i('📝 STEP 3: Preparing media (this should not happen for videos)...');
        await prepareAllMedia();
      } else {
        logger.i('📝 STEP 3: Media already prepared - skipping preparation');
      }

      logger.i('📝 STEP 4: Creating post request object...');

      CreatePostRequest post = CreatePostRequest(
          location: location,
          imageUrls: uploadImageUrls.isNotEmpty ? uploadImageUrls : null,
          content: postController.text,
          isPrivate: profile!.isPrivate,
          mediaId: videoMediaId,
          hashtags: extractHashtagsFromContent(postController.text));

      logger.i('📝 STEP 5: Post request details:');
      logger.i('📝 - Content: "${post.content}"');
      logger.i('📝 - Image URLs: ${post.imageUrls}');
      logger.i('📝 - Media ID (video): ${post.mediaId}');
      logger.i('📝 - Location: ${post.location}');
      logger.i('📝 - Is private: ${post.isPrivate}');
      logger.i('📝 - Hashtags: ${post.hashtags}');

      logger.i('📝 STEP 6: Sending post creation request to API...');

      final response = await socialService.createPost(post: post);

      logger.i('📝 STEP 7: Post creation response received');
      logger.i('📝 - Status code: ${response.statusCode}');
      logger.i('📝 - Response message: ${response.message}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        logger.i('📝 STEP 8: ✅ Post created successfully!');

        // Check if we have videos to upload
        if (videoUploadData.isNotEmpty) {
          logger.i('📝 STEP 9: Videos found - preparing background upload');
          logger.i('📝 - Videos to upload: ${videoUploadData.length}');

          // Make a copy of video data before clearing to avoid concurrent modification
          final videosToUpload = List<Map<String, dynamic>>.from(videoUploadData);

          logger.i('📝 STEP 10: Clearing form data and starting background upload...');

          // Clear form data immediately
          clearAllImages();
          postController.clear();
          location = '';

          // Upload videos using the copy
          _uploadVideosInBackground(videosToUpload);
        } else {
          logger.i('📝 STEP 9: No videos to upload - just clearing form');

          // No videos to upload, just clear and navigate
          clearAllImages();
          postController.clear();
          location = '';
        }

        // Navigate back immediately
        logger.i('📝 STEP 11: Navigating back to previous screen...');
        locator<NavigationService>().back(result: true);

        locator<SnackbarService>().showSnackbar(
          message: 'Post created successfully',
          duration: const Duration(seconds: 3),
        );

        logger.i('📝 ========== POST CREATION COMPLETED SUCCESSFULLY ==========');
        return response;
      } else {
        logger.e('📝 ❌ STEP 8: Post creation failed');
        logger.e('📝 - Status code: ${response.statusCode}');
        logger.e('📝 - Error message: ${response.message}');

        locator<SnackbarService>().showSnackbar(
          message: response.message ?? 'Failed to create post',
          duration: const Duration(seconds: 3),
        );
      }
    } catch (e, s) {
      logger.e('📝 ❌ CRITICAL ERROR during post creation: $e');
      logger.e('📝 Stack trace: $s');

      locator<SnackbarService>().showSnackbar(
        message: 'Failed to create post: $e',
        duration: const Duration(seconds: 3),
      );
    } finally {
      logger.i('📝 STEP FINAL: Resetting loading state...');
      isLoading = false;
      notifyListeners();
    }
  }

  Future _uploadVideosInBackground(List<Map<String, dynamic>> videosToUpload) async {
    logger.i('🚀 ========== STARTING BACKGROUND VIDEO UPLOAD ==========');
    logger.i('🚀 STEP 1: Preparing to upload ${videosToUpload.length} video(s)');

    try {
      await _processVideoUploads(videosToUpload);
      logger.i('🚀 ========== ALL VIDEOS UPLOADED SUCCESSFULLY ==========');

      locator<SnackbarService>().showSnackbar(
        message: 'Video uploaded successfully',
        duration: const Duration(seconds: 2),
      );
    } catch (e) {
      logger.e('🚀 ❌ BACKGROUND VIDEO UPLOAD FAILED: $e');

      locator<SnackbarService>().showSnackbar(
        message: 'Video upload failed. Please try again.',
        duration: const Duration(seconds: 3),
      );
    }
  }

  Future _processVideoUploads(List<Map<String, dynamic>> videosToUpload) async {
    logger.i('📤 STEP 2: Processing video uploads...');

    for (int i = 0; i < videosToUpload.length; i++) {
      var videoData = videosToUpload[i];

      try {
        final file = videoData['file'] as File;
        final signedData = videoData['signedData'];
        final uid = videoData['uid'];
        final uploadUrl = videoData['uploadUrl'];

        logger.i('📤 STEP 2.${i + 1}: Processing video ${i + 1}/${videosToUpload.length}');
        logger.i('📤 - UID: $uid');
        logger.i('📤 - File: ${file.path}');
        logger.i('📤 - File size: ${await file.length()} bytes');
        logger.i('📤 - Upload URL: $uploadUrl');

        logger.i('📤 STEP 2.${i + 1}A: Attempting multipart form upload...');

        try {
          // Try streaming upload first
          await uploadVideoToCloudflareWithSignedData(signedData, file);
          logger.i('📤 ✅ Multipart upload successful for UID: $uid');
        } catch (e) {
          logger.w('📤 ⚠️ Multipart upload failed for UID: $uid, trying bytes upload: $e');

          logger.i('📤 STEP 2.${i + 1}B: Attempting bytes upload fallback...');
          // Fallback to bytes upload
          await uploadVideoWithBytes(signedData, file);
          logger.i('📤 ✅ Bytes upload successful for UID: $uid');
        }

        logger.i('📤 ✅ STEP 2.${i + 1}: Video upload completed successfully for UID: $uid');
      } catch (e, s) {
        logger.e('📤 ❌ STEP 2.${i + 1}: Failed to upload video ${videoData['uid']}: $e');
        logger.e('📤 Stack trace: $s');
        // Continue with other videos even if one fails
      }
    }

    logger.i('📤 STEP 3: All video uploads processed');
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
