import 'dart:convert';
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
      // Parse QR code data to extract ticket ID
      final ticketId = _extractTicketId(qrData);
      
      if (ticketId == null) {
        return ScanResult(
          isValid: false,
          message: 'Invalid QR code format',
          errorCode: 'INVALID_QR_FORMAT',
        );
      }
      
      // Make API call to validate ticket using ticket ID in URL
      final endpoint = '${AppUrls.admin}/$ticketId/validate';
      
      final response = await _apiService.post(endpoint);

      // Handle response
      return _handleValidationResponse(response);
    } catch (e) {
      return ScanResult(
        isValid: false,
        message: 'Network error: ${e.toString()}',
        errorCode: 'NETWORK_ERROR',
      );
    }
  }

  // Extract ticket ID from QR code data
  String? _extractTicketId(String qrData) {
    try {
      final trimmedData = qrData.trim();
      
      // Try to decode base64 first (your backend uses base64-encoded JSON)
      try {
        final decodedBytes = base64Decode(trimmedData);
        final decodedString = utf8.decode(decodedBytes);
        final jsonData = jsonDecode(decodedString) as Map<String, dynamic>;
        return jsonData['ticket_id']?.toString() ?? 
               jsonData['id']?.toString() ??
               jsonData['ticketId']?.toString();
      } catch (e) {
        // Not base64, try other formats
      }
      
      // Try to parse as direct JSON
      if (trimmedData.startsWith('{')) {
        try {
          final jsonData = jsonDecode(trimmedData) as Map<String, dynamic>;
          return jsonData['ticket_id']?.toString() ?? 
                 jsonData['id']?.toString() ??
                 jsonData['ticketId']?.toString();
        } catch (e) {
          return null;
        }
      }
      
      // Check if it's a numeric ID
      if (RegExp(r'^\d+$').hasMatch(trimmedData)) {
        return trimmedData;
      }
      
      // Try to extract ID from URL pattern (e.g., "ticket/123" or "tickets/123")
      final urlMatch = RegExp(r'tickets?[/:](\d+)').firstMatch(trimmedData);
      if (urlMatch != null) {
        return urlMatch.group(1);
      }
      
      // Try to extract from other common patterns
      final idMatch = RegExp(r'id[=:](\d+)').firstMatch(trimmedData.toLowerCase());
      if (idMatch != null) {
        return idMatch.group(1);
      }
      
      return null;
    } catch (e) {
      return null;
    }
  }


  // Handle API response and convert to ScanResult
  ScanResult _handleValidationResponse(dynamic response) {
    try {
      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data;
        
        // Extract ticket information from response
        final ticketInfo = data != null ? _parseTicketInfo(data) : null;
        
        return ScanResult(
          isValid: true,
          message: data['message'] ?? 'Ticket validated successfully',
          ticketInfo: ticketInfo,
        );
      } else if (response.statusCode == 404) {
        return ScanResult(
          isValid: false,
          message: response.data?['message'] ?? 'Ticket not found',
          errorCode: 'TICKET_NOT_FOUND',
        );
      } else if (response.statusCode == 409) {
        return ScanResult(
          isValid: false,
          message: response.data?['message'] ?? 'Ticket already scanned',
          errorCode: 'ALREADY_SCANNED',
        );
      } else if (response.statusCode == 400) {
        return ScanResult(
          isValid: false,
          message: response.data?['message'] ?? 'Invalid ticket data',
          errorCode: 'INVALID_TICKET',
        );
      } else if (response.statusCode == 403) {
        return ScanResult(
          isValid: false,
          message: response.data?['message'] ?? 'Access denied - ticket not valid for this event',
          errorCode: 'ACCESS_DENIED',
        );
      } else if (response.statusCode == 410) {
        return ScanResult(
          isValid: false,
          message: response.data?['message'] ?? 'Ticket has expired',
          errorCode: 'TICKET_EXPIRED',
        );
      } else {
        return ScanResult(
          isValid: false,
          message: 'Validation failed: ${response.statusMessage ?? 'Unknown error'}',
          errorCode: 'VALIDATION_ERROR',
        );
      }
    } catch (e) {
      return ScanResult(
        isValid: false,
        message: 'Error processing response: ${e.toString()}',
        errorCode: 'RESPONSE_ERROR',
      );
    }
  }

  // Parse ticket information from API response
  TicketInfo? _parseTicketInfo(Map<String, dynamic> data) {
    try {
      final ticket = data['ticket'] ?? data;
      
      return TicketInfo(
        ticketId: ticket['ticket_id']?.toString() ?? ticket['id']?.toString() ?? 'Unknown',
        holderName: ticket['holder_name']?.toString() ?? ticket['name']?.toString() ?? 'Unknown',
        ticketType: ticket['ticket_type']?.toString() ?? ticket['type']?.toString() ?? 'General',
        eventName: ticket['event_name']?.toString() ?? ticket['event']?.toString() ?? 'Unknown Event',
        seatNumber: ticket['seat_number']?.toString() ?? ticket['seat']?.toString(),
        scanTime: DateTime.now(),
        isFirstScan: ticket['is_first_scan'] ?? ticket['first_scan'] ?? true,
      );
    } catch (e) {
      return null;
    }
  }

  // Batch validate multiple tickets
  Future<List<ScanResult>> validateMultipleTickets({
    required List<String> qrDataList,
    int? eventId,
  }) async {
    try {
      final endpoint = '${AppUrls.tickets}/validate-batch';
      final requestBody = {
        'tickets': qrDataList.map((qr) => qr.trim()).toList(),
        'event_id': eventId,
        'timestamp': DateTime.now().toIso8601String(),
      };

      final response = await _apiService.post(endpoint, data: requestBody);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final results = response.data['results'] as List;
        return results.map((result) => _handleValidationResponse(result)).toList();
      } else {
        // Return error results for all tickets
        return qrDataList.map((qr) => ScanResult(
          isValid: false,
          message: 'Batch validation failed',
          errorCode: 'BATCH_ERROR',
        )).toList();
      }
    } catch (e) {
      // Return error results for all tickets
      return qrDataList.map((qr) => ScanResult(
        isValid: false,
        message: 'Network error: ${e.toString()}',
        errorCode: 'NETWORK_ERROR',
      )).toList();
    }
  }

  // Get ticket scan history for an event
  Future<List<ScanHistoryItem>> getTicketScanHistory({
    required int eventId,
    int page = 0,
    int size = 50,
  }) async {
    try {
      final response = await _apiService.get(
        '${AppUrls.events}/$eventId/scan-history',
        queryParameters: {
          'page': page,
          'size': size,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final scans = response.data['scans'] as List;
        return scans.map((scan) => ScanHistoryItem(
          qrData: scan['qr_data'] ?? '',
          result: ScanResult(
            isValid: scan['is_valid'] ?? false,
            message: scan['message'] ?? '',
            ticketInfo: scan['ticket'] != null ? _parseTicketInfo(scan['ticket']) : null,
          ),
          timestamp: DateTime.parse(scan['timestamp']),
          isManual: scan['is_manual'] ?? false,
        )).toList();
      } else {
        throw ApiException(response.message ?? 'Failed to fetch scan history');
      }
    } catch (e) {
      rethrow;
    }
  }
}
