import 'dart:math';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:scanq_multiplatform/quiz/data/quiz_config.dart';
import 'package:scanq_multiplatform/quiz/data/quiz_item.dart';

import '../../database/database.dart';
import '../data/multiple_choice_item.dart';

class QuizVocabularyLoader {
  List<Vocabulary> vocabularyList = [];
  QuizConfig config;

  QuizVocabularyLoader(this.config);

  // Async method to load vocabulary
  Future<void> loadVocabulary() async {
    final Database db = Modular.get<Database>();

    if (config.onlyUntrained) {
      vocabularyList = await db.someCategoryVocabularies(config.categoryId, config.totalQuestions).get();
    } else {
      vocabularyList = await db.someUntrainedCategoryVocabularies(config.categoryId, config.totalQuestions).get();
    }
  }

  // Method to generate input quiz questions from the loaded vocabulary
  List<QuizItem> generateQuizQuestions() {
    List<QuizItem> quizQuestionList = [];

    // Generate a set of quiz questions
    for (Vocabulary vocab in vocabularyList) {
      if (config.reverseTranslation) {
        quizQuestionList.add(QuizItem(vocab.id, vocab.vocForeign, vocab.vocLocal));
      } else {
        quizQuestionList.add(QuizItem(vocab.id, vocab.vocLocal, vocab.vocForeign));
      }
    }

    return quizQuestionList;
  }

  // Method to generate multiple choice questions from the loaded vocabulary
  List<MultipleChoiceItem>? generateMultipleChoiceQuestions() {
    if (vocabularyList.length < 4) return null;

    List<MultipleChoiceItem> multipleChoiceList = [];

    // Generate a set of 10 multiple-choice questions
    for (Vocabulary vocab in vocabularyList) {
      if (config.reverseTranslation) {
        Set<String> wrongAnswers = _getWrongAnswers(vocabularyList, vocab.vocLocal);
        multipleChoiceList.add(MultipleChoiceItem(vocab.id, vocab.vocForeign, vocab.vocLocal, wrongAnswers));
      } else {
        Set<String> wrongAnswers = _getWrongAnswers(vocabularyList, vocab.vocForeign);
        multipleChoiceList.add(MultipleChoiceItem(vocab.id, vocab.vocLocal, vocab.vocForeign, wrongAnswers));
      }
    }

    return multipleChoiceList;
  }

  // Helper method to randomly select 3 wrong answers
  Set<String> _getWrongAnswers(List<Vocabulary> vocabularyList, String correctAnswer) {
    Random random = Random();
    Set<String> wrongAnswers = {};
    while (wrongAnswers.length < 3) {
      // Randomly select from the list of translations, making sure it's not the correct one
      Vocabulary voc = vocabularyList[random.nextInt(vocabularyList.length)];

      String wrongAnswer = voc.vocForeign;
      if (config.reverseTranslation) {
        wrongAnswer = voc.vocLocal;
      }

      if (wrongAnswer != correctAnswer) {
        wrongAnswers.add(wrongAnswer);
      }
    }
    return wrongAnswers;
  }
}
