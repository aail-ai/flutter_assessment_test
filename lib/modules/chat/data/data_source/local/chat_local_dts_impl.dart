import 'package:flutter_assessment_test/modules/chat/data/data_source/local/chat_local_dts.dart';
import 'package:flutter_assessment_test/modules/chat/domain/entities/chat_message.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ChatLocalDtsImpl implements ChatLocalDts {
  @override
  Future<void> saveChat(ChatMessage chatMessage) async {
    await Hive.box<ChatMessage>('chat_messages').put(DateTime.now().millisecondsSinceEpoch, chatMessage);
  }

  @override
  Future<List<ChatMessage>> getChats() async {
    return Hive.box<ChatMessage>('chat_messages').values.toList();
  }
}
