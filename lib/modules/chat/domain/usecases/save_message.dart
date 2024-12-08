import 'package:flutter_assessment_test/core/extensions/future_ext.dart';
import 'package:flutter_assessment_test/core/types/resource.dart';
import 'package:flutter_assessment_test/core/types/usecase.dart';
import 'package:flutter_assessment_test/core/types/nothing.dart';
import 'package:flutter_assessment_test/modules/chat/domain/entities/chat_message_histories.dart';
import 'package:flutter_assessment_test/modules/chat/domain/repositories/chat_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class SaveMessage extends UseCase<ChatMessageHistories, Nothing> {
  final ChatRepo _chatRepo;

  SaveMessage({required ChatRepo chatRepo}) : _chatRepo = chatRepo;

  @override
  Future<Resource<Nothing>> execute(ChatMessageHistories params) async {
    final result = await _chatRepo.saveChat(params).asResource;

    if (result is Error) {
      return Resource.error(result.exception);
    }
    return Resource.success(const Nothing());
  }
}
