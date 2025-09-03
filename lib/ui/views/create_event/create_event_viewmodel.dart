import 'dart:async';
import 'dart:io';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
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
import '../../../models/places.dart';
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
  TextEditingController addressController = TextEditingController();
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
    logger.e(isEventDetailsFormValid);
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
    hexColor = selectedThemeColor.toHex();
    notifyListeners();
  }

  removePerformer(int index) {
    notifyListeners();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _debounceTimer?.cancel();
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
    timeStr = timeStr.trim();

    try {
      // Try parsing with DateFormat first (handles multiple formats automatically)
      DateFormat format12 = DateFormat.jm(); // 12-hour format
      DateFormat format24 = DateFormat.Hm(); // 24-hour format

      DateTime? parsedTime;

      // Try 12-hour format first
      try {
        parsedTime = format12.parse(timeStr);
      } catch (e) {
        // If 12-hour fails, try 24-hour format
        try {
          parsedTime = format24.parse(timeStr);
        } catch (e) {
          // If both fail, throw descriptive error
          throw FormatException('Invalid time format: "$timeStr". '
              'Expected formats: "2:30 PM" (12-hour) or "14:30" (24-hour)');
        }
      }

      // Combine with current date
      final now = DateTime.now();
      final combinedDateTime = DateTime(
        now.year,
        now.month,
        now.day,
        parsedTime.hour,
        parsedTime.minute,
      );

      return combinedDateTime.toUtc().toIso8601String();
    } catch (e) {
      throw FormatException('Failed to parse time "$timeStr": ${e.toString()}');
    }
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

  String hexColor = '';
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
        location: addressController.text,
        flyerUrl: uploadFlyerPictureUrl,
        theme: hexColor,
        genres: [],
        isPrivate: isPrivate,
        ticketPricing: collectTicketPricingData()!,
        guestListEnabled: isRsvP ? false : showGuestList,
        guestListLimit: isRsvP ? 0 : int.parse(eventGuestListController.text),
        longitude: selectedPlaceCoordinates!.longitude ?? 0.0,
        latitude: selectedPlaceCoordinates!.latitude ?? 0.0,
        password: eventPasswordController.text,
        address: eventLocationController.text,
        termsAndConditions: termsController.text,
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

  Color pickerColor = kcPrimaryColor;
  Color currentColor = kcPrimaryColor;

  void changeColor(Color color) {
    pickerColor = color;
    notifyListeners();
  }

  pickColor(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: kcDarkColor,
          title: const Text(
            'Pick a color!',
            style: TextStyle(color: kcWhiteColor),
          ),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: pickerColor,
              onColorChanged: changeColor,
              labelTypes: [],
              pickerAreaHeightPercent: 0.7,
            ),
          ),
          actions: [
            TextButton(
              child: const Text(
                'Done',
                style: TextStyle(color: kcPrimaryColor),
              ),
              onPressed: () {
                currentColor = pickerColor;
                hexColor = currentColor.toHex();
                notifyListeners();

                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  final _placesService = locator<LocationService>();
  final _snackbarService = locator<SnackbarService>();

  List<PlaceModel> _searchResults = [];
  List<PlaceModel> get searchResults => _searchResults;

  PlaceCoordinates? _selectedPlaceCoordinates;
  PlaceCoordinates? get selectedPlaceCoordinates => _selectedPlaceCoordinates;

  String _searchQuery = '';
  String get searchQuery => _searchQuery;

  bool _isSearching = false;
  bool get isSearching => _isSearching;

  bool _isLoadingCoordinates = false;
  bool get isLoadingCoordinates => _isLoadingCoordinates;

  Timer? _debounceTimer;

  void updateSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();

    // Cancel previous timer
    _debounceTimer?.cancel();

    // Start new timer for debounced search
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      if (query.isNotEmpty) {
        searchPlaces(query);
      } else {
        clearSearchResults();
      }
    });
  }

  Future<void> searchPlaces(String query) async {
    if (query.isEmpty) {
      clearSearchResults();
      return;
    }

    _isSearching = true;
    notifyListeners();

    try {
      _searchResults = await _placesService.searchPlaces(query);
      notifyListeners();
    } catch (e) {
      _snackbarService.showSnackbar(
        message: 'Failed to search places: ${e.toString()}',
        duration: const Duration(seconds: 3),
      );
      _searchResults = [];
    } finally {
      _isSearching = false;
      notifyListeners();
    }
  }

  Future<void> selectPlace(PlaceModel place) async {
    _isLoadingCoordinates = true;
    notifyListeners();

    try {
      _selectedPlaceCoordinates =
          await _placesService.getPlaceCoordinates(place.placeId);

      // Clear search results after selection
      clearSearchResults();
      addressController.text = place.description;

      _snackbarService.showSnackbar(
        message: 'Selected: ${place.description}',
        duration: const Duration(seconds: 2),
      );

      notifyListeners();
    } catch (e) {
      _snackbarService.showSnackbar(
        message: 'Failed to get coordinates: ${e.toString()}',
        duration: const Duration(seconds: 3),
      );
    } finally {
      _isLoadingCoordinates = false;
      notifyListeners();
    }
  }

  void clearSearchResults() {
    _searchResults = [];
    notifyListeners();
  }

  void clearSelection() {
    _selectedPlaceCoordinates = null;
    _searchQuery = '';
    clearSearchResults();
    notifyListeners();
  }
}
