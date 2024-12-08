import 'package:flutter_assessment_test/core/extensions/future_ext.dart';
import 'package:flutter_assessment_test/core/types/resource.dart';
import 'package:flutter_assessment_test/core/types/usecase.dart';
import 'package:flutter_assessment_test/modules/chat/domain/entities/chat_message_histories.dart';
import 'package:flutter_assessment_test/modules/chat/domain/repositories/chat_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class   GetMessageHistories extends UsecaseNoParams<List<ChatMessageHistories>> {
  final ChatRepo _chatRepo;

  GetMessageHistories({required ChatRepo chatRepo}) : _chatRepo = chatRepo;

  @override
  Future<Resource<List<ChatMessageHistories>>> execute() async {
    return await _chatRepo.getChats().asResource;
  }
}
