import 'dart:io';

import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

/// Handles speech-to-text operations using the `speech_to_text` package.
class SpeechToTextDataSource {
  final stt.SpeechToText _speech = stt.SpeechToText();
  String? recognizedText;

  /// Initializes the speech-to-text service.
  ///
  /// Returns `true` if initialization is successful, otherwise `false`.
  Future<bool> initialize() async {
    return await _speech.initialize();
  }

  /// Starts listening for speech and updates the [chatController] with transcribed text.
  ///
  /// On Android:
  /// - [recognizedText] and [chatController] would be set directly
  ///
  /// On IOS:
  /// - Partial results are updated in the [chatController].
  /// - Final results clear the controller and set [recognizedText].
  Future<void> startListening(TextEditingController chatController) async {
    await _speech.listen(
      onResult: (result) {
        if (Platform.isAndroid) {
          recognizedText = result.recognizedWords;
          chatController.text = result.recognizedWords;
        } else {
          if (result.isConfident()) {
            chatController.text = result.recognizedWords;
          }

          if (result.finalResult && result.hasConfidenceRating) {
            recognizedText = chatController.text.toString();
            chatController.clear();
          }
        }
      },
    );
  }

  /// Stops listening for speech and returns the final transcribed text, if available.
  Future<String?> stopListening() async {
    await _speech.stop();
    final result = recognizedText;
    recognizedText = null;

    return result;
  }
}
