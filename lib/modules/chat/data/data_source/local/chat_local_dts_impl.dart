import 'dart:convert';

import 'package:flutter_assessment_test/modules/chat/data/data_source/local/chat_local_dts.dart';
import 'package:flutter_assessment_test/modules/chat/domain/entities/chat_message_histories.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ChatLocalDts)
class ChatLocalDtsImpl implements ChatLocalDts {
  @override
  Future<void> saveChat(ChatMessageHistories chatMessageHistories) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('chat_messages', jsonEncode(chatMessageHistories.toJson()));
  }

  @override
  Future<List<ChatMessageHistories>> getChats() async {
    final prefs = await SharedPreferences.getInstance();
    final chatMessageHistories = ChatMessageHistories.fromJson(jsonDecode(prefs.getString('chat_messages') ?? '{}'));
    return [chatMessageHistories];
  }
}
