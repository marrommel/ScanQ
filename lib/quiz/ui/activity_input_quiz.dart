import 'dart:async';
import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:scanq_multiplatform/quiz/ui/widgets/widget_quiz_header.dart';
import 'package:scanq_multiplatform/quiz/ui/widgets/widget_top_curve.dart';

import '../../common/data/brand_colors.dart';
import '../data/quiz_config.dart';
import '../data/quiz_item.dart';
import '../data/quiz_metadata.dart';
import '../data/quiz_mode.dart';
import '../logic/quiz_vocabulary_loader.dart';

class ActivityInputQuiz extends StatefulWidget {
  final QuizConfig config;

  const ActivityInputQuiz({super.key, required this.config});

  @override
  _ActivityInputQuizState createState() => _ActivityInputQuizState();
}

// TODO: resize font to fit text in question

class _ActivityInputQuizState extends State<ActivityInputQuiz> {
  late QuizMetadata _metadata;
  bool _isDataLoaded = false;

  /// Controller for the user's text input
  final TextEditingController _inputController = TextEditingController();

  /// A timer to automatically move to the next question after a short delay
  Timer? _timer;

  /// Submit button label changes as the user types and after an answer is given
  String submitButtonText = "Später antworten";

  /// Submit button will be disabled while the input is empty if this is the last question
  bool isSkipButtonEnabled = true;

  /// Indicate the first use of the hint to clear any potential input
  bool isFirstHintUse = false;

  @override
  void initState() {
    super.initState();
    _loadVocabulary();
  }

  Future<void> _loadVocabulary() async {
    // Load or generate your input-based quiz items
    QuizVocabularyLoader loader = QuizVocabularyLoader(widget.config);
    await loader.loadVocabulary();

    // Assume generateInputQuestions() returns List<InputQuizItem>
    List<QuizItem> inputQuizItems = loader.generateQuizQuestions();
    _metadata = QuizMetadata(widget.config, QuizMode.INPUT, inputQuizItems);

    setState(() {
      _isDataLoaded = true;
    });
  }

  void _onSubmitAnswer() {
    final String userAnswer = _inputController.text.trim();
    if (_metadata.isAnswered || userAnswer.trim().isEmpty) return;

    // give a point for a correct answer
    _metadata.incrementScoreIfCorrect(userAnswer);

    submitButtonText = _metadata.isLast ? "Beenden" : "Nächste Frage";
    setState(() => {});

    // Move to next question after 0.8 seconds if correct and after 1.5 seconds if wrong
    if (widget.config.autoContinue) {
      bool isCorrect = widget.config.caseSensitive ? _metadata.quizItem.isCorrect : _metadata.quizItem.isCorrectCaseInsensitive;
      int skipDuration = isCorrect ? 800 : 1500;
      _timer = Timer(Duration(milliseconds: skipDuration), () => _nextQuestion(false));
    }
  }

  void _showHint() {
    if (_metadata.isAnswered) return;

    final currentQuestion = _metadata.quizItem;
    if (currentQuestion.correctAnswer.trim().isNotEmpty) {
      _inputController.text = _metadata.hintLetter;
      submitButtonText = "weiter";
      _metadata.useHint = true;
      setState(() => {});
    }
  }

  void _nextQuestion(bool immediately) {
    // stop any time if the next question shall be immediately displayed
    if (immediately) _timer?.cancel();

    // try to load the next question
    if (!_metadata.nextQuestion()) {
      // show the result screen if all questions have been answered
      _metadata.showResultScreen(context);
    }

    // reset the skip button
    submitButtonText = _metadata.isLast ? "Beenden" : "Später antworten";

    // reset the input field, hint, etc.
    _inputController.clear();
    _metadata.useHint = false;
    setState(() => {});

    // check the submit button state for the last question to disable skipping
    if (_metadata.isLast) _evaluateSubmitText();
  }

  void _evaluateSubmitText() {
    if (_metadata.isAnswered) return;

    bool isInputFilled = _inputController.text.trim().isNotEmpty;
    final newText = isInputFilled ? "weiter" : "Später antworten";

    isSkipButtonEnabled = !_metadata.isLast || isInputFilled;
    submitButtonText = newText;
    setState(() => {});
  }

  @override
  Widget build(BuildContext context) {
    // Show loading indicator if data is still being loaded
    if (!_isDataLoaded) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final currentQuestion = _metadata.quizItem;
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    bool isCorrect = widget.config.caseSensitive ? _metadata.quizItem.isCorrect : _metadata.quizItem.isCorrectCaseInsensitive;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            QuizHeader(metadata: _metadata),
            const Spacer(),
            const Text(
              "Übersetze",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, color: Colors.grey),
            ),
            const SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: AutoSizeText(
                currentQuestion.question,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                maxLines: 3,
                minFontSize: 20,
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: BrandColors.colorPrimaryDark,
                ),
              ),
            ),
            const Spacer(),
            TopCurve(),
            Stack(
              children: [
                Positioned.fill(
                  child: Container(color: BrandColors.colorPrimary),
                ),
                ClipRect(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 30),
                      // The user input text field
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                        child: Stack(
                          children: [
                            // 1) The actual TextField where the user types
                            TextField(
                              controller: _inputController,
                              // Make the typed text invisible (or transparent)
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: _metadata.isAnswered ? FontWeight.bold : FontWeight.normal,
                                color: Colors.white,
                              ),
                              onSubmitted: (_) => _onSubmitAnswer(),
                              onChanged: (_) => _evaluateSubmitText(),
                              showCursor: !_metadata.hintUsed,
                              enableInteractiveSelection: !_metadata.hintUsed,
                              autocorrect: false,
                              enableSuggestions: false,
                              readOnly: _metadata.isAnswered,
                              enabled: !_metadata.isAnswered,
                              decoration: InputDecoration(
                                hintText: "Deine Antwort...",
                                hintStyle: const TextStyle(fontSize: 18),
                                contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                                fillColor: _metadata.isAnswered ? (isCorrect ? Colors.green : Colors.red) : Colors.white,
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide.none,
                                ),
                                disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(color: Colors.white54, width: 3),
                                ),
                              ),
                            ),

                            _metadata.isAnswered
                                ? SizedBox(height: 1)
                                : Positioned.fill(
                                    child: IgnorePointer(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                                        child: RichText(
                                          text: () {
                                            // Decide how to style based on whether hint is used
                                            // and whether there's at least one character typed.
                                            final text = _inputController.text;
                                            if (!_metadata.hintUsed) {
                                              return TextSpan(
                                                text: text,
                                                style: const TextStyle(color: Colors.black, fontSize: 18),
                                              );
                                            } else {
                                              if (text.trim().isEmpty) _inputController.text = _metadata.hintLetter;
                                              return TextSpan(
                                                children: [
                                                  TextSpan(
                                                    text: _metadata.hintLetter,
                                                    style: TextStyle(
                                                      color: BrandColors.colorPrimaryDark,
                                                      letterSpacing: 1,
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                                  if (text.length > 1)
                                                    TextSpan(
                                                      text: text.substring(_metadata.hintLetter.length),
                                                      style: const TextStyle(color: Colors.black, fontSize: 18),
                                                    ),
                                                ],
                                              );
                                            }
                                          }(),
                                        ),
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      (_metadata.isAnswered)
                          ? ElevatedButton(
                              onPressed: () => _nextQuestion(true),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: (_inputController.text.trim().isNotEmpty) ? Colors.white : Colors.grey[400],
                                foregroundColor: Colors.black,
                                padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                              ),
                              child: Text(
                                "Nächste Frage",
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                            )
                          : Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                              const SizedBox(width: 20),
                              ElevatedButton(
                                onPressed: () => setState(() {
                                  _inputController.text = "";
                                  isFirstHintUse = false;
                                  _metadata.skipQuestion();
                                }),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: isSkipButtonEnabled ? Colors.white : Colors.grey[400],
                                  foregroundColor: Colors.black,
                                  padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                ),
                                child: Text(
                                  "Später",
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () => _onSubmitAnswer(),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: (_inputController.text.trim().isNotEmpty) ? Colors.white : Colors.grey[400],
                                  foregroundColor: Colors.black,
                                  padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                ),
                                child: Text(
                                  "Antworten",
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                              ),
                              const SizedBox(width: 20),
                            ]),
                      // TODO: work on bottom overflow
                      SizedBox(height: max(0, 140 - keyboardHeight)),

                      if (widget.config.hintsEnabled)
                        TextButton(
                          onPressed: (_metadata.hintUsed) ? null : _showHint,
                          child: Text(
                            "Hinweis anzeigen",
                            style: TextStyle(
                              color: (_metadata.hintUsed) ? Colors.white54 : Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
