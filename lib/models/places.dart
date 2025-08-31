class PlaceModel {
  final String placeId;
  final String description;
  final String? mainText;
  final String? secondaryText;

  PlaceModel({
    required this.placeId,
    required this.description,
    this.mainText,
    this.secondaryText,
  });

  factory PlaceModel.fromJson(Map<String, dynamic> json) {
    return PlaceModel(
      placeId: json['place_id'] ?? '',
      description: json['description'] ?? '',
      mainText: json['structured_formatting']?['main_text'],
      secondaryText: json['structured_formatting']?['secondary_text'],
    );
  }
}

class PlaceCoordinates {
  final double latitude;
  final double longitude;
  final String formattedAddress;

  PlaceCoordinates({
    required this.latitude,
    required this.longitude,
    required this.formattedAddress,
  });

  factory PlaceCoordinates.fromJson(Map<String, dynamic> json) {
    final location = json['result']['geometry']['location'];
    return PlaceCoordinates(
      latitude: location['lat']?.toDouble() ?? 0.0,
      longitude: location['lng']?.toDouble() ?? 0.0,
      formattedAddress: json['result']['formatted_address'] ?? '',
    );
  }
}
