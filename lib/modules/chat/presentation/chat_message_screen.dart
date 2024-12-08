// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_assessment_test/core/shared_widgets/dialogs/alert_dialog_with_icon.dart';
import 'package:flutter_assessment_test/modules/chat/domain/entities/chat_message_histories.dart';
import 'package:flutter_assessment_test/modules/chat/presentation/notifiers/chat_notifier.dart';
import 'package:flutter_assessment_test/modules/chat/presentation/notifiers/chat_state.dart';
import 'package:flutter_assessment_test/modules/chat/presentation/widgets/chat_bubble.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_assessment_test/modules/chat/presentation/providers/chat_provider.dart';

@RoutePage()
class ChatScreen extends ConsumerStatefulWidget {
  const ChatScreen({super.key, required this.initialData});
  final ChatMessageHistories? initialData;

  @override
  // ignore: library_private_types_in_public_api
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  late ChatNotifier notifier;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifier = ref.read(chatProvider.notifier);
      if (widget.initialData != null) {
        notifier.setMessages(widget.initialData!.chatMessages);
      } else {
        notifier.clearMessages();
      }
    });
  }

  Future<void> _handlePop(BuildContext context, ChatState chatState) async {
    final bool? shouldPop = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialogWithIcon(
        centeredTitle: true,
        title: 'Want to Save This Conversation?',
        description: 'You can save this conversation for future reference. It will be saved in your device storage.',
        onConfirmText: 'Save',
        onConfirmed: () => Navigator.of(context).pop(true),
        onCanceledText: 'Just Leave',
        onCanceled: () {},
      ),
    );

    if (context.mounted && shouldPop != null && shouldPop) {
      await notifier.saveCurrentConversation(chatState.messages);
      notifier.clearMessages();
      Navigator.of(context).pop(true);
    } else {
      Navigator.of(context).pop(false);
      notifier.clearMessages();
    }
  }

  @override
  Widget build(BuildContext context) {
    final chatState = ref.watch(chatProvider);
    return PopScope(
      canPop: chatState.messages.isEmpty || widget.initialData != null,
      onPopInvoked: (didPop) async {
        if (didPop) {
          return;
        }
        await _handlePop(context, chatState);
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: false,
          backgroundColor: const Color(0xFF0A0F26),
          leading: InkWell(
            onTap: () {
              context.router.maybePop();
            },
            child: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.white,
            ),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
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
        body: Stack(
          children: [
            Container(
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
                          child: ChatBubble(message: message),
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
                            widget.initialData != null
                                ? 'Currently you can only view the conversation, not able to send message'
                                : chatState.isListening
                                    ? 'Listening...'
                                    : 'Tap microphone to speak',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.grey[300],
                            ),
                          ),
                        ),
                        if (widget.initialData == null)
                          FloatingActionButton(
                            backgroundColor: const Color.fromARGB(255, 7, 52, 119),
                            onPressed: () {
                              if (chatState.isListening) {
                                notifier.stopListening();
                              } else {
                                notifier.startListening();
                              }
                            },
                            child: Icon(
                              chatState.isListening ? Icons.stop : Icons.mic,
                              color: Colors.white,
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            if (chatState.isLoading)
              Positioned.fill(
                child: Container(
                  color: Colors.black54,
                  child: const Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
