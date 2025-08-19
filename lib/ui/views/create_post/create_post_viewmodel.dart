import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:nest/app/app.locator.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.bottomsheets.dart';
import '../../../services/file_service.dart';
import '../../../services/image_service.dart';
import '../../common/app_enums.dart';

class CreatePostViewModel extends ReactiveViewModel {
  TextEditingController postController = TextEditingController();
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

  void removeImage(int index) {
    if (index >= 0 && index < selectedImages.length) {
      selectedImages.removeAt(index);
      notifyListeners();
    }
  }

  void clearAllImages() {
    selectedImages.clear();
    notifyListeners();
  }

  @override
  List<ListenableServiceMixin> get listenableServices => [];
}
