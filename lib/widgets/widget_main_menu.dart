import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:scanq_multiplatform/ocr/ui/activity_image_select.dart';
import 'package:scanq_multiplatform/quiz/ui/activity_quiz_select.dart';

import '../layouts/activity_category_overview.dart';
import '../layouts/activity_create_category.dart';
import '../layouts/activity_vocabulary_manually.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      TextButton.icon(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ActivityCreateCategory()));
          },
          icon: const Icon(Icons.add),
          label: Text(AppLocalizations.of(context)!.addCategory)),
      TextButton.icon(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ActivityCategoryOverview()));
          },
          icon: const Icon(Icons.table_rows),
          label: Text(AppLocalizations.of(context)!.savedCategories)),
      TextButton.icon(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ActivityVocabularyManually()));
          },
          icon: const Icon(Icons.abc),
          label: Text(AppLocalizations.of(context)!.addVocabulary)),
      TextButton.icon(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ActivityImageSelect()));
          },
          icon: const Icon(Icons.abc),
          label: Text(AppLocalizations.of(context)!.scanVocabulary)),
      TextButton.icon(
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ActivityQuizSelect()));
          },
          icon: const Icon(Icons.quiz_outlined),
          label: Text("Quiz")),

      //   TextButton.icon(
      //       onPressed: () {
      //         Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ActivityQuizSettings(language: null)));
      //       },
      //       icon: const Icon(Icons.gamepad_outlined),
      //       label: Text(AppLocalizations.of(context)!.quizSettings))
    ]);
  }
}
