import 'dart:async';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:scanq_multiplatform/common/data/brand_colors.dart';
import 'package:scanq_multiplatform/quiz/data/quiz_config.dart';
import 'package:scanq_multiplatform/quiz/data/quiz_metadata.dart';
import 'package:scanq_multiplatform/quiz/data/quiz_mode.dart';
import 'package:scanq_multiplatform/quiz/ui/widgets/widget_quiz_header.dart';
import 'package:scanq_multiplatform/quiz/ui/widgets/widget_top_curve.dart';

import '../../gen/l10n/app_localizations.dart';
import '../data/multiple_choice_item.dart';
import '../logic/quiz_vocabulary_loader.dart';

class ActivityMultipleChoice extends StatefulWidget {
  final QuizConfig config;

  const ActivityMultipleChoice({super.key, required this.config});

  @override
  _ActivityMultipleChoiceState createState() => _ActivityMultipleChoiceState();
}

class _ActivityMultipleChoiceState extends State<ActivityMultipleChoice> {
  /// Quiz metadata contain the questions, answers, score and question index.
  late QuizMetadata _metadata;

  /// Timer to show the next question after a delay.
  Timer? _timer;

  /// Boolean to indicate if the quiz data is ready.
  bool _isDataLoaded = false;

  /// Boolean to indicate if the quiz data contains enough vocabularies.
  bool _isVocabulariesEnough = true;

  /// Skip button will show different text if the question has already been answered.
  String skipText = "";

  @override
  void initState() {
    super.initState();
    _loadVocabulary();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    skipText = AppLocalizations.of(context)!.answerLater;
  }

  Future<void> _loadVocabulary() async {
    // initialize the loader to retrieve vocabulary form database
    QuizVocabularyLoader loader = QuizVocabularyLoader(widget.config);
    await loader.loadVocabulary();

    // create quiz items from the loaded vocabulary
    List<MultipleChoiceItem>? multipleChoiceItems = loader.generateMultipleChoiceQuestions();

    if (multipleChoiceItems == null) {
      _isVocabulariesEnough = false;
    } else {
      _metadata = QuizMetadata(widget.config, QuizMode.MULTIPLE_CHOICE, multipleChoiceItems);
    }

    // update the ui as the data is ready
    setState(() {
      _isDataLoaded = true;
    });
  }

  void _onChoiceSelected(String choice) {
    // leave the method immediately is question is already answered
    if (_metadata.isAnswered) return;

    // store the answer, check it and give a point if correct
    _metadata.incrementScoreIfCorrect(choice);

    // replace the skip button with a next button
    skipText = AppLocalizations.of(context)!.next;

    // update the ui
    setState(() => {});

    // show the next question after 2 seconds (if enabled in config)
    if (widget.config.autoContinue) {
      _timer = Timer(Duration(seconds: 2), () => _nextQuestion(false));
    }
  }

  void _nextQuestion(bool immediately) {
    // cancel the time if the next question shall be shown immediately
    if (immediately) _timer?.cancel();

    // increment the question index
    if (!_metadata.nextQuestion()) {
      _metadata.showResultScreen(context);
    }

    // reset the skip button
    skipText = AppLocalizations.of(context)!.answerLater;

    // update the ui
    setState(() => {});
  }

  @override
  Widget build(BuildContext context) {
    // show loading screen while data is being fetched
    if (!_isDataLoaded) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (!_isVocabulariesEnough) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Lottie.asset("assets/animation/fail.json", repeat: false, width: 500, fit: BoxFit.contain),
            Padding(
              padding: EdgeInsets.all(30),
              child: Text(
                AppLocalizations.of(context)!.categoryTooTiny,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(onPressed: Navigator.of(context).pop, child: Text(AppLocalizations.of(context)!.end)),
            SizedBox(height: 120),
          ],
        ),
      );
    }

    // show the quiz once all data is loaded
    MultipleChoiceItem currentQuestion = _metadata.quizItem as MultipleChoiceItem;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(children: [
          QuizHeader(metadata: _metadata),
          Spacer(),
          Text(
            AppLocalizations.of(context)!.translate,
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 20, color: Colors.grey),
          ),
          SizedBox(height: 5),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: AutoSizeText(
              currentQuestion.question,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
              maxLines: 3,
              minFontSize: 20,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold, color: BrandColors.colorPrimaryDark),
            ),
          ),
          Spacer(),
          TopCurve(),
          Stack(
            children: [
              Positioned.fill(
                child: Container(
                  color: BrandColors.colorPrimary,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 30),
                  ...currentQuestion.getChoices.map((choice) {
                    bool isCorrect = currentQuestion.correctAnswer == choice;
                    bool isSelected = currentQuestion.givenAnswer == choice;

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: ElevatedButton(
                        onPressed: () => _onChoiceSelected(choice),
                        style: ElevatedButton.styleFrom(
                          alignment: Alignment.centerLeft,
                          backgroundColor: isCorrect
                              ? ((currentQuestion.givenAnswer != "") ? Colors.green : Colors.white)
                              : (isSelected ? Colors.red : Colors.white),
                          foregroundColor: isCorrect
                              ? ((currentQuestion.givenAnswer != "") ? Colors.white : Colors.black)
                              : (isSelected ? Colors.white : Colors.black),
                          padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: AutoSizeText(choice,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            minFontSize: 15,
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                    );
                  }),
                  SizedBox(height: 20),
                  TextButton(
                    onPressed: () => setState(() {
                      if (_metadata.isAnswered) {
                        _nextQuestion(true);
                      } else {
                        _metadata.skipQuestion();
                      }
                    }),
                    child: Text(skipText, style: TextStyle(color: Colors.white, fontSize: 16)),
                  ),
                  SizedBox(height: 50),
                ],
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
