import 'dart:math';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:scanq_multiplatform/common/data/brand_colors.dart';
import 'package:scanq_multiplatform/quiz/data/quiz_config.dart';

import '../../gen/l10n/app_localizations.dart';
import '../data/quiz_item.dart';
import '../data/quiz_mode.dart';

class ActivityQuizResult extends StatefulWidget {
  final int score;
  final List<QuizItem> quizResults;
  final int totalQuestions;
  final QuizConfig quizConfig;
  final QuizMode quizMode;

  const ActivityQuizResult({
    super.key,
    required this.score,
    required this.quizResults,
    required this.quizConfig,
    required this.quizMode,
  }) : totalQuestions = quizResults.length;

  @override
  _ActivityQuizResultState createState() => _ActivityQuizResultState();
}

class _ActivityQuizResultState extends State<ActivityQuizResult> {
  late String animationAsset;

  @override
  void initState() {
    super.initState();
    _setAnimation();
  }

  void _setAnimation() {
    int mistakes = widget.totalQuestions - widget.score;
    int goldThreshold = (widget.totalQuestions * 0.05).floor();
    int silverThreshold = min(max(1, widget.totalQuestions * 0.1), widget.totalQuestions - 1).floor();
    int bronzeThreshold = min(max(2, widget.totalQuestions * 0.2), widget.totalQuestions - 1).floor();

    if (mistakes <= goldThreshold) {
      animationAsset = 'assets/animation/trophy_gold.json';
    } else if (mistakes <= silverThreshold) {
      animationAsset = 'assets/animation/trophy_silver.json';
    } else if (mistakes <= bronzeThreshold) {
      animationAsset = 'assets/animation/trophy_bronze.json';
    } else {
      animationAsset = 'assets/animation/success.json';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: BrandColors.colorPrimary,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Spacer(flex: 2),
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 145,
                            height: 145,
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                          ),
                          Lottie.asset(animationAsset, height: 140, repeat: false),
                        ],
                      ),
                      const SizedBox(height: 30),
                      Text(
                        "${widget.score} / ${widget.totalQuestions}",
                        style: const TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 30),
                      Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          onPressed: () => Navigator.pop(context),
                          child: Text(AppLocalizations.of(context)!.end,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          onPressed: () => {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(builder: (context) => widget.quizMode.activity(widget.quizConfig))),
                          },
                          child: Text(AppLocalizations.of(context)!.repeat,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                      ]),
                      Spacer(flex: 7)
                    ],
                  ),
                ),
              ),
            ],
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.35,
            minChildSize: 0.35,
            maxChildSize: 0.95,
            builder: (context, scrollController) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(40)),
                ),
                child: CustomScrollView(
                  controller: scrollController,
                  slivers: [
                    SliverToBoxAdapter(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10),
                          Center(
                            child: Container(
                              width: 70,
                              height: 4,
                              decoration: BoxDecoration(
                                color: Colors.grey[350], // Color of the handle
                                borderRadius: BorderRadius.circular(10), // Rounded edges
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            AppLocalizations.of(context)!.yourAnswers,
                            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 20),
                        ],
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          return QuestionItem(widget.quizResults[index], index, widget.quizConfig.caseSensitive);
                        },
                        childCount: widget.quizResults.length,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class QuestionItem extends StatefulWidget {
  final QuizItem result;
  final int index;
  final bool isCaseSensitive;

  const QuestionItem(this.result, this.index, this.isCaseSensitive, {super.key});

  @override
  _QuestionItemState createState() => _QuestionItemState();
}

class _QuestionItemState extends State<QuestionItem> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    bool isCorrect;
    if (widget.isCaseSensitive) {
      isCorrect = widget.result.givenAnswer == widget.result.correctAnswer;
    } else {
      isCorrect = widget.result.givenAnswer.toLowerCase() == widget.result.correctAnswer.toLowerCase();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          title: AutoSizeText("${widget.index + 1}. ${widget.result.givenAnswer}",
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
              minFontSize: 15,
              style: TextStyle(
                color: isCorrect ? Colors.green : Colors.red,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              )),
          trailing: Icon(expanded ? Icons.expand_less : Icons.expand_more),
          onTap: () {
            setState(() {
              expanded = !expanded;
            });
          },
        ),
        if (expanded)
          Container(
            decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 90,
                        child: Text(
                          AppLocalizations.of(context)!.questionColon,
                          style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        child: AutoSizeText(
                          widget.result.question,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          maxLines: 3,
                          minFontSize: 13,
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                    ],
                  ),
                  if (!isCorrect) SizedBox(height: 5),
                  if (!isCorrect)
                    Row(
                      children: [
                        SizedBox(
                          width: 90,
                          child: Text(
                            AppLocalizations.of(context)!.answerColon,
                            style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                          ),
                        ),
                        AutoSizeText(
                          widget.result.correctAnswer,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                          maxLines: 3,
                          minFontSize: 13,
                          style: TextStyle(fontSize: 17),
                        ),
                      ],
                    ),
                  // TODO: Add highlight vocab option
                  // TextButton(
                  //   onPressed: () {},
                  //   child: const Text("Vokabel hervorheben"),
                  // ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
