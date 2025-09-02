class Event {
  final int passes;
  final int totalTickets;
  final double revenue;
  final double latitude;
  final double longitude;
  final int id;
  final String title;
  final String description;
  final DateTime startTime;
  final DateTime endTime;
  final String location;
  final String status;
  final String? password;
  final bool isPasswordProtected;
  final bool protectedPreview;

  final int organizationId;
  final String organizer;

  final String flyerUrl;
  final String theme;
  final List<String>? genres;
  final bool isPrivate;

  final List<TicketPricingPreview> ticketPricing;

  final bool guestListEnabled;
  final int guestListLimit;

  final int viewCount;
  final int interestCount;

  final List<GoingUserPreview> goingUsers;

  final bool isFavorited;
  final bool paymentSetupComplete;

  final DateTime createdAt;
  final DateTime updatedAt;
  final String? coordinates;

  Event({
    required this.passes,
    required this.totalTickets,
    required this.revenue,
    required this.id,
    required this.title,
    required this.description,
    required this.startTime,
    required this.endTime,
    required this.location,
    required this.status,
    this.password,
    required this.isPasswordProtected,
    required this.protectedPreview,
    required this.organizationId,
    required this.organizer,
    required this.flyerUrl,
    required this.theme,
    required this.genres,
    required this.isPrivate,
    required this.ticketPricing,
    required this.guestListEnabled,
    required this.guestListLimit,
    required this.viewCount,
    required this.interestCount,
    required this.goingUsers,
    required this.isFavorited,
    required this.paymentSetupComplete,
    required this.createdAt,
    required this.updatedAt,
    this.latitude = 0.0,
    this.longitude = 0.0,
    this.coordinates,
  });

  factory Event.fromJson(Map<String, dynamic> json) => Event(
        passes: json["passes"],
        totalTickets: json["total_tickets"],
        revenue: (json["revenue"] as num).toDouble(),
        id: json["id"],
        title: json["title"],
        description: json["description"],
        startTime: DateTime.parse(json["start_time"]),
        endTime: DateTime.parse(json["end_time"]),
        location: json["location"],
        status: json["status"],
        password: json["password"],
        isPasswordProtected: json["is_password_protected"],
        protectedPreview: json["protected_preview"],
        organizationId: json["organization_id"],
        organizer: json["organizer"] ?? '', // Handle null organizer
        flyerUrl: json["flyer_url"],
        theme: json["theme"],
        genres: json["genres"] != null
            ? List<String>.from(json["genres"].map((x) => x))
            : null, // Handle null genres
        isPrivate: json["is_private"],
        ticketPricing: json["ticket_pricing"] != null
            ? (json["ticket_pricing"] as List)
                .map((x) => TicketPricingPreview.fromJson(x))
                .toList()
            : [], // Handle null ticket_pricing - return empty list
        guestListEnabled: json["guest_list_enabled"],
        guestListLimit: json["guest_list_limit"],
        viewCount: json["view_count"],
        interestCount: json["interest_count"],
        goingUsers: json["going_users"] != null
            ? (json["going_users"] as List)
                .map((x) => GoingUserPreview.fromJson(x))
                .toList()
            : [], // Handle null going_users - return empty list
        isFavorited: json["is_favorited"],
        coordinates: json["coordinates"],
        paymentSetupComplete: json["payment_setup_complete"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        latitude: json["coordinates"] == null
            ? 0.0
            : json["coordinates"]
                        .replaceAll('(', '')
                        .replaceAll(')', '')
                        .split(',')
                        .length ==
                    2
                ? (json["coordinates"]
                                .replaceAll('(', '')
                                .replaceAll(')', '')
                                .split(',')[1]
                                .trim() as String?)
                            ?.isNotEmpty ==
                        true
                    ? double.tryParse(json["coordinates"]
                        .replaceAll('(', '')
                        .replaceAll(')', '')
                        .split(',')[1]
                        .trim())!
                    : 0.0
                : 0.0,
        longitude: json["coordinates"] == null
            ? 0.0
            : json["coordinates"]
                        .replaceAll('(', '')
                        .replaceAll(')', '')
                        .split(',')
                        .length ==
                    2
                ? (json["coordinates"]
                                .replaceAll('(', '')
                                .replaceAll(')', '')
                                .split(',')[0]
                                .trim() as String?)
                            ?.isNotEmpty ==
                        true
                    ? double.tryParse(json["coordinates"]
                        .replaceAll('(', '')
                        .replaceAll(')', '')
                        .split(',')[0]
                        .trim())!
                    : 0.0
                : 0.0,
      );
  Map<String, dynamic> toJson() => {
        "passes": passes,
        "total_tickets": totalTickets,
        "revenue": revenue,
        "id": id,
        "title": title,
        "description": description,
        "start_time": startTime.toIso8601String(),
        "end_time": endTime.toIso8601String(),
        "location": location,
        "status": status,
        "password": password,
        "is_password_protected": isPasswordProtected,
        "protected_preview": protectedPreview,
        "organization_id": organizationId,
        "organizer": organizer,
        "flyer_url": flyerUrl,
        "theme": theme,
        "genres": genres,
        "is_private": isPrivate,
        "ticket_pricing": ticketPricing.map((x) => x.toJson()).toList(),
        "guest_list_enabled": guestListEnabled,
        "guest_list_limit": guestListLimit,
        "view_count": viewCount,
        "interest_count": interestCount,
        "going_users": goingUsers.map((x) => x.toJson()).toList(),
        "is_favorited": isFavorited,
        "payment_setup_complete": paymentSetupComplete,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "latitude": latitude,
        "longitude": longitude,
        "coordinates": coordinates,
      };
  String get formattedDate {
    final months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    final weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];

    final month = months[startTime.month - 1];
    final day = startTime.day;
    final year = startTime.year;
    final weekday = weekdays[startTime.weekday - 1];
    final hour = startTime.hour == 0
        ? 12
        : (startTime.hour > 12 ? startTime.hour - 12 : startTime.hour);
    final minute = startTime.minute.toString().padLeft(2, '0');
    final period = startTime.hour >= 12 ? 'PM' : 'AM';

    return '$weekday, $month $day, $year - $hour:$minute $period';
  }

  List formatCoordinates() {
//coordinates: (-122.084,37.421998)
    if (coordinates == null || coordinates!.isEmpty) return [0, 0];
    final coords = coordinates!
        .replaceAll('(', '')
        .replaceAll(')', '')
        .split(',')
        .map((e) => e.trim())
        .toList();
    if (coords.length != 2) return [0, 0];
    final lon = double.tryParse(coords[0]);
    final lat = double.tryParse(coords[1]);
    if (lon == null || lat == null) return [0, 0];
    return [lat, lon];
    // return 'Lat: ${lat.toStringAsFixed(4)}, Lon: ${lon.toStringAsFixed(4)}';
  }
}

class TicketPricingPreview {
  final int id;
  final String name;
  final String type;
  final double price;
  final int quantity;
  final bool isPasswordProtected;

  TicketPricingPreview({
    required this.id,
    required this.name,
    required this.type,
    required this.price,
    required this.quantity,
    required this.isPasswordProtected,
  });

  factory TicketPricingPreview.fromJson(Map<String, dynamic> json) =>
      TicketPricingPreview(
        id: json["id"],
        name: json["name"] ?? '',
        type: json["type"] ?? '',
        price: (json["price"] as num).toDouble(),
        quantity: json["quantity"] ?? 0, // Handle null quantity
        isPasswordProtected: json["password_required"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "type": type,
        "price": price,
        "quantity": quantity,
        "password_required": isPasswordProtected,
      };
}

class GoingUserPreview {
  final int id;
  final String name;
  final String avatarUrl;

  GoingUserPreview({
    required this.id,
    required this.name,
    required this.avatarUrl,
  });

  factory GoingUserPreview.fromJson(Map<String, dynamic> json) =>
      GoingUserPreview(
        id: json["id"],
        name: json["name"],
        avatarUrl: json["avatar_url"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "avatar_url": avatarUrl,
      };
}
