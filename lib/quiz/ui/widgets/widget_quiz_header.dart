import 'package:flutter/material.dart';
import 'package:scanq_multiplatform/quiz/data/quiz_metadata.dart';

class QuizHeader extends StatefulWidget {
  final QuizMetadata metadata;

  const QuizHeader({super.key, required this.metadata});

  @override
  State<StatefulWidget> createState() => _QuizHeaderState();
}

class _QuizHeaderState extends State<QuizHeader> {
  @override
  Widget build(BuildContext context) {
    final int score = widget.metadata.score;
    final int questionIndex = widget.metadata.questionIndex;
    final int questionCount = widget.metadata.totalQuestions;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              "${questionIndex + 1} / $questionCount",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                const Icon(Icons.star, color: Colors.black),
                const SizedBox(width: 5),
                Text(
                  "$score",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
