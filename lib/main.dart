import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stt_app/core/di/dependency_injection.dart';
import 'package:stt_app/core/theme/app_theme.dart';
import 'package:stt_app/presentation/screens/home/home_screen.dart';

void main() {
  // Initialize dependency injection.
  setupLocator();

  // Run the app with Riverpod provider scope.
  runApp(
    const ProviderScope(
      child: SttChatApp(),
    ),
  );
}

/// Main application widget.
class SttChatApp extends StatelessWidget {
  const SttChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'STT Chat App',
      theme: AppTheme.getTheme(),
      home: const HomeScreen(),
    );
  }
}
