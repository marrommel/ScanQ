import 'dart:math';

import 'package:flutter_modular/flutter_modular.dart';
import 'package:scanq_multiplatform/quiz/data/quiz_item.dart';

import '../../database/database.dart';
import '../data/multiple_choice_item.dart';

class QuizVocabularyLoader {
  List<Vocabulary> vocabularyList = [];

  // Async method to load vocabulary
  Future<void> loadVocabulary() async {
    final Database db = Modular.get<Database>();
    vocabularyList = await db.allCategoryVocabularies(3).get();
  }

  // Method to generate input quiz questions from the loaded vocabulary
  List<QuizItem> generateInputQuizQuestions() {
    List<QuizItem> inputQuizList = [];

    // Generate a set of 10 multiple-choice questions
    for (Vocabulary vocab in vocabularyList) {
      inputQuizList.add(QuizItem(vocab.vocLocal, vocab.vocForeign));

      if (inputQuizList.length == 10) break;
    }

    return inputQuizList;
  }

  // Method to generate input quiz questions from the loaded vocabulary
  List<QuizItem> generateListeningQuizQuestions() {
    List<QuizItem> listeningQuizList = [];

    // Generate a set of 10 multiple-choice questions
    for (Vocabulary vocab in vocabularyList) {
      listeningQuizList.add(QuizItem(vocab.vocForeign, vocab.vocForeign));

      if (listeningQuizList.length == 10) break;
    }

    return listeningQuizList;
  }

  // Method to generate multiple choice questions from the loaded vocabulary
  List<MultipleChoiceItem> generateMultipleChoiceQuestions() {
    List<MultipleChoiceItem> multipleChoiceList = [];

    // Generate a set of 10 multiple-choice questions
    for (Vocabulary vocab in vocabularyList) {
      Set<String> wrongAnswers = _getWrongAnswers(vocabularyList, vocab.vocForeign);
      multipleChoiceList.add(MultipleChoiceItem(vocab.vocLocal, vocab.vocForeign, wrongAnswers));

      if (multipleChoiceList.length == 10) break;
    }

    return multipleChoiceList;
  }

  // Helper method to randomly select 3 wrong answers
  Set<String> _getWrongAnswers(List<Vocabulary> vocabularyList, String correctAnswer) {
    Random random = Random();
    Set<String> wrongAnswers = {};
    while (wrongAnswers.length < 3) {
      // Randomly select from the list of translations, making sure it's not the correct one
      String wrongAnswer = vocabularyList[random.nextInt(vocabularyList.length)].vocForeign;
      if (wrongAnswer != correctAnswer) {
        wrongAnswers.add(wrongAnswer);
      }
    }
    return wrongAnswers;
  }
}
