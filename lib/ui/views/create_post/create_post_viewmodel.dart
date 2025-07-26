import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:nest/app/app.locator.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.bottomsheets.dart';
import '../../../services/image_service.dart';
import '../../common/app_enums.dart';

class CreatePostViewModel extends BaseViewModel {
  TextEditingController postController = TextEditingController();
  final ImageService _imageService = locator<ImageService>();

  List<File> _selectedImages = [];
  List<File> get selectedImages => _selectedImages;

  bool get hasImages => _selectedImages.isNotEmpty;

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
          await pickImageFromCamera();
          break;
        case ImageSourceType.gallery:
          await pickImageFromGallery();
          break;
        case ImageSourceType.multiple:
          await pickMultipleImages();
          break;
      }
    }
  }

  Future<void> showAddLocationSheet() async {
    SheetResponse? response = await _bottomSheetService.showCustomSheet(
      variant: BottomSheetType.addLocation,
      isScrollControlled: true,
    );

    if (response?.confirmed == true && response?.data != null) {}
  }

  Future<void> showTagPeopleSheet() async {
    SheetResponse? response = await _bottomSheetService.showCustomSheet(
      variant: BottomSheetType.tagPeople,
      isScrollControlled: true,
    );

    if (response?.confirmed == true && response?.data != null) {}
  }

  // Rest of your existing methods...
  Future<void> pickImageFromCamera() async {
    setBusy(true);
    try {
      bool hasPermission = await _imageService.requestPermissions();
      if (!hasPermission) {
        setError('Permission denied');
        return;
      }

      File? image = await _imageService.pickImageFromCamera();
      if (image != null) {
        _selectedImages.add(image);
        notifyListeners();
      }
    } catch (e) {
      setError(e.toString());
    } finally {
      setBusy(false);
    }
  }

  Future<void> pickImageFromGallery() async {
    setBusy(true);
    try {
      bool hasPermission = await _imageService.requestPermissions();
      if (!hasPermission) {
        setError('Permission denied');
        return;
      }

      File? image = await _imageService.pickImageFromGallery();
      if (image != null) {
        _selectedImages.add(image);
        notifyListeners();
      }
    } catch (e) {
      setError(e.toString());
    } finally {
      setBusy(false);
    }
  }

  Future<void> pickMultipleImages() async {
    setBusy(true);
    try {
      bool hasPermission = await _imageService.requestPermissions();
      if (!hasPermission) {
        setError('Permission denied');
        return;
      }

      List<File> images = await _imageService.pickMultipleImages();
      _selectedImages.addAll(images);
      notifyListeners();
    } catch (e) {
      setError(e.toString());
    } finally {
      setBusy(false);
    }
  }

  void removeImage(int index) {
    if (index >= 0 && index < _selectedImages.length) {
      _selectedImages.removeAt(index);
      notifyListeners();
    }
  }

  void clearAllImages() {
    _selectedImages.clear();
    notifyListeners();
  }
}
