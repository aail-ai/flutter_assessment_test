import 'package:flutter_assessment_test/modules/chat/data/data_source/local/chat_local_dts.dart';
import 'package:flutter_assessment_test/modules/chat/domain/entities/chat_message_histories.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ChatLocalDtsImpl implements ChatLocalDts {
  @override
  Future<void> saveChat(ChatMessageHistories chatMessageHistories) async {
    await Hive.box<ChatMessageHistories>('chat_messages')
        .put(DateTime.now().millisecondsSinceEpoch, chatMessageHistories);
  }

  @override
  Future<List<ChatMessageHistories>> getChats() async {
    final box = Hive.box<ChatMessageHistories>('chat_messages');
    final chatMessageHistories = <ChatMessageHistories>[];
    for (var chatHistory in box.values) {
      chatMessageHistories.add(chatHistory);
    }
    return chatMessageHistories;
  }
}
