import 'package:nest/services/shared_preferences_service.dart';

import '../abstractClasses/abstract_class.dart';
import '../app/app.locator.dart';
import '../models/api_exceptions.dart';
import '../models/create_event.dart';
import '../ui/common/app_urls.dart';

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

  Future getSingleEvent({required int id}) async {
    try {
      final response = await _apiService.get(
        '${AppUrls.events}/$id',
        queryParameters: {
          'id': id,
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
}
