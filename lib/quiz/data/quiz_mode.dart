import 'package:flutter/cupertino.dart';
import 'package:scanq_multiplatform/quiz/data/quiz_config.dart';
import 'package:scanq_multiplatform/quiz/ui/activity_multiple_choice.dart';

import '../../gen/l10n/app_localizations.dart';
import '../ui/activity_input_quiz.dart';
import '../ui/activity_listening_quiz.dart';

enum QuizMode { MULTIPLE_CHOICE, INPUT, LISTENING, comingSoon }

extension QuizModeExtension on QuizMode {
  String title(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final quizNames = [loc.mpcQuizName, loc.inputQuizName, loc.listeningQuizName];
    return quizNames[index];
  }

  Widget activity(QuizConfig config) {
    switch (this) {
      case QuizMode.MULTIPLE_CHOICE:
        return ActivityMultipleChoice(config: config);
      case QuizMode.INPUT:
        return ActivityInputQuiz(config: config);
      case QuizMode.LISTENING:
        return ActivityListeningQuiz(config: config);
      default:
        throw Exception("No activity found for selected quiz mode: $this");
    }
  }
}
