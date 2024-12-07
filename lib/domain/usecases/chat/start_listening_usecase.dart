import 'package:flutter/material.dart';
import 'package:stt_app/core/usecase/usecase.dart';
import 'package:stt_app/domain/repositories/chat/chat_repository.dart';

/// Starts listening for speech input.
class StartListeningUsecase implements UseCase<void, TextEditingController> {
  final ChatRepository repository;

  /// Initializes with the [ChatRepository].
  StartListeningUsecase(this.repository);

  /// Starts listening for speech input and updates the [TextEditingController].
  @override
  Future<void> call(TextEditingController chatController) async {
    await repository.startListening(chatController);
  }
}
