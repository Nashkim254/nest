class TicketItem {
  final String name;
  final double price;
  int quantity;

  TicketItem({
    required this.name,
    required this.price,
    this.quantity = 1,
  });

  double get totalPrice => price * quantity;
}
