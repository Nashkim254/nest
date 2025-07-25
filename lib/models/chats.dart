class Chats {
  final String id;
  final String senderName;
  final String senderImage;
  final String message;
  final String time; // e.g. "10:38 AM", "Yesterday"
  final int unreadCount;

  Chats({
    required this.id,
    required this.senderName,
    required this.senderImage,
    required this.message,
    required this.time,
    this.unreadCount = 0,
  });
}
