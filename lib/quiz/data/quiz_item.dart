class QuizItem {
  final String _question;
  final String _correctAnswer;
  String givenAnswer = "";

  QuizItem(this._question, this._correctAnswer);

  String get correctAnswer => _correctAnswer;

  String get question => _question;

  bool get isCorrect => givenAnswer.trim() == correctAnswer;
}
