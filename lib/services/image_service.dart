import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class ImageService {
  final ImagePicker _picker = ImagePicker();

  Future<bool> requestPermissions() async {
    Map<Permission, PermissionStatus> permissions = await [
      Permission.camera,
      Permission.photos,
    ].request();

    return permissions[Permission.camera]?.isGranted == true ||
        permissions[Permission.photos]?.isGranted == true;
  }

  Future<File?> pickImageFromCamera() async {
    try {
      final XFile? image = await _picker.pickMedia(
        imageQuality: 80,
      );
      return image != null ? File(image.path) : null;
    } catch (e) {
      throw Exception('Error picking image from camera: $e');
    }
  }

  Future<File?> pickVideoFromCamera() async {
    try {
      final XFile? image = await _picker.pickVideo(
        source: ImageSource.camera,
        maxDuration: const Duration(seconds: 30),
      );
      return image != null ? File(image.path) : null;
    } catch (e) {
      throw Exception('Error picking image from camera: $e');
    }
  }

  Future<File?> pickImageFromGallery() async {
    try {
      final XFile? image = await _picker.pickMedia(
        imageQuality: 80,
      );
      return image != null ? File(image.path) : null;
    } catch (e) {
      throw Exception('Error picking image from gallery: $e');
    }
  }

  Future<File?> pickVideoFromGallery() async {
    try {
      final XFile? image = await _picker.pickVideo(
        source: ImageSource.gallery,
        maxDuration: const Duration(seconds: 30),
      );
      return image != null ? File(image.path) : null;
    } catch (e) {
      throw Exception('Error picking image from gallery: $e');
    }
  }

  Future<List<File>> pickMultipleImages() async {
    try {
      final List<XFile> images = await _picker.pickMultipleMedia(
        imageQuality: 80,
      );
      return images.map((image) => File(image.path)).toList();
    } catch (e) {
      throw Exception('Error picking multiple images: $e');
    }
  }
}
