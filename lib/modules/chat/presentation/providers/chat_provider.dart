import 'package:flutter_assessment_test/core/service_locator/service_locator.dart';
import 'package:flutter_assessment_test/modules/chat/domain/usecases/save_message.dart';
import 'package:flutter_assessment_test/modules/chat/presentation/notifiers/chat_notifier.dart';
import 'package:flutter_assessment_test/modules/chat/presentation/notifiers/chat_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:speech_to_text/speech_to_text.dart';

final chatProvider = StateNotifierProvider<ChatNotifier, ChatState>((ref) {
  return ChatNotifier(getIt<SaveMessage>(), getIt<SpeechToText>());
});
