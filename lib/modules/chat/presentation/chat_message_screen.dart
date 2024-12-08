import 'package:flutter/material.dart';
import 'package:flutter_assessment_test/core/shared_widgets/dialogs/alert_dialog_with_icon.dart';
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

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) {
          return;
        }
        final bool? shouldPop = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialogWithIcon(
            centeredTitle: true,
            title: 'Want to Save This Conversation?',
            description:
                'You can save this conversation for future reference. It will be saved in your device storage.',
            onConfirmText: 'Save',
            onConfirmed: () => Navigator.of(context).pop(true),
            onCanceledText: 'Just Leave',
            onCanceled: () {},
          ),
        );
        if (context.mounted && shouldPop != null && shouldPop) {
          notifier.saveCurrentConversation(chatState.messages);
          Navigator.of(context).pop();
        } else {
          Navigator.of(context).pop();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          leading: InkWell(
            onTap: () {
              context.router.maybePop();
            },
            child: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.white,
            ),
          ),
          backgroundColor: const Color(0xFF0A0F26),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/icons/ai_icon.png',
                width: 32,
                height: 32,
              ),
              const SizedBox(width: 8),
              const Text(
                'Chat with AI',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF0A0F26), Color(0xFF171E41)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  reverse: true,
                  itemCount: chatState.messages.length,
                  itemBuilder: (context, index) {
                    final reversedIndex = chatState.messages.length - 1 - index;
                    final message = chatState.messages[reversedIndex];
                    return Align(
                      alignment: message.isUser ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 8.0,
                          vertical: 4.0,
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
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        chatState.isListening ? 'Listening...' : 'Tap microphone to speak',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.grey[300],
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
        ),
      ),
    );
  }
}
