import 'package:flutter/material.dart';
import 'package:scanq_multiplatform/widgets/widget_vocab_manually.dart';

import '../common/ui/transparent_app_bar.dart';

class ActivityVocabularyManually extends StatelessWidget {
  const ActivityVocabularyManually({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TransparentAppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Material(
                elevation: 3,
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: const VocabManually(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
