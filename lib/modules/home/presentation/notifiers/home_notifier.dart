import 'package:flutter_assessment_test/core/extension/resource_ext.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_assessment_test/modules/chat/domain/usecases/get_message_histories.dart';
import 'package:flutter_assessment_test/modules/home/presentation/providers/home_state.dart';

class HomeNotifier extends StateNotifier<HomeState> {
  final GetMessageHistories _getMessageHistories;

  HomeNotifier({
    required GetMessageHistories getMessageHistories,
  })  : _getMessageHistories = getMessageHistories,
        super(HomeState()) {
    getMessages();
  }

  Future<void> getMessages() async {
    state = state.copyWith(isLoading: true);
    await Future.delayed(const Duration(seconds: 1));
    final result = await _getMessageHistories();

    result.when(
      success: (messages) {
        state = state.copyWith(
          messageHistories: messages.reversed.toList(),
          isLoading: false,
        );
      },
      error: (error) {
        state = state.copyWith(
          error: error.toString(),
          isLoading: false,
        );
      },
    );
  }
}
