import 'package:flutter_assessment_test/modules/chat/domain/entities/chat_message.dart';

abstract class ChatLocalDts {
  Future<void> saveChat(ChatMessage chatMessage);
  Future<List<ChatMessage>> getChats();
}
