enum MessageType { user, bot }

class Message {
  final String text;
  final MessageType type;

  Message({required this.text, required this.type});
}
