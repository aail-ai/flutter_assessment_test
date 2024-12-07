import 'dart:math';

import 'package:flutter/material.dart';
import 'package:stt_app/data/datasources/speech_to_text/speech_to_text_datasource.dart';
import 'package:stt_app/data/models/chat/chat_message_model.dart';
import 'package:stt_app/domain/entities/chat/chat_message.dart';
import 'package:stt_app/domain/repositories/chat/chat_repository.dart';

/// Implementation of [ChatRepository] for managing chat operations.
class ChatRepositoryImpl implements ChatRepository {
  final SpeechToTextDataSource _speechToTextDataSource;

  /// Initializes with the [SpeechToTextDataSource].
  ChatRepositoryImpl(this._speechToTextDataSource);

  final List<ChatMessageModel> _messages = [];
  final List<String> _dummyReplies = ["yes", "ok", "no"];
  final Random _random = Random();

  /// Adds a user message to the internal storage.
  @override
  Future<void> addUserMessage(ChatMessage message) async {
    final model = ChatMessageModel.fromEntity(message);
    _messages.add(model);
  }

  /// Retrieves a random dummy reply.
  @override
  Future<ChatMessage> getDummyReply() async {
    final reply = _dummyReplies[_random.nextInt(_dummyReplies.length)];
    final dummyMessage = ChatMessageModel(
      sender: Sender.dummy,
      message: reply,
    );

    return dummyMessage.toEntity();
  }

  /// Starts listening for speech and updates the [chatController].
  @override
  Future<void> startListening(TextEditingController chatController) async {
    final isInitializedStt = await _speechToTextDataSource.initialize();
    if (isInitializedStt) {
      await _speechToTextDataSource.startListening(chatController);
    }
  }

  /// Stops listening for speech and returns the transcribed text.
  @override
  Future<String?> stopListening() async {
    return await _speechToTextDataSource.stopListening();
  }
}
