import 'package:stt_app/core/usecase/usecase.dart';
import 'package:stt_app/domain/entities/chat/chat_message.dart';
import 'package:stt_app/domain/repositories/chat/chat_repository.dart';

/// Adds a user's message to the repository.
class AddUserMessageUseCase implements UseCase<void, ChatMessage> {
  final ChatRepository repository;

  /// Initializes with the [ChatRepository].
  AddUserMessageUseCase(this.repository);

  /// Adds the [message] to the repository.
  @override
  Future<void> call(ChatMessage message) async {
    await repository.addUserMessage(message);
  }
}
