import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:scanq_multiplatform/quiz/data/quiz_config.dart';
import 'package:scanq_multiplatform/quiz/data/quiz_item.dart';
import 'package:scanq_multiplatform/quiz/data/quiz_mode.dart';

import '../../database/database.dart';
import '../ui/activity_quiz_result.dart';

class QuizMetadata {
  int _questionIndex = 0;
  int _score = 0;

  /// Indicates if the user has used a hint for the current question
  bool _hintUsed = false;

  final int _totalQuestions;
  final List<QuizItem> _quizItems;
  final QuizConfig config;
  final QuizMode mode;

  QuizMetadata(this.config, this.mode, this._quizItems) : _totalQuestions = _quizItems.length;

  /// GETTER
  int get questionIndex => _questionIndex;

  int get totalQuestions => _totalQuestions;

  int get score => _score;

  QuizItem get quizItem => _quizItems[_questionIndex];

  bool get isAnswered => quizItem.givenAnswer != "";

  bool get isLast => questionIndex == _totalQuestions - 1;

  bool get hintUsed => _hintUsed;

  String get hintLetter {
    if (quizItem.correctAnswer.substring(0, 3) == "to ") {
      return quizItem.correctAnswer.substring(0, 4);
    }
    return quizItem.correctAnswer.substring(0, 1);
  }

  /// SETTER
  set useHint(bool value) {
    _hintUsed = value;
  }

  /// METHODS
  bool incrementScoreIfCorrect(String answer) {
    // store the given answer
    quizItem.givenAnswer = answer;

    // only check with case if quiz is configured as case sensitive
    bool isCorrect;
    if (config.caseSensitive) {
      isCorrect = quizItem.correctAnswer == answer;
    } else {
      isCorrect = quizItem.correctAnswer.toLowerCase() == answer.toLowerCase();
    }

    // update the answer count in db
    final Database db = Modular.get<Database>();
    if (isCorrect) {
      // increment the score if the right answer was given
      _score++;

      // increment the right answer count in the database
      db.addRightAnswer(quizItem.vocId);
    } else {
      // increment the right answer count in the database
      db.addWrongAnswer(quizItem.vocId);
    }

    // return if a point has been scored
    return isCorrect;
  }

  bool nextQuestion() {
    // check if there still questions left to play
    if (_questionIndex < _totalQuestions - 1) {
      // set the index to the next question
      _questionIndex++;
      return true;
    }

    // return false if all questions have been answered
    return false;
  }

  void skipQuestion() {
    if (_quizItems.isNotEmpty && _questionIndex < _totalQuestions) {
      _quizItems.add(_quizItems.removeAt(_questionIndex));
      _hintUsed = false;
    }
  }

  void showResultScreen(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) => ActivityQuizResult(score: _score, quizResults: _quizItems, quizConfig: config, quizMode: mode),
      ),
    );
  }
}
