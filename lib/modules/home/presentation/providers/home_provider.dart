import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_assessment_test/core/service_locator/service_locator.dart';
import 'package:flutter_assessment_test/modules/chat/domain/usecases/get_message_histories.dart';
import 'package:flutter_assessment_test/modules/home/presentation/notifiers/home_notifier.dart';
import 'package:flutter_assessment_test/modules/home/presentation/providers/home_state.dart';

final homeProvider = StateNotifierProvider<HomeNotifier, HomeState>((ref) {
  return HomeNotifier(getMessageHistories: getIt<GetMessageHistories>());
}); 