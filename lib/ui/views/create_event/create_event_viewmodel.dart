import 'dart:io';
import 'package:logger/logger.dart';
import 'package:path/path.dart' as p;
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
import '../../../services/file_service.dart';
import '../../../services/global_service.dart';

class CreateEventViewModel extends ReactiveViewModel {
  final PageController _pageController = PageController();
  PageController get pageController => _pageController;
  TextEditingController descriptionController = TextEditingController();
  TextEditingController performerController = TextEditingController();
  TextEditingController performanceTimeController = TextEditingController();
  TextEditingController igController = TextEditingController();
  TextEditingController sponsorController = TextEditingController();
  final globalService = locator<GlobalService>();
  final navigationService = locator<NavigationService>();
  bool _max1PerUser = false;
  bool isRequireApproval = false;
  bool isPasswordProtected = false;
  bool isPerformerImageLoading = false;
  bool isTransferable = false;
  String uploadProfilePictureUrl = '';
  bool scheduledTicketDrop = true;
  bool showGuestList = true;
  bool showOnExplorePage = true;
  bool passwordProtected = true;
  Logger logger = Logger();
  final int _totalPages = 3;
  int get totalPages => _totalPages;
  List<String> sponsors = [];

  //remove sponsor
  removeSponsor(String sponsor) {
    sponsors.remove(sponsor);
    notifyListeners();
  }

  //add sponsor
  addSponsor(String sponsor) {
    if (sponsor.isNotEmpty && !sponsors.contains(sponsor)) {
      sponsors.add(sponsor);
      sponsorController.clear();
      notifyListeners();
    }
  }

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
      if (selectedImages.isNotEmpty) {
        await getProfileUploadUrl();
      }
    }
  }

  String getFileExtension(File file) {
    return p.extension(file.path); // includes the dot, e.g. ".jpg"
  }

  Future getProfileUploadUrl() async {
    setBusy(true);
    try {
      final response = await globalService
          .uploadFileGetURL(getFileExtension(selectedImages.first));
      if (response.statusCode == 200 && response.data != null) {
        uploadProfilePictureUrl = response.data['upload_url'];
        logger.i('upload url: ${response.data}');
      } else {
        throw Exception(response.message ?? 'Failed to load upload url:');
      }
    } catch (e, s) {
      logger.e('Failed to load upload url:', e, s);
      locator<SnackbarService>().showSnackbar(
        message: 'Failed to upload url:: $e',
        duration: const Duration(seconds: 3),
      );
    } finally {
      setBusy(false);
    }
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
