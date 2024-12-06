enum Sender {
  user,
  dummy,
}

class ChatMessage {
  final Sender sender;
  final String message;

  ChatMessage({
    required this.sender,
    required this.message,
  });
}
