class TicketItem {
  final String name;
  final double price;
  int quantity;
  final bool passwordRequired;
  final String? ticketId;
  final int? index;
  final String type;
  final String? description;

  TicketItem({
    required this.name,
    required this.price,
    required this.quantity,
    this.passwordRequired = false,
    this.ticketId,
    this.index,
    this.type = 'paid',
    this.description,
  });

  double get totalPrice => price * quantity;

  bool get isFree => type == 'free' || price == 0;

  String get formattedPrice {
    if (isFree) return 'Free';
    return 'KSH ${price.toStringAsFixed(0)}';
  }

  String get formattedTotal {
    if (isFree) return 'Free';
    return 'KSH ${totalPrice.toStringAsFixed(0)}';
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
      'quantity': quantity,
      'password_required': passwordRequired,
      'ticket_id': ticketId,
      'index': index,
      'type': type,
      'description': description,
      'total_price': totalPrice,
    };
  }

  factory TicketItem.fromMap(Map<String, dynamic> map) {
    return TicketItem(
      name: map['name'] ?? '',
      price: double.parse(map['price'].toString()),
      quantity: map['quantity'] ?? 1,
      passwordRequired: map['password_required'] ?? false,
      ticketId: map['ticket_id']?.toString(),
      index: map['index'],
      type: map['type'] ?? 'paid',
      description: map['description'],
    );
  }
}
