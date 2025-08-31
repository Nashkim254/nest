import 'package:stacked/stacked.dart';

class SharedCoordinatesService with ListenableServiceMixin {
  double? _latitude;
  double? _longitude;
  String? _address;

  double? get latitude => _latitude;
  double? get longitude => _longitude;
  String? get address => _address;

  bool get hasCoordinates => _latitude != null && _longitude != null;

  void updateCoordinates({
    required double latitude,
    required double longitude,
    required String address,
  }) {
    _latitude = latitude;
    _longitude = longitude;
    _address = address;
    notifyListeners();
  }

  void clearCoordinates() {
    _latitude = null;
    _longitude = null;
    _address = null;
    notifyListeners();
  }

  Map<String, dynamic> toJson() {
    return {
      'latitude': _latitude,
      'longitude': _longitude,
      'address': _address,
    };
  }
}
