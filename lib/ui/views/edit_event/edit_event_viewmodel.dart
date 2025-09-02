import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:nest/models/events.dart';
import 'package:nest/utils/extensions.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../models/create_event.dart';
import '../../../models/ticket_tier.dart';
import '../../common/app_colors.dart';
import '../../common/app_enums.dart';
import '../create_event/create_event_viewmodel.dart';

class EditEventViewModel extends CreateEventViewModel {
  final navigatorKey = GlobalKey<NavigatorState>();
  Event? _originalEvent;
  Event? get originalEvent => _originalEvent;

  bool _hasChanges = false;
  bool get hasChanges => _hasChanges;

  bool _isUpdating = false;
  bool get isUpdating => _isUpdating;

  void initializeWithEvent(Event event) {
    _originalEvent = event;
    _populateFieldsFromEvent(event);
    _trackChanges();
  }

  void _populateFieldsFromEvent(Event event) {
    // Populate basic event details
    eventTitleController.text = event.title;
    descriptionController.text = event.description;
    eventLocationController.text = event.location;

    // Format and set date time
    final startTime = event.startTime;
    final endTime = event.endTime;
    eventDateTimeController.text =
        '${startTime.year}-${startTime.month.toString().padLeft(2, '0')}-${startTime.day.toString().padLeft(2, '0')} '
        '${startTime.hour.toString().padLeft(2, '0')}:${startTime.minute.toString().padLeft(2, '0')}';

    // Set performance time if available
    final startTimeFormatted = TimeOfDay.fromDateTime(startTime);
    final endTimeFormatted = TimeOfDay.fromDateTime(endTime);
    performanceTimeController.text = '$startTimeFormatted – $endTimeFormatted';

    // Set event mode based on ticket pricing
    if (event.ticketPricing.isNotEmpty) {
      final firstTicket = event.ticketPricing.first;
      if (firstTicket.type == 'rsvp') {
        eventMode = EventMode.rsvp;
      } else {
        eventMode = EventMode.paid;
      }
    }

    // Set privacy
    isPrivate = event.isPrivate ?? false;

    // Set flyer URL and theme
    uploadFlyerPictureUrl = event.flyerUrl;
    if (event.theme.isNotEmpty == true) {
      hexColor = event.theme;
      // Try to match with existing theme colors
      _updateThemeSelection(event.theme);
    }

    // Populate ticket tiers
    // _populateTicketTiers(event.ticketPricing);
    //
    // // Set coordinates if available
    // if (event.latitude != 0.0 && event.longitude != 0.0) {
    //   selectedPlaceCoordinates = PlaceCoordinates(
    //     latitude: event.latitude,
    //     longitude: event.longitude, formattedAddress: '',
    //   );
    // }

    notifyListeners();
  }

  void _updateThemeSelection(String hexColor) {
    // Try to find matching theme color index
    for (int i = 0; i < themeColors.length; i++) {
      if (themeColors[i].toHex() == hexColor) {
        selectedThemeIndex = i;
        break;
      }
    }
  }

  void _populateTicketTiers(List<TicketPricing> ticketPricing) {
    // Clear existing tiers
    clearTicketTiers();

    // Add tiers from existing event
    for (final pricing in ticketPricing) {
      final tier = TicketTier(
        id: TicketTier.generateId(),
      );

      tier.tierNameController.text = pricing.name ?? '';
      tier.priceController.text = (pricing.price ?? 0.0).toString();
      tier.quantityController.text = (pricing.limit ?? 0).toString();
      tier.descriptionController.text = pricing.description ?? '';
      // tier.isPasswordProtected =  false;
      // tier.isRequireApproval = pricing.requireApproval ?? false;
      // tier.isTransferable = pricing.transferable ?? true;

      if (tier.isPasswordProtected && pricing.password != null) {
        tier.passwordController.text = pricing.password!;
      }

      ticketTiers.add(tier);
    }

    // Initialize with at least one tier if none exist
    if (ticketTiers.isEmpty) {
      initializeTicketTiers();
    }

    notifyListeners();
  }

  void _trackChanges() {
    // Add listeners to all controllers to track changes
    eventTitleController.addListener(_onFieldChanged);
    descriptionController.addListener(_onFieldChanged);
    eventLocationController.addListener(_onFieldChanged);
    eventDateTimeController.addListener(_onFieldChanged);
    performanceTimeController.addListener(_onFieldChanged);
    websiteController.addListener(_onFieldChanged);
    igController.addListener(_onFieldChanged);
    eventPasswordController.addListener(_onFieldChanged);

    // Track ticket tier changes
    for (final tier in ticketTiers) {
      tier.tierNameController.addListener(_onFieldChanged);
      tier.priceController.addListener(_onFieldChanged);
      tier.quantityController.addListener(_onFieldChanged);
      tier.descriptionController.addListener(_onFieldChanged);
      tier.passwordController.addListener(_onFieldChanged);
    }
  }

  void _onFieldChanged() {
    if (!_hasChanges) {
      _hasChanges = true;
      notifyListeners();
    }
  }

  @override
  void addTicketTier() {
    super.addTicketTier();
    // Add listeners to new tier
    final newTier = ticketTiers.last;
    newTier.tierNameController.addListener(_onFieldChanged);
    newTier.priceController.addListener(_onFieldChanged);
    newTier.quantityController.addListener(_onFieldChanged);
    newTier.descriptionController.addListener(_onFieldChanged);
    newTier.passwordController.addListener(_onFieldChanged);
    _onFieldChanged();
  }

  @override
  void removeTicketTier(String tierId) {
    super.removeTicketTier(tierId);
    _onFieldChanged();
  }

  @override
  void togglePaidTickets() {
    super.togglePaidTickets();
    _onFieldChanged();
  }

  @override
  void togglePrivate() {
    super.togglePrivate();
    _onFieldChanged();
  }

  Future<void> updateEvent() async {
    if (_originalEvent == null) {
      locator<SnackbarService>().showSnackbar(
        message: 'Original event data not found',
        duration: const Duration(seconds: 3),
      );
      return;
    }

    setBusy(true);
    _isUpdating = true;

    try {
      // Validate forms
      if (!isEventDetailsFormValid || !isEventVisualsFormValid) {
        locator<SnackbarService>().showSnackbar(
          message: 'Please fill in all required fields',
          duration: const Duration(seconds: 3),
        );
        return;
      }

      // Validate ticket tiers if not RSVP
      if (!isRsvP && !validateTicketTiers()) {
        locator<SnackbarService>().showSnackbar(
          message: 'Please complete all ticket tier information',
          duration: const Duration(seconds: 3),
        );
        return;
      }

      // Parse performance times
      final times = performanceTimeController.text.split('–');
      if (times.length != 2) {
        locator<SnackbarService>().showSnackbar(
          message: 'Please set valid performance times',
          duration: const Duration(seconds: 3),
        );
        return;
      }

      final startTime = parseTimeOnly(times.first.trim());
      final endTime = parseTimeOnly(times.last.trim());

      // Create update request
      final updateRequest = UpdateEventRequest(
        id: _originalEvent!.id,
        description: descriptionController.text.trim(),
        title: eventTitleController.text.trim(),
        endTime: endTime,
        startTime: startTime,
        location: addressController.text.trim(),
        flyerUrl: uploadFlyerPictureUrl.isNotEmpty
            ? uploadFlyerPictureUrl
            : _originalEvent!.flyerUrl,
        theme: hexColor.isNotEmpty ? hexColor : _originalEvent!.theme,
        genres: [], // You might want to implement genre selection
        isPrivate: isPrivate,
        ticketPricing: collectTicketPricingData(),
        guestListEnabled: isRsvP ? false : showGuestList,
        guestListLimit:
            isRsvP ? 0 : int.tryParse(eventGuestListController.text) ?? 0,
        longitude:
            selectedPlaceCoordinates?.longitude ?? _originalEvent!.longitude,
        latitude:
            selectedPlaceCoordinates?.latitude ?? _originalEvent!.latitude,
        password: isPrivate ? eventPasswordController.text.trim() : null,
        address: eventLocationController.text.trim(),
        termsAndConditions: termsController.text.trim(),
      );

      logger.w('Update request: ${updateRequest.toJson()}');

      final response = await eventService.updateEvent(
        eventId: _originalEvent!.id,
        requestBody: updateRequest,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        navigationService.back(result: true);
        locator<SnackbarService>().showSnackbar(
          message: 'Event updated successfully',
          duration: const Duration(seconds: 3),
        );
        logger.i('Event updated successfully');
      } else {
        throw Exception(response.message ?? 'Failed to update event');
      }
    } catch (e, s) {
      logger.e('Failed to update event:', e, s);
      locator<SnackbarService>().showSnackbar(
        message: 'Failed to update event: $e',
        duration: const Duration(seconds: 3),
      );
    } finally {
      setBusy(false);
      _isUpdating = false;
    }
  }

  Future<void> showUnsavedChangesDialog(BuildContext context) async {
    if (!_hasChanges) {
      navigationService.back();
      return;
    }

    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: kcDarkGreyColor,
        title: const Text(
          'Unsaved Changes',
          style: TextStyle(color: kcWhiteColor),
        ),
        content: const Text(
          'You have unsaved changes. Are you sure you want to leave?',
          style: TextStyle(color: kcSubtitleColor),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text(
              'Cancel',
              style: TextStyle(color: kcGreyColor),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text(
              'Leave',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );

    if (result == true) {
      navigationService.back();
    }
  }

  @override
  Future<void> previousPage() async {
    if (!isFirstPage) {
      await super.previousPage();
    } else {
      if (_hasChanges) {
        await showUnsavedChangesDialog(navigatorKey.currentContext!);
      } else {
        navigationService.back();
      }
    }
  }

  @override
  void dispose() {
    // Remove listeners before disposing
    eventTitleController.removeListener(_onFieldChanged);
    descriptionController.removeListener(_onFieldChanged);
    eventLocationController.removeListener(_onFieldChanged);
    eventDateTimeController.removeListener(_onFieldChanged);
    performanceTimeController.removeListener(_onFieldChanged);
    websiteController.removeListener(_onFieldChanged);
    igController.removeListener(_onFieldChanged);
    eventPasswordController.removeListener(_onFieldChanged);

    for (final tier in ticketTiers) {
      tier.tierNameController.removeListener(_onFieldChanged);
      tier.priceController.removeListener(_onFieldChanged);
      tier.quantityController.removeListener(_onFieldChanged);
      tier.descriptionController.removeListener(_onFieldChanged);
      tier.passwordController.removeListener(_onFieldChanged);
    }

    super.dispose();
  }
}

// Add this to your create_event.dart models file
class UpdateEventRequest extends CreateEventRequest {
  final int id;

  UpdateEventRequest({
    required this.id,
    required String description,
    required String title,
    required String endTime,
    required String startTime,
    required String location,
    required String flyerUrl,
    required String? theme,
    required List<String> genres,
    required bool isPrivate,
    required List<TicketPricing>? ticketPricing,
    required bool guestListEnabled,
    required int guestListLimit,
    required double longitude,
    required double latitude,
    required String? password,
    required String address,
    required String termsAndConditions,
  }) : super(
          description: description,
          title: title,
          endTime: endTime,
          startTime: startTime,
          location: location,
          flyerUrl: flyerUrl,
          theme: theme!,
          genres: genres,
          isPrivate: isPrivate,
          ticketPricing: ticketPricing!,
          guestListEnabled: guestListEnabled,
          guestListLimit: guestListLimit,
          longitude: longitude,
          latitude: latitude,
          password: password,
          address: address,
          termsAndConditions: termsAndConditions,
        );

  @override
  Map<String, dynamic> toJson() {
    final json = super.toJson();
    json['id'] = id;
    return json;
  }
}
