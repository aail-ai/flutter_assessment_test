import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stt_app/core/di/dependency_injection.dart';
import 'package:stt_app/core/usecase/usecase.dart';
import 'package:stt_app/domain/entities/chat/chat_message.dart';
import 'package:stt_app/domain/usecases/chat/add_user_message_usecase.dart';
import 'package:stt_app/domain/usecases/chat/get_dummy_reply_usecase.dart';
import 'package:stt_app/domain/usecases/chat/start_listening_usecase.dart';
import 'package:stt_app/domain/usecases/chat/stop_listening_usecase.dart';

/// Chat provider to manage the state of the chat, including user messages,
/// dummy replies, and the listening state of the Speech-to-Text feature.
final chatProvider = StateNotifierProvider<ChatNotifier, ChatState>((ref) {
  // Creates a new instance of ChatNotifier, injecting the necessary use cases
  return ChatNotifier(
    getIt<AddUserMessageUseCase>(),
    getIt<GetDummyReplyUseCase>(),
    getIt<StartListeningUsecase>(),
    getIt<StopListeningUsecase>(),
  );
});

/// Represents the state of the chat, including the list of messages and
/// whether the app is currently listening to speech input.
class ChatState {
  final List<ChatMessage> messages;
  final bool isListening;

  ChatState({
    required this.messages,
    this.isListening = false,
  });
}

/// A [StateNotifier] to manage the state of the chat. This class handles adding
/// messages, getting dummy replies, and controlling the listening state for
/// speech-to-text.
class ChatNotifier extends StateNotifier<ChatState> {
  final AddUserMessageUseCase _addUserMessage;
  final GetDummyReplyUseCase _getDummyReply;
  final StartListeningUsecase _startListening;
  final StopListeningUsecase _stopListening;

  ChatNotifier(
    this._addUserMessage,
    this._getDummyReply,
    this._startListening,
    this._stopListening,
  ) : super(ChatState(
          messages: [],
          isListening: false,
        ));

  /// Adds a new user message to the chat and retrieves a dummy reply.
  /// Updates the state with the new user message and the dummy reply.
  Future<void> addUserMessage(
    String message,
  ) async {
    final userMessage = ChatMessage(
      sender: Sender.user,
      message: message,
    );

    // Get a dummy reply after adding the user message
    final dummyReply = await _getDummyReply(NoParams());

    // Add the user message to the state
    _addUserMessage(userMessage);

    // Update the state with the new message
    state = ChatState(
      messages: [...state.messages, userMessage], // Add the user message
      isListening: state.isListening, // Keep the current listening state
    );

    // Wait for a short delay before adding the dummy reply
    await Future.delayed(const Duration(seconds: 2));

    // Update the state with the dummy reply
    state = ChatState(
      messages: [...state.messages, dummyReply], // Add the dummy reply
      isListening: state.isListening, // Keep the current listening state
    );
  }

  /// Starts listening for speech input by calling the appropriate use case.
  /// Updates the state to indicate that the app is now listening.
  Future<void> startListening(TextEditingController chatController) async {
    // Call the use case to start listening
    await _startListening(chatController);

    // Update the state to reflect that the app is now listening
    state = ChatState(
      messages: state.messages,
      isListening: true, // Listening is now active
    );
  }

  /// Stops listening for speech input, processes the result, and adds it
  /// to the chat as a user message.
  Future<void> stopListening(TextEditingController chatController) async {
    if (Platform.isAndroid) {
      chatController.clear();
    }
    // Stop listening and get the recognized text from speech input
    final text = await _stopListening(NoParams());

    // Update the state to indicate that listening has stopped
    state = ChatState(
      messages: state.messages,
      isListening: false, // Listening is now inactive
    );

    // If the recognized speech is not empty, add it as a user message
    if (text != null && text.isNotEmpty) {
      await addUserMessage(text); // Add the speech input as a user message
    }
  }
}
