import 'dart:io';

import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../app/app.locator.dart';
import 'image_service.dart';

class FileService with ListenableServiceMixin {
  FileService() {
    listenToReactiveValues([selectedImages]);
  }
  final _bottomSheetService = locator<BottomSheetService>();
  final ImageService _imageService = locator<ImageService>();
  final List<File> _selectedImages = [];
  List<File> get selectedImages => _selectedImages;
  Future<void> pickImageFromCamera() async {
    try {
      bool hasPermission = await _imageService.requestPermissions();
      if (!hasPermission) {
        return;
      }

      File? image = await _imageService.pickImageFromCamera();
      if (image != null) {
        _selectedImages.add(image);
        notifyListeners();
      }
    } catch (e) {
    } finally {}
  }

  Future<void> pickImageFromGallery() async {
    try {
      bool hasPermission = await _imageService.requestPermissions();
      if (!hasPermission) {
        return;
      }

      File? image = await _imageService.pickImageFromGallery();
      if (image != null) {
        _selectedImages.add(image);
        notifyListeners();
      }
    } catch (e) {
    } finally {}
  }

  Future<void> pickMultipleImages() async {
    try {
      bool hasPermission = await _imageService.requestPermissions();
      if (!hasPermission) {
        return;
      }

      List<File> images = await _imageService.pickMultipleImages();
      _selectedImages.addAll(images);
      notifyListeners();
    } catch (e) {
    } finally {}
  }
}
