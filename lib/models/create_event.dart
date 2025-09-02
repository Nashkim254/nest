class CreateEventRequest {
  final String title;
  final String description;
  final String startTime;
  final String endTime;
  final String location;
  final String? address;
  final double? latitude;
  final double? longitude;
  final String? password;
  final String? termsAndConditions;

  // Event details
  final String flyerUrl;
  final String theme;
  final List<String> genres;
  final bool isPrivate;

  // Ticket configuration
  final List<TicketPricing> ticketPricing;

  // Guest list configuration
  final bool guestListEnabled;
  final int guestListLimit;

  CreateEventRequest({
    required this.title,
    required this.description,
    required this.startTime,
    required this.endTime,
    required this.location,
    this.address,
    this.latitude,
    this.longitude,
    this.password,
    required this.flyerUrl,
    required this.theme,
    required this.genres,
    required this.isPrivate,
    required this.ticketPricing,
    required this.guestListEnabled,
    required this.guestListLimit,
    required this.termsAndConditions,
  });

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "start_time": startTime,
        "end_time": endTime,
        "location": location,
        "address": address,
        "latitude": latitude,
        "longitude": longitude,
        "password": password,
        "flyer_url": flyerUrl,
        "theme": theme,
        "genres": genres,
        "is_private": isPrivate,
        "ticket_pricing": ticketPricing.map((t) => t.toJson()).toList(),
        "guest_list_enabled": guestListEnabled,
        "guest_list_limit": guestListLimit,
        "terms_and_conditions": termsAndConditions,
      };
}

class TicketPricing {
  final String type;
  final String name;
  final double price;
  final int limit;
  final bool available;
  final String? password;
  final String? description;

  TicketPricing({
    required this.type,
    required this.name,
    required this.price,
    required this.limit,
    required this.available,
    this.password,
    this.description,
  });

  Map<String, dynamic> toJson() => {
        "type": type,
        "name": name,
        "price": price,
        "limit": limit,
        "available": available,
        "password": password,
        "description": description,
      };

  factory TicketPricing.fromJson(Map<String, dynamic> json) => TicketPricing(
        type: json["type"],
        name: json["name"],
        price: (json["price"] as num).toDouble(),
        limit: json["limit"],
        available: json["available"],
        password: json["password"],
        description: json["description"],
      );
}
