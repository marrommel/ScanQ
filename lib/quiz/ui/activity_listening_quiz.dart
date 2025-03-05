import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:lottie/lottie.dart';
import 'package:scanq_multiplatform/quiz/ui/widgets/widget_quiz_header.dart';
import 'package:scanq_multiplatform/quiz/ui/widgets/widget_top_curve.dart';

import '../../common/brand_colors.dart';
import '../data/quiz_item.dart';
import '../data/quiz_metadata.dart';
import '../logic/quiz_vocabulary_loader.dart';

class ActivityListeningQuiz extends StatefulWidget {
  const ActivityListeningQuiz({super.key});

  @override
  _ActivityListeningQuizState createState() => _ActivityListeningQuizState();
}

class _ActivityListeningQuizState extends State<ActivityListeningQuiz> {
  late QuizMetadata _metadata;
  bool _isDataLoaded = false;

  // Controller for the user’s text input
  final TextEditingController _inputController = TextEditingController();

  // Timer to automatically move to the next question after a short delay
  Timer? _timer;

  // Submit button label changes as the user types and after an answer is given
  String submitButtonText = "Später antworten";

  // Submit button will be disabled while the input is empty if this is the last question
  bool isSubmitButtonEnabled = true;

  // Indicate the first use of the hint to clear any potential input
  bool isFirstHintUse = false;

  // Add a FlutterTts instance to handle text-to-speech
  final FlutterTts _flutterTts = FlutterTts();

  @override
  void initState() {
    super.initState();
    _loadVocabulary();
  }

  Future<void> _loadVocabulary() async {
    QuizVocabularyLoader loader = QuizVocabularyLoader();
    await loader.loadVocabulary();

    List<QuizItem> inputQuizItems = loader.generateListeningQuizQuestions();
    _metadata = QuizMetadata(inputQuizItems);

    setState(() {
      _isDataLoaded = true;
    });

    // Once data is loaded, read the first question after 0.5s
    _autoReadCurrentQuestion();
  }

  // Reads the current question aloud (e.g. the English word).
  Future<void> _speak(String text) async {
    // Adjust TTS settings as desired, e.g.:
    await _flutterTts.setLanguage("en-US");
    await _flutterTts.setSpeechRate(0.5);
    await _flutterTts.speak(text);
  }

  // Call this after loading or moving to the next question
  void _autoReadCurrentQuestion() {
    // Small delay before starting TTS
    Timer(const Duration(milliseconds: 500), () {
      if (mounted && !_metadata.isAnswered) {
        _speak(_metadata.quizItem.question);
      }
    });
  }

  void _onSubmitAnswer() {
    if (_metadata.isAnswered) return;

    final String userAnswer = _inputController.text.trim();
    _metadata.incrementScoreIfCorrect(userAnswer);

    submitButtonText = _metadata.isLast ? "Beenden" : "Nächste Frage";
    setState(() => {});

    // Move to next question after 0.8 seconds if correct and 1.5 seconds if wrong
    int skipDuration = (_metadata.quizItem.isCorrect) ? 800 : 1500;
    _timer = Timer(Duration(milliseconds: skipDuration), () => _nextQuestion(false));
  }

  void _showHint() {
    if (_metadata.isAnswered) return;

    final currentQuestion = _metadata.quizItem;
    if (currentQuestion.correctAnswer.isNotEmpty) {
      _inputController.text = _metadata.hintLetter;
      _metadata.useHint = true;
      setState(() => {});
    }
  }

  void _nextQuestion(bool immediately) {
    // Stop any timer if the next question shall be immediately displayed
    if (immediately) _timer?.cancel();

    // Try to load the next question
    if (!_metadata.nextQuestion()) {
      // show the result screen if all questions have been answered
      _metadata.showResultScreen(context);
      return;
    }

    // Reset the skip button
    submitButtonText = _metadata.isLast ? "Beenden" : "Später antworten";

    // Reset the input field, hint, etc.
    _inputController.clear();
    _metadata.useHint = false;
    setState(() => {});

    // If this is the last question, re-evaluate the submit text
    if (_metadata.isLast) _evaluateSubmitText();

    // Read aloud the new question
    _autoReadCurrentQuestion();
  }

  void _evaluateSubmitText() {
    if (_metadata.isAnswered) return;

    bool isInputFilled = _inputController.text.trim().isNotEmpty;
    final newText = isInputFilled ? "weiter" : "Später antworten";

    isSubmitButtonEnabled = !_metadata.isLast || isInputFilled;
    submitButtonText = newText;
    setState(() => {});
  }

  @override
  void dispose() {
    _timer?.cancel();
    _flutterTts.stop(); // stop TTS if needed
    super.dispose();
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

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Keep the quiz header (progress, hearts, etc.) if desired
            QuizHeader(metadata: _metadata),

            const Spacer(),
            GestureDetector(
              onTap: () => _speak(currentQuestion.question),
              child: SizedBox(
                height: 220,
                width: 220,
                child: Lottie.asset(
                  "assets/animation/voice_blob.json",
                  fit: BoxFit.contain,
                  repeat: true,
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
                Column(
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
                              fillColor:
                                  _metadata.isAnswered ? (currentQuestion.isCorrect ? Colors.green : Colors.red) : Colors.white,
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

                          // 2) Overlay that shows the hint letter if hint is used
                          _metadata.isAnswered
                              ? const SizedBox(height: 1)
                              : Positioned.fill(
                                  child: IgnorePointer(
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                                      child: RichText(
                                        text: () {
                                          final text = _inputController.text;
                                          if (!_metadata.hintUsed) {
                                            return TextSpan(
                                              text: text,
                                              style: const TextStyle(color: Colors.black, fontSize: 18),
                                            );
                                          } else {
                                            if (text.isEmpty) {
                                              _inputController.text = _metadata.hintLetter;
                                            }
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
                                                    text: text.substring(1),
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

                    // Submit / Skip / Next Button
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: ElevatedButton(
                        onPressed: () {
                          if (_inputController.text.trim().isNotEmpty) {
                            // If user typed something, either submit or go next if already answered
                            (_metadata.isAnswered) ? _nextQuestion(true) : _onSubmitAnswer();
                          } else {
                            // If empty, skip
                            setState(() {
                              _metadata.skipQuestion();
                              _autoReadCurrentQuestion();
                            });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isSubmitButtonEnabled ? Colors.white : Colors.grey[500],
                          foregroundColor: Colors.black,
                          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        ),
                        child: Text(
                          submitButtonText,
                          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),

                    const SizedBox(height: 140),

                    // Hint button
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
