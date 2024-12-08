import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_assessment_test/core/router/routes.gr.dart';
import 'package:flutter_assessment_test/modules/home/presentation/providers/home_provider.dart';

@RoutePage()
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat App'),
        backgroundColor: const Color(0xFF0A0F26),
        foregroundColor: Colors.white,
      ),
      body: homeState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : homeState.error != null
              ? Center(child: Text('Error: ${homeState.error}'))
              : RefreshIndicator(
                  onRefresh: () async => ref.read(homeProvider.notifier).getMessages(),
                  child: homeState.messageHistories.isEmpty
                      ? const Center(child: Text('No chat history yet'))
                      : ListView.builder(
                          itemCount: homeState.messageHistories.length,
                          itemBuilder: (context, index) {
                            final history = homeState.messageHistories[index];
                            final lastMessage =
                                history.chatMessages.isNotEmpty ? history.chatMessages.last.text : 'No messages';

                            return ListTile(
                              leading: const CircleAvatar(
                                backgroundColor: Color(0xFF0A0F26),
                                child: Icon(Icons.chat, color: Colors.white),
                              ),
                              title: Text('Chat ${index + 1}'),
                              subtitle: Text(lastMessage),
                              trailing: Text(
                                '${history.timestamp.day}/${history.timestamp.month}/${history.timestamp.year}',
                                style: TextStyle(color: Colors.grey[600]),
                              ),
                              onTap: () {
                                context.router.push(ChatRoute(initialData: history));
                              },
                            );
                          },
                        ),
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final shouldRefresh = await context.router.push(ChatRoute(initialData: null));
          if (shouldRefresh == true) {
            ref.read(homeProvider.notifier).getMessages();
          }
        },
        backgroundColor: const Color(0xFF0A0F26),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
