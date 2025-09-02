import 'package:nest/services/shared_preferences_service.dart';

import '../abstractClasses/abstract_class.dart';
import '../app/app.locator.dart';
import '../models/api_exceptions.dart';
import '../models/create_event.dart';
import '../ui/common/app_urls.dart';
import '../ui/views/edit_event/edit_event_viewmodel.dart';
import '../ui/views/ticket_scanning/ticket_scanning_viewmodel.dart';

class EventService {
  final IApiService _apiService = locator<IApiService>();
  final prefsService = locator<SharedPreferencesService>();

  Future getMyEvents({required int page, required int size}) async {
    try {
      final response = await _apiService.get(
        AppUrls.myEventsUrl,
        queryParameters: {
          'page': page,
          'page_size': size,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response;
      } else {
        throw ApiException(response.message ?? 'Failed to create user');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future getSingleEvent({required int id, required String password}) async {
    try {
      final response = await _apiService.get(
        '${AppUrls.events}/$id',
        queryParameters: {
          'id': id,
        },
        headers: {
          'X-Event-Password': password,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response;
      } else {
        throw ApiException(response.message ?? 'Failed to create user');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future updateEvent(
      {required int eventId, required UpdateEventRequest requestBody}) async {
    try {
      final response = await _apiService.put(
        '${AppUrls.updateEvent}/$eventId',
        data: requestBody.toJson(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response;
      } else {
        throw ApiException(response.message ?? 'Failed to create user');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future searchEvents(
      {required String query, required int page, required int size}) async {
    try {
      final response = await _apiService.get(
        AppUrls.searchEventsUrl,
        queryParameters: {
          'q': query,
          'page': page,
          'page_size': size,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response;
      } else {
        throw ApiException(response.message ?? 'Failed to create user');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future getEventsNearMe({required double lat, required double lng}) async {
    print('Fetching events near: lat=$lat, lng=$lng');
    try {
      final response = await _apiService.get(
        AppUrls.getEventsNearbyUrl,
        queryParameters: {
          'lat': lat,
          'lng': lng,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response;
      } else {
        throw ApiException(response.message ?? 'Failed to create user');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future createEvent({required CreateEventRequest requestBody}) async {
    try {
      final response = await _apiService.post(
        AppUrls.createEvent,
        data: requestBody.toJson(),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response;
      } else {
        throw ApiException(response.message ?? 'Failed to create user');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future validateTicketPassword(
      {required String password,
      required int eventId,
      required int ticketId}) async {
    try {
      final response = await _apiService.post(
        '${AppUrls.validateTicketPassword}/$eventId/tickets/$ticketId/validate-password',
        data: {'password': password},
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response;
      } else {
        throw ApiException(response.message ?? 'Failed to create user');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future createBooking({
    required int eventId,
    required Map<String, dynamic> requestBody,
  }) async {
    try {
      final response = await _apiService.post(
          '${AppUrls.validateTicketPassword}/$eventId/bookings',
          data: requestBody);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return response;
      } else {
        throw ApiException(response.message ?? 'Failed to create user');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<ScanResult> validateTicket({
    required String qrData,
    int? eventId,
  }) async {
    try {
      // Parse QR code data
      final ticketData = qrData.trim();

      // Make API call to validate ticket
      final response = await _apiService.post(
          'validateticket endpoint here', // Replace with actual endpoint
          data: ticketData);
      if (response.statusCode == 200) {
        return ScanResult(
          isValid: true,
          message: 'Ticket is valid',
        );
      } else if (response.statusCode == 404) {
        return ScanResult(
          isValid: false,
          message: 'Ticket not found',
          errorCode: 'NOT_FOUND',
        );
      } else if (response.statusCode == 409) {
        return ScanResult(
          isValid: false,
          message: 'Ticket already used',
          errorCode: 'ALREADY_USED',
        );
      } else {
        return ScanResult(
          isValid: false,
          message: 'Validation failed: ${response.statusCode}',
          errorCode: 'VALIDATION_ERROR',
        );
      }
    } catch (e) {
      return ScanResult(
        isValid: false,
        message: 'Network error: ${e.toString()}',
        errorCode: 'NETWORK_ERROR',
      );
    }
  }
}
