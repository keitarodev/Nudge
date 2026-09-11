class NotificationItem {
  final String id;
  final String title;
  final String message;
  final String place;
  final DateTime createdAt;
  final bool isRead;

  const NotificationItem({
    required this.id,
    required this.title,
    required this.message,
    required this.place,
    required this.createdAt,
    required this.isRead,
  });
}