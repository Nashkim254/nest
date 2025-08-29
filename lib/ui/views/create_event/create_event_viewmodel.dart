import 'dart:io';
import 'package:geolocator/geolocator.dart';
import 'package:logger/logger.dart';
import 'package:nest/services/event_service.dart';
import 'package:nest/utils/extensions.dart';
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
import '../../../models/create_event.dart';
import '../../../models/page_item.dart';
import '../../../models/ticket_tier.dart';
import '../../../services/file_service.dart';
import '../../../services/global_service.dart';
import '../../../services/location_service.dart';
import 'package:intl/intl.dart';

class CreateEventViewModel extends ReactiveViewModel {
  final PageController _pageController = PageController();
  PageController get pageController => _pageController;
  TextEditingController descriptionController = TextEditingController();
  TextEditingController performerController = TextEditingController();
  TextEditingController performanceTimeController = TextEditingController();
  TextEditingController websiteController = TextEditingController();
  TextEditingController igController = TextEditingController();
  TextEditingController sponsorController = TextEditingController();
  TextEditingController termsController = TextEditingController();
  final globalService = locator<GlobalService>();
  final eventService = locator<EventService>();
  final locationService = locator<LocationService>();
  final navigationService = locator<NavigationService>();
  bool _max1PerUser = false;
  bool isRequireApproval = false;
  bool isPasswordProtected = false;
  bool isPerformerImageLoading = false;
  bool isTransferable = false;
  String uploadFlyerPictureUrl = '';
  File? flyerImage;
  File? performerImage;
  List<File> galleryImage = [];
  String performerPictureUrl = '';
  List<String> galleryImageUrls = [];
  bool scheduledTicketDrop = true;
  bool showGuestList = true;
  bool showOnExplorePage = true;
  bool passwordProtected = true;
  bool isTermsOpen = false;
  toggleTermsOpen() {
    isTermsOpen = !isTermsOpen;
    notifyListeners();
  }
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

  bool get isMax1PerUser => _max1PerUser;
  set isMax1PerUser(bool value) {
    _max1PerUser = value;
    notifyListeners();
  }

  final fileService = locator<FileService>();

  List<File> get selectedImages => fileService.selectedImages;

  bool get hasImages => selectedImages.isNotEmpty;

  final _bottomSheetService = locator<BottomSheetService>();

  Future<void> showImageSourceSheet(String type) async {
    SheetResponse? response = await _bottomSheetService.showCustomSheet(
      variant: BottomSheetType.imageSource,
      isScrollControlled: true,
    );

    if (response?.confirmed == true && response?.data != null) {
      ImageSourceType sourceType = response!.data as ImageSourceType;

      switch (sourceType) {
        case ImageSourceType.camera:
          await fileService.pickImageFromCamera(FileType.image);
          break;
        case ImageSourceType.gallery:
          await fileService.pickImageFromGallery();
          break;
        case ImageSourceType.multiple:
          await fileService.pickMultipleImages();
          break;
      }
      if (selectedImages.isNotEmpty) {
        await getFileUploadUrl(type);
      }
    }
  }

  String getFileExtension(File file) {
    return p.extension(file.path); // includes the dot, e.g. ".jpg"
  }

  Future getFileUploadUrl(String type) async {
    setBusy(true);
    try {
      String fileExtension = getFileExtension(selectedImages.first);
      logger.wtf(fileExtension);
      final response = await globalService.uploadFileGetURL(fileExtension,
          folder: 'profile');
      if (response.statusCode == 200 && response.data != null) {
        if (type == 'flyer') {
          flyerImage = selectedImages.first;
          uploadFlyerPictureUrl = response.data['url'];
          final result = await globalService.uploadFile(
            response.data['upload_url'],
            flyerImage!,
          );
          if (result.statusCode == 200 || result.statusCode == 201) {
            fileService.clearSelectedImages();
          }
        } else if (type == 'performer') {
          performerImage = selectedImages.first;
          performerPictureUrl = response.data['url'];
          await globalService.uploadFile(
            response.data['upload_url'],
            performerImage!,
          );
        } else if (type == 'gallery') {
          galleryImage = selectedImages;
          galleryImageUrls.add(response.data['url']);
          for (var image in galleryImage) {
            await globalService.uploadFile(
              response.data['upload_url'],
              image,
            );
          }
        }

        logger.i('upload url: ${response.data}');
        notifyListeners();
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
    if (isFirstPage && isEventDetailsFormValid) {
      await _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else if (!isFirstPage && !isLastPage && isTicketSetupFormValid) {
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
    } else if (isFirstPage) {
      navigationService.back();
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

  Color get selectedThemeColor {
    if (selectedThemeIndex < themeColors.length) {
      return themeColors[selectedThemeIndex];
    }
    return themeColors[0]; // Default to first color
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
    clearTicketTiers();
    super.dispose();
  }

  selectDateTime(BuildContext context) async {
    DateTime? selectedDateTime = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (selectedDateTime != null) {
      TimeOfDay? selectedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(selectedDateTime),
      );
      if (selectedTime != null) {
        eventDateTimeController.text =
            '${selectedDateTime.year}-${selectedDateTime.month}-${selectedDateTime.day} ${selectedTime.hour}:${selectedTime.minute}';
      }
    }
  }

  bool isPasswordProtectedEnabled = true;
  togglePasswordVisibility() {
    isPasswordProtectedEnabled = !isPasswordProtectedEnabled;
    notifyListeners();
  }

  final TextEditingController eventTitleController = TextEditingController();
  final TextEditingController eventDateTimeController = TextEditingController();
  final TextEditingController eventLocationController = TextEditingController();
  final TextEditingController eventPasswordController = TextEditingController();
  final TextEditingController eventGuestListController =
      TextEditingController();
  final TextEditingController guestListDescriptionController =
      TextEditingController();
  final eventDetailsKey = GlobalKey<FormState>();
  final ticketSetupKey = GlobalKey<FormState>();
  final eventVisualsFormKey = GlobalKey<FormState>();
  bool get isEventDetailsFormValid =>
      eventDetailsKey.currentState?.validate() ?? false;
  bool get isTicketSetupFormValid =>
      ticketSetupKey.currentState?.validate() ?? false;
  bool get isEventVisualsFormValid =>
      eventVisualsFormKey.currentState?.validate() ?? false;

  String parseTimeOnly(String timeStr) {
    final timeRegex =
        RegExp(r'(\d{1,2}):(\d{2})\s*(AM|PM)', caseSensitive: false);
    final match = timeRegex.firstMatch(timeStr.trim());

    if (match != null) {
      int hour = int.parse(match.group(1)!);
      int minute = int.parse(match.group(2)!);
      String amPm = match.group(3)!.toUpperCase();

      if (amPm == 'PM' && hour != 12) hour += 12;
      if (amPm == 'AM' && hour == 12) hour = 0;
      final formatter = DateFormat("yyyy-MM-ddTHH:mm:ss.SSSSSS");
      // use this formatter to parse the time
      var time = DateTime.now().copyWith(
        hour: hour,
        minute: minute,
      );
      // If you need to format it back to a string, you can use:
      String formattedTime = time.toUtc().toIso8601String();
      // For example, if you want to return a DateTime object:

      return formattedTime;
    }

    throw FormatException('Invalid time format: $timeStr');
  }

  Position? coordinates;
  getCurrentLocation() async {
    setBusy(true);
    try {
      coordinates = await locationService.getCoordinatesFromCurrentLocation();
    } catch (e) {
      locator<DialogService>().showDialog(
        title: 'Error',
        description: 'Could not get current location. Please try again later.',
      );
    } finally {
      setBusy(false);
    }
  }

  Future createEvent() async {
    setBusy(true);
    if (!isEventDetailsFormValid &&
        !isTicketSetupFormValid &&
        !isEventVisualsFormValid) {
      locator<SnackbarService>().showSnackbar(
        message: 'Please fill in all required fields',
        duration: const Duration(seconds: 3),
      );
      setBusy(false);
      return;
    }
    try {
      final times = performanceTimeController.text.split('–');
      final startTime = parseTimeOnly(times.first);
      final endTime = parseTimeOnly(times.last);

      CreateEventRequest request = CreateEventRequest(
        description: descriptionController.text,
        title: eventTitleController.text,
        endTime: endTime,
        startTime: startTime,
        location: eventLocationController.text,
        flyerUrl: uploadFlyerPictureUrl,
        theme: selectedThemeColor.toHex(),
        genres: [],
        isPrivate: isPrivate,
        ticketPricing: collectTicketPricingData()!,
        guestListEnabled: isRsvP ? false : showGuestList,
        guestListLimit:isRsvP ? 0 : int.parse(eventGuestListController.text),
        longitude: coordinates!.longitude ?? 0.0,
        latitude: coordinates!.latitude ?? 0.0,
        password: eventPasswordController.text,
        address: eventLocationController.text,
      );
      logger.w(request.toJson());
      final response = await eventService.createEvent(requestBody: request);
      if (response.statusCode == 200 || response.statusCode == 201) {
        navigationService.back(result: true);
        locator<SnackbarService>().showSnackbar(
          message: 'Event created successfully',
          duration: const Duration(seconds: 3),
        );
        logger.i('Event created successfully');
      } else {
        throw Exception(response.message ?? 'Failed to create event');
      }
    } catch (e, s) {
      logger.e('Failed to create event:', e, s);
      locator<SnackbarService>().showSnackbar(
        message: 'Failed to create event: $e',
        duration: const Duration(seconds: 3),
      );
    } finally {
      setBusy(false);
    }
  }

  // Ticket tier management
  List<TicketTier> _ticketTiers = [];
  List<TicketTier> get ticketTiers => _ticketTiers;

  // Initialize with one default ticket tier
  void initializeTicketTiers() {
    if (_ticketTiers.isEmpty) {
      addTicketTier();
    }
  }

  // Add a new ticket tier
  void addTicketTier() {
    final newTier = TicketTier(
      id: TicketTier.generateId(),
    );
    _ticketTiers.add(newTier);
    notifyListeners();
  }

  // Remove a ticket tier
  void removeTicketTier(String tierId) {
    final tierIndex = _ticketTiers.indexWhere((tier) => tier.id == tierId);
    if (tierIndex != -1) {
      // Dispose controllers before removing
      _ticketTiers[tierIndex].dispose();
      _ticketTiers.removeAt(tierIndex);
      notifyListeners();
    }
  }

  // Toggle require approval for specific tier
  void toggleRequireApproval(String tierId) {
    final tier = _ticketTiers.firstWhere((tier) => tier.id == tierId);
    tier.isRequireApproval = !tier.isRequireApproval;
    notifyListeners();
  }

  // Toggle password protection for specific tier
  void togglePasswordProtected(String tierId) {
    final tier = _ticketTiers.firstWhere((tier) => tier.id == tierId);
    tier.isPasswordProtected = !tier.isPasswordProtected;
    notifyListeners();
  }

  // Toggle transferable for specific tier
  void toggleTransferable(String tierId) {
    final tier = _ticketTiers.firstWhere((tier) => tier.id == tierId);
    tier.isTransferable = !tier.isTransferable;
    notifyListeners();
  }

  // Validate all ticket tiers
  // bool validateTicketTiers() {
  //   for (final tier in _ticketTiers) {
  //     if (tier.tierNameController.text.isEmpty ||
  //         tier.priceController.text.isEmpty ||
  //         tier.quantityController.text.isEmpty) {
  //       return false;
  //     }
  //
  //     // Validate price is a valid number
  //     if (double.tryParse(tier.priceController.text) == null) {
  //       return false;
  //     }
  //
  //     // Validate quantity is a valid number
  //     if (int.tryParse(tier.quantityController.text) == null) {
  //       return false;
  //     }
  //   }
  //   return true;
  // }

  // Get all ticket tier data
  List<Map<String, dynamic>> getTicketTierData() {
    return _ticketTiers.map((tier) => tier.toMap()).toList();
  }

  // Clear all ticket tiers (call this when disposing)
  void clearTicketTiers() {
    for (final tier in _ticketTiers) {
      tier.dispose();
    }
    _ticketTiers.clear();
  }

  TicketPricing _convertToTicketPricing(TicketTier tier) {
    return TicketPricing(
      type: isRsvP ? 'rsvp' : "paid", // or "free" based on your logic
      name: tier.tierNameController.text.trim(),
      price: double.tryParse(tier.priceController.text.trim()) ?? 0.0,
      limit: int.tryParse(tier.quantityController.text.trim()) ?? 0,
      available: true, // Set based on your business logic
      password:
          tier.isPasswordProtected ? tier.passwordController.text.trim() : null,
      description: tier.descriptionController.text.trim().isEmpty
          ? null
          : tier.descriptionController.text.trim(),
    );
  }

  // Get all ticket pricing data
  List<TicketPricing> getTicketPricingList() {
    return _ticketTiers.map((tier) => _convertToTicketPricing(tier)).toList();
  }

  // Get ticket pricing as JSON list (for API calls)
  List<Map<String, dynamic>> getTicketPricingJson() {
    return getTicketPricingList().map((pricing) => pricing.toJson()).toList();
  }

  // Validate and collect data
  List<TicketPricing>? collectTicketPricingData() {
    // First validate all tiers
    if (!validateTicketTiers()) {
      return null; // Validation failed
    }

    // Convert to TicketPricing models
    List<TicketPricing> pricingList = [];

    for (final tier in _ticketTiers) {
      try {
        final pricing = _convertToTicketPricing(tier);
        pricingList.add(pricing);
      } catch (e) {
        print('Error converting tier ${tier.id} to TicketPricing: $e');
        return null; // Conversion failed
      }
    }

    return pricingList;
  }

  // Enhanced validation method
  bool validateTicketTiers() {
    for (final tier in _ticketTiers) {
      // Check required fields
      if (tier.tierNameController.text.trim().isEmpty) {
        print('Tier name is required for tier ${tier.id}');
        return false;
      }

      if (tier.priceController.text.trim().isEmpty) {
        print('Price is required for tier ${tier.id}');
        return false;
      }

      if (tier.quantityController.text.trim().isEmpty) {
        print('Quantity is required for tier ${tier.id}');
        return false;
      }

      // Validate price is a valid number and non-negative
      final price = double.tryParse(tier.priceController.text.trim());
      if (price == null || price < 0) {
        print('Invalid price for tier ${tier.id}');
        return false;
      }

      // Validate quantity is a valid number and positive
      final quantity = int.tryParse(tier.quantityController.text.trim());
      if (quantity == null || quantity <= 0) {
        print('Invalid quantity for tier ${tier.id}');
        return false;
      }

      // Validate password if password protection is enabled
      if (tier.isPasswordProtected &&
          tier.passwordController.text.trim().isEmpty) {
        print(
            'Password is required when password protection is enabled for tier ${tier.id}');
        return false;
      }
    }
    return true;
  }

  showTimeRangePicker(BuildContext context) async {
//e.g., 10:00 PM – 11:30 PM
    TimeOfDay? startTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (startTime != null) {
      TimeOfDay? endTime = await showTimePicker(
        context: context,
        initialTime: startTime.replacing(hour: startTime.hour + 1),
      );
      if (endTime != null) {
        String formattedStart = startTime.format(context);
        String formattedEnd = endTime.format(context);
        performanceTimeController.text =
            '$formattedStart – $formattedEnd'; // e.g., 10:00 PM – 11:30 PM
      }
    }
  }
}
