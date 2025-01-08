import 'package:flutter/material.dart';
import 'package:scanq_multiplatform/widgets/widget_vocab_manually.dart';

class ActivityVocabularyManually extends StatelessWidget {
  const ActivityVocabularyManually({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: null,
        body: ListView(
            children: [
              Container(
                  margin: const EdgeInsets.all(15),
                  child: Material (
                      elevation: 3,
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      child: Container(
                          padding: const EdgeInsets.all(32),
                          child: const VocabManually()
                      )
                  )
              )
            ]
        )
    );
  }

}