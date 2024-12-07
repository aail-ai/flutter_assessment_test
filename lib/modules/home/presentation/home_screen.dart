import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_assessment_test/core/router/routes.gr.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chats'),
      ),
      body: ListView.builder(
        itemCount: 20, // This should be the number of chats
        itemBuilder: (context, index) {
          return ListTile(
            leading: const CircleAvatar(
              child: Icon(Icons.person),
            ),
            title: Text('Chat $index'),
            subtitle: Text('Last message from chat $index'),
            onTap: () {
              // Navigate to chat screen
              // context.router.push(ChatScreenRoute(chatId: index));
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to new chat screen
          context.router.push(ChatRoute());
        },
        child: const Icon(Icons.chat),
      ),
    );
  }
}
