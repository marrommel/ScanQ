import 'dart:developer' as developer;
import 'dart:io' show Platform;

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_tts/flutter_tts.dart';

class VoiceOutput {
  late FlutterTts tts;
  String language;
  double volume = 0.5;
  double pitch = 1.0;
  double rate = 0.5;

  TtsState ttsState = TtsState.stopped;

  bool get isPlaying => ttsState == TtsState.playing;

  bool get isStopped => ttsState == TtsState.stopped;

  bool get isPaused => ttsState == TtsState.paused;

  bool get isContinued => ttsState == TtsState.continued;

  bool get isIOS => !kIsWeb && Platform.isIOS;

  bool get isAndroid => !kIsWeb && Platform.isAndroid;

  bool get isWindows => !kIsWeb && Platform.isWindows;

  bool get isWeb => kIsWeb;

  VoiceOutput({required this.language});

  Future initTts() async {
    tts = FlutterTts();

    await tts.awaitSpeakCompletion(true);

    if (isAndroid) {
      await tts.getDefaultEngine;
      await tts.getDefaultVoice;
    }

    tts.setStartHandler(() {
      ttsState = TtsState.playing;
    });

    tts.setCompletionHandler(() {
      ttsState = TtsState.stopped;
    });

    tts.setCancelHandler(() {
      ttsState = TtsState.stopped;
    });

    if (isWeb || isIOS || isWindows) {
      tts.setPauseHandler(() {
        ttsState = TtsState.paused;
      });

      tts.setContinueHandler(() {
        ttsState = TtsState.continued;
      });
    }

    tts.setErrorHandler((message) {
      developer.log(message, name: "com.rommelbendel.scanQ.speech");
      ttsState = TtsState.stopped;
    });
  }

  Future speak(final String text, final Function? onComplete) async {
    if (text.trim().isNotEmpty) {
      await tts.setVolume(volume);
      await tts.setSpeechRate(rate);
      await tts.setPitch(pitch);
      await tts.setLanguage(language);

      if (onComplete != null) {
        tts.setCompletionHandler(() => onComplete());
      }
      await tts.speak(text);
    }
  }

  Future speakInLanguage(final String text, final String language, final Function? onComplete) async {
    this.language = language;
    speak(text, onComplete);
  }

  // Future<dynamic> getLanguages() => tts.getLanguages;

  setLanguage(final String language) => this.language = language;
}

enum TtsState { playing, stopped, paused, continued }
