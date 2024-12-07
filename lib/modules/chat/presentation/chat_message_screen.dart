import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_assessment_test/modules/chat/presentation/providers/chat_provider.dart';

@RoutePage()
class ChatScreen extends ConsumerWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chatState = ref.watch(chatProvider);
    final notifier = ref.read(chatProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: chatState.messages.length,
              itemBuilder: (context, index) {
                final reversedIndex = chatState.messages.length - 1 - index;
                final message = chatState.messages[reversedIndex];
                return Align(
                  alignment: message.isUser 
                    ? Alignment.centerRight 
                    : Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 4.0,
                    ),
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 8.0,
                    ),
                    decoration: BoxDecoration(
                      color: message.isUser 
                        ? Colors.blue[100] 
                        : Colors.grey[300],
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Column(
                      crossAxisAlignment: message.isUser 
                        ? CrossAxisAlignment.end 
                        : CrossAxisAlignment.start,
                      children: [
                        Text(
                          message.text,
                          style: TextStyle(fontSize: 16.0),
                        ),
                        Text(
                          message.isUser ? 'You' : 'Bot',
                          style: TextStyle(
                            fontSize: 12.0,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          if (chatState.error != null)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                chatState.error!,
                style: TextStyle(color: Colors.red),
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    chatState.isListening 
                      ? 'Listening...' 
                      : 'Tap microphone to speak',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey[600],
                    ),
                  ),
                ),
                FloatingActionButton(
                  onPressed: () {
                    if (chatState.isListening) {
                      notifier.stopListening();
                    } else {
                      notifier.startListening();
                    }
                  },
                  child: Icon(
                    chatState.isListening ? Icons.stop : Icons.mic,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}