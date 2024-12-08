import 'package:flutter/material.dart';
import 'package:flutter_assessment_test/core/extensions/datetime_ext.dart';
import 'package:flutter_assessment_test/modules/chat/domain/entities/chat_message.dart';

class ChatBubble extends StatelessWidget {
  const ChatBubble({
    super.key,
    required this.message,
  });

  final ChatMessage message;

  @override
  Widget build(BuildContext context) {

    return Container(
      margin: EdgeInsets.only(
        right: message.isUser ? 8.0 : 48.0,
        left: message.isUser ? 48.0 : 8.0,
        top: 4.0,
        bottom: 4.0,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 16.0,
        vertical: 8.0,
      ),
      decoration: BoxDecoration(
        color: message.isUser ? Colors.blue[100] : Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(message.isUser ? 16 : 0),
          topRight: Radius.circular(message.isUser ? 0 : 16),
          bottomLeft: const Radius.circular(16),
          bottomRight: const Radius.circular(16),
        ),
      ),
      child: Column(
        crossAxisAlignment: message.isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Text(
            message.text,
            style: const TextStyle(fontSize: 16.0),
          ),
          Text(
            message.timestamp.formatTimestamp(),
            style: TextStyle(
              fontSize: 10.0,
              color: Colors.grey[500],
            ),
          ),
        ],
      ),
    );
  }


}
