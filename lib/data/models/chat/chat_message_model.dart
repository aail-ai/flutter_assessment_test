import '../../../domain/entities/chat/chat_message.dart';

class ChatMessageModel {
  final Sender sender;
  final String message;

  ChatMessageModel({required this.sender, required this.message});

  // Convert ChatMessageModel to ChatMessage (Domain Entity)
  ChatMessage toEntity() {
    return ChatMessage(sender: sender, message: message);
  }

  // Create a ChatMessageModel from a ChatMessage (Domain Entity)
  factory ChatMessageModel.fromEntity(ChatMessage entity) {
    return ChatMessageModel(sender: entity.sender, message: entity.message);
  }

  // For optional JSON conversion (if data is from a backend)
  factory ChatMessageModel.fromJson(Map<String, dynamic> json) {
    return ChatMessageModel(
      sender: json['sender'],
      message: json['message'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sender': sender,
      'message': message,
    };
  }
}
