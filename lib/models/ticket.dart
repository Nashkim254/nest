class Ticket {
  final int id;
  final int eventId;
  final int userId;
  final String ticketType;
  final double price;
  final int quantity;
  final bool isRSVP;
  final String description;
  final String qrCode;
  final bool isValidated;
  final DateTime createdAt;
  final DateTime updatedAt;

  // Event information (optional fields)
  final String? eventTitle;
  final DateTime? eventDate;
  final String? eventLocation;

  Ticket({
    required this.id,
    required this.eventId,
    required this.userId,
    required this.ticketType,
    required this.price,
    required this.quantity,
    required this.isRSVP,
    required this.description,
    required this.qrCode,
    required this.isValidated,
    required this.createdAt,
    required this.updatedAt,
    this.eventTitle,
    this.eventDate,
    this.eventLocation,
  });

  factory Ticket.fromJson(Map<String, dynamic> json) {
    return Ticket(
      id: json['id'],
      eventId: json['event_id'],
      userId: json['user_id'],
      ticketType: json['ticket_type'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      quantity: json['quantity'] ?? 0,
      isRSVP: json['is_rsvp'] ?? false,
      description: json['description'] ?? '',
      qrCode: json['qr_code'] ?? '',
      isValidated: json['is_validated'] ?? false,
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      eventTitle: json['event_title'],
      eventDate: json['event_date'] != null
          ? DateTime.parse(json['event_date'])
          : null,
      eventLocation: json['event_location'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'event_id': eventId,
      'user_id': userId,
      'ticket_type': ticketType,
      'price': price,
      'quantity': quantity,
      'is_rsvp': isRSVP,
      'description': description,
      'qr_code': qrCode,
      'is_validated': isValidated,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt.toIso8601String(),
      'event_title': eventTitle,
      'event_date': eventDate?.toIso8601String(),
      'event_location': eventLocation,
    };
  }
}
