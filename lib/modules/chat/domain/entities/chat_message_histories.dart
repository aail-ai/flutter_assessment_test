import 'package:equatable/equatable.dart';
import 'package:flutter_assessment_test/modules/chat/domain/entities/chat_message.dart';

class ChatMessageHistories extends Equatable {
  final List<ChatMessage> chatMessages;
  final DateTime timestamp;

  const ChatMessageHistories({required this.chatMessages, required this.timestamp});
  
  @override
  List<Object?> get props => [chatMessages, timestamp];
}
