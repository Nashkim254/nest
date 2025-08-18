import 'dart:io';

import 'package:flutter/material.dart';
import 'package:nest/models/dj_model.dart';
import 'package:nest/ui/common/app_colors.dart';
import 'package:nest/ui/common/app_enums.dart';
import 'package:nest/ui/common/app_strings.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.bottomsheets.dart';
import '../../../app/app.locator.dart';
import '../../../models/page_item.dart';
import '../../../services/image_service.dart';

class CreateEventViewModel extends BaseViewModel {
  final PageController _pageController = PageController();
  PageController get pageController => _pageController;
  TextEditingController descriptionController = TextEditingController();
  TextEditingController performerController = TextEditingController();
  TextEditingController performanceTimeController = TextEditingController();
  TextEditingController igController = TextEditingController();
  bool _max1PerUser = false;
  bool isRequireApproval = false;
  bool isPasswordProtected = false;
  bool isPerformerImageLoading = false;
  bool isTransferable = false;
  toggleRequireApproval() {
    isRequireApproval = !isRequireApproval;
    notifyListeners();
  }

  togglePasswordProtected() {
    isPasswordProtected = !isPasswordProtected;
    notifyListeners();
  }

  toggleTransferable() {
    isTransferable = !isTransferable;
    notifyListeners();
  }

  bool get isMax1PerUser => _max1PerUser;
  set isMax1PerUser(bool value) {
    _max1PerUser = value;
    notifyListeners();
  }

  int _currentPage = 0;
  int get currentPage => _currentPage;
  EventMode _eventMode = EventMode.rsvp;
  EventMode get eventMode => _eventMode;
  set eventMode(EventMode mode) {
    _eventMode = mode;
    notifyListeners();
  }

  bool isPrivate = false;
  bool get isRsvP => _eventMode == EventMode.rsvp;
  bool get isPaid => _eventMode == EventMode.paid;

  togglePaidTickets() {
    _eventMode = _eventMode == EventMode.paid ? EventMode.rsvp : EventMode.paid;
    notifyListeners();
  }

  showPerformerImageSourceSheet() {}
  togglePrivate() {
    isPrivate = !isPrivate;
    notifyListeners();
  }

  final List<PageItem> _items = [
    PageItem(
      title: "Create Event",
    ),
    PageItem(
      title: "Ticket Setup",
    ),
    PageItem(
      title: "Event Visuals",
    ),
  ];
  List<PageItem> get items => _items;
  int get itemCount => _items.length;
  PageItem get currentItem => _items[_currentPage];
  bool get isFirstPage => _currentPage == 0;
  bool get isLastPage => _currentPage == _items.length - 1;
  double get progress => (_currentPage + 1) / _items.length;

  void onPageChanged(int index) {
    _currentPage = index;
    notifyListeners();
  }

  Future<void> nextPage() async {
    if (!isLastPage) {
      await _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> previousPage() async {
    if (!isFirstPage) {
      await _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> goToPage(int index) async {
    await _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

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

  void onFinishPressed() {
    setBusy(true);

    // Simulate some async operation
    Future.delayed(const Duration(seconds: 1), () {
      setBusy(false);
    });
  }

  List<Color> get themeColors {
    return [
      kcPrimaryColor,
      kcSecondaryColor,
      kcWhiteColor,
      kcDisableIconColor,
    ];
  }

  int selectedThemeIndex = 0;
  selectThemeColor(Color color) {
    notifyListeners();
  }

  selectThemeColorByIndex(int index) {
    selectedThemeIndex = index;
    notifyListeners();
  }

  List<DJ> performers = [
    DJ(
        id: '1',
        name: 'DJ Neon',
        imageUrl: avatar,
        web: 'https://djneon.com',
        ig: '@djneon',
        time: '10:00 PM – 11:30 PM'),
    DJ(
        id: '2',
        name: 'DJ Groove',
        imageUrl: avatar,
        web: 'https://djgroove.com',
        ig: '@djgroove',
        time: '11:30 PM – 1:00 AM'),
    // Add more sample DJs as needed
  ];

  removePerformer(int index) {
    performers.removeAt(index);
    notifyListeners();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}
