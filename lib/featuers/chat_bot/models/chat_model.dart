enum MessageType { user, bot }

class Message {
  final String text;
  final MessageType type;
  final List<String>? options;
  final DateTime timestamp;
  final bool isTyping;

  Message({
    required this.text,
    required this.type,
    this.options,
    DateTime? timestamp,
    this.isTyping = false,
  }) : timestamp = timestamp ?? DateTime.now();

  /// Helper method to format timestamp
  String get formattedTime {
    final hour = timestamp.hour;
    final minute = timestamp.minute.toString().padLeft(2, '0');
    final period = hour >= 12 ? 'م' : 'ص';
    final hour12 = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
    return '$hour12:$minute $period';
  }
}
