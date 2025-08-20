class CreateEventRequest {
  final String title;
  final String description;
  final DateTime startTime;
  final DateTime endTime;
  final String location;
  final String? address;
  final double? latitude;
  final double? longitude;
  final String? password;

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
  });

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "start_time": startTime.toIso8601String(),
        "end_time": endTime.toIso8601String(),
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
      };
}

class TicketPricing {
  final String name;
  final double price;
  final int quantity;

  TicketPricing({
    required this.name,
    required this.price,
    required this.quantity,
  });

  Map<String, dynamic> toJson() => {
        "name": name,
        "price": price,
        "quantity": quantity,
      };

  factory TicketPricing.fromJson(Map<String, dynamic> json) => TicketPricing(
        name: json["name"],
        price: (json["price"] as num).toDouble(),
        quantity: json["quantity"],
      );
}
