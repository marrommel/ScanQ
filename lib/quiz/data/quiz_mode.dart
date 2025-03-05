import 'package:flutter/cupertino.dart';

import '../ui/activity_input_quiz.dart';
import '../ui/activity_listening_quiz.dart';
import '../ui/activity_multiple_choice.dart';

enum QuizMode { MULTIPLE_CHOICE, INPUT, VOICE, comingSoon }

extension QuizModeExtension on QuizMode {
  Widget get activity {
    switch (this) {
      case QuizMode.MULTIPLE_CHOICE:
        return ActivityMultipleChoice();
      case QuizMode.INPUT:
        return ActivityInputQuiz();
      case QuizMode.VOICE:
        return ActivityListeningQuiz();
      default:
        throw Exception("No activity found for selected quiz mode: $this");
    }
  }
}
