import 'package:flutter_assessment_test/core/types/resource.dart';
import 'package:flutter_assessment_test/core/types/usecase.dart';
import 'package:flutter_assessment_test/core/types/nothing.dart';
import 'package:flutter_assessment_test/modules/chat/domain/entities/chat_message_histories.dart';
import 'package:flutter_assessment_test/modules/chat/domain/repositories/chat_repo.dart';

class SaveMessage extends UseCase<ChatMessageHistories, Nothing> {
  final ChatRepo _chatRepo;

  SaveMessage({required ChatRepo chatRepo}) : _chatRepo = chatRepo;

  @override
  Future<Resource<Nothing>> execute(ChatMessageHistories params) async {
    await _chatRepo.saveChat(params);
    return Resource.success(const Nothing());
  }
}