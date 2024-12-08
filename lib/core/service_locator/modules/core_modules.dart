import 'package:injectable/injectable.dart';
import 'package:speech_to_text/speech_to_text.dart';

@module
abstract class CoreModules {
  @lazySingleton
  SpeechToText get speechToText => SpeechToText();


}
