import 'package:chat_bubbles/bubbles/bubble_special_three.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stt_app/core/theme/app_colors.dart';
import 'package:stt_app/domain/entities/chat/chat_message.dart';
import 'package:stt_app/presentation/providers/chat/chat_provider.dart';
import 'package:stt_app/presentation/widgets/mic_button.dart';

/// The main chat screen displaying a user chat interface.
class ChatScreen extends StatelessWidget {
  final String user;

  const ChatScreen({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          user,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: AppColors.white,
              ),
        ),
      ),
      body: const SafeArea(
        child: Column(
          children: [
            ListChatView(),
            MessageBar(),
          ],
        ),
      ),
    );
  }
}

/// Displays a list of chat messages in reverse order.
class ListChatView extends StatelessWidget {
  const ListChatView({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Consumer(
          builder: (context, ref, _) {
            final chatState = ref.watch(chatProvider);

            return ListView.builder(
              reverse: true,
              itemCount: chatState.messages.length,
              itemBuilder: (context, index) {
                final message =
                    chatState.messages.reversed.toList()[index]; // Reverse view

                return BubbleSpecialThree(
                  text: message.message,
                  color: message.sender == Sender.user
                      ? AppColors.primary
                      : AppColors.backgroundIcon,
                  tail: false,
                  isSender: message.sender == Sender.user,
                  textStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: message.sender == Sender.user
                            ? AppColors.white
                            : AppColors.primaryText,
                      ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

/// Displays the message input area with a microphone button.
class MessageBar extends StatelessWidget {
  const MessageBar({super.key});

  @override
  Widget build(BuildContext context) {
    final chatController = TextEditingController();

    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: TextField(
                controller: chatController,
                readOnly: true,
                minLines: 1,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: "Speak to chat...",
                  hintStyle: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: AppColors.primaryText.withOpacity(0.5),
                      ),
                  contentPadding: const EdgeInsets.all(10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(
                      color: AppColors.background,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Consumer(
            builder: (context, ref, _) {
              final chatState = ref.watch(chatProvider);

              return MicButton(
                isListening: chatState.isListening,
                onPressed: () {
                  if (chatState.isListening) {
                    ref
                        .read(chatProvider.notifier)
                        .stopListening(chatController);
                  } else {
                    ref
                        .read(chatProvider.notifier)
                        .startListening(chatController);
                  }
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
