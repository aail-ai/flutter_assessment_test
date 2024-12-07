import 'package:stt_app/core/usecase/usecase.dart';
import 'package:stt_app/domain/repositories/chat/chat_repository.dart';

/// Stops listening for speech input and returns the transcribed text.
class StopListeningUsecase implements UseCase<String?, NoParams> {
  final ChatRepository repository;

  /// Initializes with the [ChatRepository].
  StopListeningUsecase(this.repository);

  /// Stops listening for speech and returns the transcribed text, if any.
  @override
  Future<String?> call(NoParams params) async {
    return await repository.stopListening();
  }
}
