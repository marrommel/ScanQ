class QuizItem {
  final int _vocabularyId;
  final String _question;
  final String _correctAnswer;
  String givenAnswer = "";

  QuizItem(this._vocabularyId, this._question, this._correctAnswer);

  int get vocId => _vocabularyId;

  String get correctAnswer => _correctAnswer;

  String get question => _question;

  bool get isCorrect => givenAnswer == correctAnswer;

  bool get isCorrectCaseInsensitive => givenAnswer.toLowerCase() == correctAnswer.toLowerCase();
}
