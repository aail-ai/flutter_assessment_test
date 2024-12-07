// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:speech_to_text/speech_to_text.dart' as _i941;

import '../../modules/chat/data/data_source/local/chat_local_dts.dart' as _i251;
import '../../modules/chat/data/data_source/local/chat_local_dts_impl.dart'
    as _i561;
import '../../modules/chat/data/repository_impls/chat_repo_impl.dart' as _i724;
import '../../modules/chat/domain/repositories/chat_repo.dart' as _i564;
import '../../modules/chat/domain/usecases/get_message_histories.dart' as _i589;
import '../../modules/chat/domain/usecases/save_message.dart' as _i928;
import 'modules/core_modules.dart' as _i235;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final coreModules = _$CoreModules();
    gh.lazySingleton<_i941.SpeechToText>(() => coreModules.speechToText);
    gh.factory<_i251.ChatLocalDts>(() => _i561.ChatLocalDtsImpl());
    gh.factory<_i564.ChatRepo>(
        () => _i724.ChatRepoImpl(chatLocalDts: gh<_i251.ChatLocalDts>()));
    gh.factory<_i589.GetMessageHistories>(
        () => _i589.GetMessageHistories(chatRepo: gh<_i564.ChatRepo>()));
    gh.factory<_i928.SaveMessage>(
        () => _i928.SaveMessage(chatRepo: gh<_i564.ChatRepo>()));
    return this;
  }
}

class _$CoreModules extends _i235.CoreModules {}
