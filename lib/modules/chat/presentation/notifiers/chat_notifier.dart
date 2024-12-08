import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_assessment_test/core/extensions/resource_ext.dart';
import 'package:flutter_assessment_test/modules/chat/domain/entities/chat_message.dart';
import 'package:flutter_assessment_test/modules/chat/domain/entities/chat_message_histories.dart';
import 'package:flutter_assessment_test/modules/chat/domain/usecases/save_message.dart';
import 'package:flutter_assessment_test/modules/chat/presentation/notifiers/chat_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class ChatNotifier extends StateNotifier<ChatState> {
  final SaveMessage _saveMessage;
  final SpeechToText _speech;
  final Random _random = Random();

  ChatNotifier(this._saveMessage, this._speech) : super(ChatState(isLoading: false)) {
    _initializeSpeech();
  }

  Future<void> _initializeSpeech() async {
    final available = await _speech.initialize();
    if (!available) {
      _setError("Speech recognition not available");
    }
  }

  Future<void> startListening() async {
    if (!_speech.isAvailable) return;

    state = state.copyWith(isListening: true);
    await _speech.listen(onResult: _onSpeechResult);
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    if (result.finalResult) {
      _addMessage(ChatMessage(
        text: result.recognizedWords,
        isUser: true,
        timestamp: DateTime.now(),
      ));
      stopListening();
    }
  }

  Future<void> stopListening() async {
    await _speech.stop();
    state = state.copyWith(isListening: false);
  }

  void _addMessage(ChatMessage message) {
    final newMessages = [...state.messages, message];
    state = state.copyWith(messages: newMessages);

    if (message.isUser) {
      _simulateResponse(newMessages);
    }
  }

  void _simulateResponse(List<ChatMessage> newMessages) {
    Future.delayed(const Duration(seconds: 1), () {
      final dummyResponses = ["yes", "ok", "no"];
      final response = dummyResponses[_random.nextInt(dummyResponses.length)];

      final dummyMessage = ChatMessage(
        text: response,
        isUser: false,
        timestamp: DateTime.now(),
      );

      state = state.copyWith(messages: [...newMessages, dummyMessage]);
    });
  }

  Future<void> saveCurrentConversation(List<ChatMessage> messages) async {
    _setLoading(true);
    debugPrint('Saving conversation with messages: $messages');
    final newHistory = ChatMessageHistories(
      chatMessages: messages,
      timestamp: DateTime.now(),
    );

    final result = await _saveMessage(newHistory);
    result.when(
      success: (_) {
        debugPrint('Conversation saved successfully');
        _setLoading(false);
      },
      error: (error) {
        debugPrint('Conversation save failed');
        _setLoading(false);
        _setError(error.toString());
      },
    );
  }

  void clearMessages() {
    state = state.copyWith(messages: [], isLoading: false, error: null);
  }

  void _setLoading(bool value) {
    state = state.copyWith(isLoading: value);
  }

  void _setError(String value) {
    state = state.copyWith(error: value);
  }

  void setMessages(List<ChatMessage> messages) {
    state = state.copyWith(messages: messages);
  }
}
