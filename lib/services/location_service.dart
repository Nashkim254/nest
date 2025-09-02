import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

import '../abstractClasses/abstract_class.dart';
import '../app/app.locator.dart';
import '../models/places.dart';

class LocationService {
  final apiService = locator<IApiService>();
  static Future<bool> isLocationServiceEnabled() async {
    return await Geolocator.isLocationServiceEnabled();
  }

  /// Check and request location permissions
  static Future<LocationPermission> checkLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    return permission;
  }

  /// Get current position
  static Future<Position?> getCurrentPosition() async {
    try {
      // Check if location services are enabled
      bool serviceEnabled = await isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw Exception('Location services are disabled');
      }

      // Check permissions
      LocationPermission permission = await checkLocationPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        throw Exception('Location permission denied');
      }

      // Get current position
      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        timeLimit: const Duration(seconds: 10),
      );

      return position;
    } catch (e) {
      print('Error getting current position: $e');
      return null;
    }
  }

  Future<String?> getCurrentCity() async {
    try {
      Position? position = await getCurrentPosition();
      if (position == null) return null;

      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        return place.locality ??
            place.subAdministrativeArea ??
            place.administrativeArea;
      }

      return null;
    } catch (e) {
      print('Error getting current city: $e');
      return null;
    }
  }

  /// Get detailed address information
  static Future<Map<String, String?>> getDetailedLocation() async {
    try {
      Position? position = await getCurrentPosition();
      if (position == null) return {};

      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        return {
          'city': place.locality,
          'state': place.administrativeArea,
          'country': place.country,
          'postalCode': place.postalCode,
          'street': place.street,
          'subLocality': place.subLocality,
          'coordinates': '${position.latitude}, ${position.longitude}',
        };
      }

      return {};
    } catch (e) {
      print('Error getting detailed location: $e');
      return {};
    }
  }

  /// Get coordinates from current location
  Future<Position?> getCoordinatesFromCurrentLocation() async {
    try {
      Position? position = await getCurrentPosition();
      if (position == null) return null;

      return position;
    } catch (e) {
      print('Error getting coordinates: $e');
      return null;
    }
  }

  //places api
  static final String _apiKey =
      dotenv.env['GOOGLE_PLACES_API_KEY']!; // Replace with your API key
  static const String _baseUrl = 'https://maps.googleapis.com/maps/api/place';

  Future<List<PlaceModel>> searchPlaces(String query) async {
    try {
      if (query.isEmpty) return [];

      final response = await apiService.get(
        '$_baseUrl/autocomplete/json',
        queryParameters: {
          'input': query,
          'key': _apiKey,
          'types': 'establishment|geocode',
        },
      );

      if (response.statusCode == 200) {
        final data = response.data;
        if (data['status'] == 'OK') {
          final predictions = data['predictions'] as List;
          return predictions
              .map((prediction) => PlaceModel.fromJson(prediction))
              .toList();
        } else {
          throw Exception('Places API Error: ${data['status']}');
        }
      } else {
        throw Exception('HTTP Error: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to search places: $e');
    }
  }

  Future<PlaceCoordinates> getPlaceCoordinates(String placeId) async {
    try {
      final response = await apiService.get(
        '$_baseUrl/details/json',
        queryParameters: {
          'place_id': placeId,
          'fields': 'geometry,formatted_address',
          'key': _apiKey,
        },
      );

      if (response.statusCode == 200) {
        final data = response.data;
        if (data['status'] == 'OK') {
          return PlaceCoordinates.fromJson(data);
        } else {
          throw Exception('Place Details API Error: ${data['status']}');
        }
      } else {
        throw Exception('HTTP Error: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to get place coordinates: $e');
    }
  }
}
