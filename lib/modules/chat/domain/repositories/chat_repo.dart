import 'package:flutter_assessment_test/modules/chat/domain/entities/chat_message_histories.dart';

abstract class ChatRepo {
  Future<void> saveChat(ChatMessageHistories chatMessageHistories);
  Future<List<ChatMessageHistories>> getChats();
}
