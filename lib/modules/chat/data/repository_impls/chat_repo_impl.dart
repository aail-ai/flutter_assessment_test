import 'package:flutter_assessment_test/modules/chat/data/data_source/local/chat_local_dts.dart';
import 'package:flutter_assessment_test/modules/chat/domain/entities/chat_message_histories.dart';
import 'package:flutter_assessment_test/modules/chat/domain/repositories/chat_repo.dart';

class ChatRepoImpl implements ChatRepo {
  final ChatLocalDts _chatLocalDts;

  ChatRepoImpl({required ChatLocalDts chatLocalDts}) : _chatLocalDts = chatLocalDts;

  @override
  Future<List<ChatMessageHistories>> getChats() async {
    return await _chatLocalDts.getChats();
  }

  @override
  Future<void> saveChat(ChatMessageHistories chatMessageHistories) async {
    return await _chatLocalDts.saveChat(chatMessageHistories);
  }
}
