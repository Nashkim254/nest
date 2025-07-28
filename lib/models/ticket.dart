class Ticket {
  final String id;
  final String eventName;
  final String eventDate;
  final String eventTime;
  final String ticketType; // General Admission, VIP Access, etc.
  final String? imageUrl;
  final String? qrCode;
  final bool isSavedToWallet;
  final String? specialOffer; // Like "20 x 20" badge

  Ticket({
    required this.id,
    required this.eventName,
    required this.eventDate,
    required this.eventTime,
    required this.ticketType,
    this.imageUrl,
    this.qrCode,
    this.isSavedToWallet = false,
    this.specialOffer,
  });

  // Check if ticket is upcoming based on date
  bool get isUpcoming {
    try {
      final now = DateTime.now();
      final eventDateTime = _parseEventDate();
      return eventDateTime.isAfter(now);
    } catch (e) {
      return true; // Default to upcoming if parsing fails
    }
  }

  DateTime _parseEventDate() {
    // Parse date formats like "Fri, Oct 27", "Sat, Nov 11", "Sun, Dec 3"
    final months = {
      'Jan': 1,
      'Feb': 2,
      'Mar': 3,
      'Apr': 4,
      'May': 5,
      'Jun': 6,
      'Jul': 7,
      'Aug': 8,
      'Sep': 9,
      'Oct': 10,
      'Nov': 11,
      'Dec': 12
    };

    final parts = eventDate.split(' ');
    if (parts.length >= 3) {
      final monthStr = parts[1].replaceAll(',', '');
      final dayStr = parts[2];
      final month = months[monthStr] ?? 1;
      final day = int.tryParse(dayStr) ?? 1;
      final year = DateTime.now().year; // Assume current year

      return DateTime(year, month, day);
    }

    return DateTime.now().add(const Duration(days: 1)); // Default to tomorrow
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'eventName': eventName,
      'eventDate': eventDate,
      'eventTime': eventTime,
      'ticketType': ticketType,
      'imageUrl': imageUrl,
      'qrCode': qrCode,
      'isSavedToWallet': isSavedToWallet,
      'specialOffer': specialOffer,
    };
  }

  // Create from JSON
  factory Ticket.fromJson(Map<String, dynamic> json) {
    return Ticket(
      id: json['id'],
      eventName: json['eventName'],
      eventDate: json['eventDate'],
      eventTime: json['eventTime'],
      ticketType: json['ticketType'],
      imageUrl: json['imageUrl'],
      qrCode: json['qrCode'],
      isSavedToWallet: json['isSavedToWallet'] ?? false,
      specialOffer: json['specialOffer'],
    );
  }
}
