import 'package:flutter/material.dart';
import 'package:stt_app/domain/entities/chat/chat_message.dart';

/// Defines the contract for chat-related operations.
abstract class ChatRepository {
  /// Adds a user message to the chat data source.
  Future<void> addUserMessage(ChatMessage message);

  /// Retrieves a dummy reply.
  Future<ChatMessage> getDummyReply();

  /// Starts listening for speech and updates the [chatController] with the transcribed text.
  Future<void> startListening(TextEditingController chatController);

  /// Stops listening for speech and returns the transcribed text, if any.
  Future<String?> stopListening();
}
