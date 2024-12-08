// lib/modules/chat/presentation/providers/chat_notifier.dart
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_assessment_test/core/extension/resource_ext.dart';
import 'package:flutter_assessment_test/modules/chat/domain/entities/chat_message.dart';
import 'package:flutter_assessment_test/modules/chat/domain/entities/chat_message_histories.dart';
import 'package:flutter_assessment_test/modules/chat/domain/usecases/save_message.dart';
import 'package:flutter_assessment_test/modules/chat/presentation/notifiers/chat_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:speech_to_text/speech_to_text.dart';

class ChatNotifier extends StateNotifier<ChatState> {
  final SaveMessage _saveMessage;
  final SpeechToText _speech;
  ChatNotifier(this._saveMessage, this._speech) : super(ChatState(isLoading: false)) {
    _initializeSpeech();
  }

  final _random = Random();

  Future<void> _initializeSpeech() async {
    final available = await _speech.initialize();
    if (!available) {
      state = state.copyWith(error: "Speech recognition not available");
    }
  }

  Future<void> startListening() async {
    if (!_speech.isAvailable) return;

    await _speech.listen(
      onResult: (result) {
        if (result.finalResult) {
          addMessage(
            ChatMessage(
              text: result.recognizedWords,
              isUser: true,
              timestamp: DateTime.now(),
            ),
          );
          stopListening();
        }
      },
    );
    state = state.copyWith(isListening: true);
  }

  Future<void> stopListening() async {
    await _speech.stop();
    state = state.copyWith(isListening: false);
  }

  void addMessage(ChatMessage message) {
    final newMessages = [...state.messages, message];
    state = state.copyWith(messages: newMessages);

    if (message.isUser) {
      Future.delayed(const Duration(seconds: 1), () {
        final dummyResponses = ["yes", "ok", "no"];
        final response = dummyResponses[_random.nextInt(dummyResponses.length)];

        final dummyMessage = ChatMessage(
          text: response,
          isUser: false,
          timestamp: DateTime.now(),
        );

        final updatedMessages = [...newMessages, dummyMessage];
        state = state.copyWith(messages: updatedMessages);
      });
    }
  }

  void setLoading(bool value) {
    state = state.copyWith(isLoading: value);
  }

  void setError(String value) {
    state = state.copyWith(error: value);
  }

  Future<void> saveCurrentConversation(List<ChatMessage> messages) async {
    setLoading(true);
    await Future.delayed(const Duration(seconds: 2));
    debugPrint('Saving conversation with messages: $messages');
    final newHistory = ChatMessageHistories(
      chatMessages: messages,
      timestamp: DateTime.now(),
    );

    final result = await _saveMessage(newHistory);
    result.when(
      success: (_) {
        debugPrint('Conversation saved successfully');
        setLoading(false);
      },
      error: (error) {
        debugPrint('Conversation saved failed');
        setLoading(false);
        setError(error.toString());
      },
    );
  }
}
