import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

class LocationService {
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
}
