import '../ui/activity_quiz_settings.dart';

class QuizConfig {
  final int _categoryId;
  final int _totalQuestions;
  final bool _reverseTranslation;
  final bool _caseSensitive;
  final bool _hintsEnabled;
  final bool _onlyUntrained;
  final bool _autoContinue;
  final TtsSpeed _speechRate;

  QuizConfig(this._categoryId, this._totalQuestions, this._reverseTranslation, this._caseSensitive, this._hintsEnabled,
      this._autoContinue, this._onlyUntrained, this._speechRate);

  int get categoryId => _categoryId;

  int get totalQuestions => _totalQuestions;

  bool get reverseTranslation => _reverseTranslation;

  bool get caseSensitive => _caseSensitive;

  bool get hintsEnabled => _hintsEnabled;

  bool get autoContinue => _autoContinue;

  bool get onlyUntrained => _onlyUntrained;

  int get speechRate => _speechRate.index;
}
