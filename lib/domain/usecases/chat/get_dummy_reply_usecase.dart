import 'package:stt_app/core/usecase/usecase.dart';
import 'package:stt_app/domain/entities/chat/chat_message.dart';
import 'package:stt_app/domain/repositories/chat/chat_repository.dart';

/// Retrieves a dummy reply from the repository.
class GetDummyReplyUseCase implements UseCase<ChatMessage, NoParams> {
  final ChatRepository repository;

  /// Initializes with the [ChatRepository].
  GetDummyReplyUseCase(this.repository);

  /// Gets a dummy reply from the repository.
  @override
  Future<ChatMessage> call(NoParams params) async {
    return await repository.getDummyReply();
  }
}
