import 'package:flutter_assessment_test/modules/chat/domain/entities/chat_message.dart';
class ChatState {
  final List<ChatMessage> messages;
  final bool isLoading;
  final String? error;
  final bool isListening;

  ChatState({
    this.messages = const [],
    this.isLoading = false,
    this.error,
    this.isListening = false,
  });

  ChatState copyWith({
    List<ChatMessage>? messages,
    bool? isLoading,
    String? error,
    bool? isListening,
  }) {
    return ChatState(
      messages: messages ?? this.messages,
      isLoading: isLoading ?? this.isLoading,
      error: error,
      isListening: isListening ?? this.isListening,
    );
  }
}
