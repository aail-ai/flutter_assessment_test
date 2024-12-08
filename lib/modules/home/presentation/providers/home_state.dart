import 'package:flutter_assessment_test/modules/chat/domain/entities/chat_message_histories.dart';

class HomeState {
  final List<ChatMessageHistories> messageHistories;
  final bool isLoading;
  final String? error;

  HomeState({
    this.messageHistories = const [],
    this.isLoading = false,
    this.error,
  });

  HomeState copyWith({
    List<ChatMessageHistories>? messageHistories,
    bool? isLoading,
    String? error,
  }) {
    return HomeState(
      messageHistories: messageHistories ?? this.messageHistories,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
} 