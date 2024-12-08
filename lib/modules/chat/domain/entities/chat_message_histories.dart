import 'package:equatable/equatable.dart';
import 'package:flutter_assessment_test/modules/chat/domain/entities/chat_message.dart';

class ChatMessageHistories extends Equatable {
  final List<ChatMessage> chatMessages;
  final DateTime timestamp;

  const ChatMessageHistories({
    required this.chatMessages,
    required this.timestamp,
  });

  factory ChatMessageHistories.fromJson(Map<String, dynamic> json) {
    return ChatMessageHistories(
      chatMessages: (json['chatMessages'] as List<dynamic>)
          .map((e) => ChatMessage.fromJson(e as Map<String, dynamic>))
          .toList(),
      timestamp: DateTime.fromMillisecondsSinceEpoch(json['timestamp'] as int),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'chatMessages': chatMessages.map((e) => e.toJson()).toList(),
      'timestamp': timestamp.millisecondsSinceEpoch,
    };
  }

  @override
  List<Object?> get props => [chatMessages, timestamp];
}
