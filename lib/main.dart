import 'package:flutter/material.dart';
import 'package:flutter_assessment_test/core/router/routes.dart';
import 'package:flutter_assessment_test/core/service_locator/service_locator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();

  final appRouter = ChatAppRouter();

  runApp(ProviderScope(child: ChatApp(appRouter: appRouter)));
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key, required this.appRouter});
  final ChatAppRouter appRouter;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerDelegate: appRouter.delegate(),
      routeInformationParser: appRouter.defaultRouteParser(),
    );
  }
}
