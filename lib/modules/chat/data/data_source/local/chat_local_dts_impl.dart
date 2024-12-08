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
    final chatMessages = await getChats();
    final String jsonStr = jsonEncode([...chatMessages, chatMessageHistories]);
    await prefs.setString('chat_messages', jsonStr);
  }

  @override
  Future<List<ChatMessageHistories>> getChats() async {
    final prefs = await SharedPreferences.getInstance();
    final String? jsonStr = prefs.getString('chat_messages');

    if (jsonStr == null || jsonStr.isEmpty) {
      return [];
    }

    final List<dynamic> jsonList = jsonDecode(jsonStr);
    final chatMessageHistories = jsonList.map((e) => ChatMessageHistories.fromJson(e as Map<String, dynamic>)).toList();
    return chatMessageHistories;
  }
}
