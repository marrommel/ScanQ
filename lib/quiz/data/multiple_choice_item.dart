import 'dart:math';

import 'package:scanq_multiplatform/quiz/data/quiz_item.dart';

class MultipleChoiceItem extends QuizItem {
  final List<String> _choices;

  MultipleChoiceItem(super.question, super.correctAnswer, Set<String> wrongAnswers)
      : _choices = [...wrongAnswers, correctAnswer]..shuffle(Random());

  List<String> get getChoices => _choices;
}
