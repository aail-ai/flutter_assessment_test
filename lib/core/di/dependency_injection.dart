import 'package:get_it/get_it.dart';
import 'package:stt_app/data/datasources/speech_to_text/speech_to_text_datasource.dart';
import 'package:stt_app/data/repositories/chat/chat_repository_impl.dart';
import 'package:stt_app/domain/repositories/chat/chat_repository.dart';
import 'package:stt_app/domain/usecases/chat/add_user_message_usecase.dart';
import 'package:stt_app/domain/usecases/chat/get_dummy_reply_usecase.dart';
import 'package:stt_app/domain/usecases/chat/start_listening_usecase.dart';
import 'package:stt_app/domain/usecases/chat/stop_listening_usecase.dart';

final getIt = GetIt.instance;

void setupLocator() {
  // Register Data Source
  getIt.registerLazySingleton<SpeechToTextDataSource>(
      () => SpeechToTextDataSource());

  // Register Repository
  getIt.registerLazySingleton<ChatRepository>(() => ChatRepositoryImpl(
        getIt<SpeechToTextDataSource>(),
      ));

  // Register Use Cases
  getIt.registerLazySingleton(() => AddUserMessageUseCase(
        getIt<ChatRepository>(),
      ));
  getIt.registerLazySingleton(() => GetDummyReplyUseCase(
        getIt<ChatRepository>(),
      ));
  getIt.registerLazySingleton(() => StartListeningUsecase(
        getIt<ChatRepository>(),
      ));
  getIt.registerLazySingleton(() => StopListeningUsecase(
        getIt<ChatRepository>(),
      ));
}
