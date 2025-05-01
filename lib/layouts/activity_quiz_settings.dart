import 'package:drift/drift.dart' hide Column;
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:scanq_multiplatform/common/logic/tools.dart';
import 'package:scanq_multiplatform/database/database.dart';

import '../common/data/brand_colors.dart';

class ActivityQuizSettings extends StatefulWidget {
  final String? language;

  const ActivityQuizSettings({super.key, required this.language});

  @override
  State<ActivityQuizSettings> createState() => _ActivityQuizSettings();
}

enum QuizSeed {
  // Select random vocabs
  random,
  // Select only unlearned vocabs (random)
  onlyUnlearned,
  // Select via smart algorithm (considering 'is_learned' and 'date_last_learned')
  smart
}

class _ActivityQuizSettings extends State<ActivityQuizSettings> {
  String? selectedValueCombination;

  int get selectedCategory => int.parse(selectedValueCombination!.split(";")[0]);

  String get selectedCategoryLang => selectedValueCombination!.split(";")[1];

  final GlobalKey _quizSettingsFormKey = GlobalKey<FormState>();

  Stream<List<DropdownMenuItem<String>>> getCategoryOptions(final Database db) {
    Selectable<Category> options;
    if (widget.language != null && widget.language!.isNotEmpty) {
      options = db.allCategoriesWithLang(widget.language!);
    } else {
      options = db.allCategories();
    }

    return options.map((Category category) {
      final String optionValue = "${category.id};${category.categoryLanguage}";
      selectedValueCombination ??= optionValue;
      if (widget.language != null && widget.language!.isNotEmpty) {
        return DropdownMenuItem<String>(value: optionValue, child: Text(category.categoryName));
      } else {
        return DropdownMenuItem<String>(
            value: optionValue,
            child: Row(children: [getFlagByLanguageCode(category.categoryLanguage), Text(category.categoryName)]));
      }
    }).watch();
  }

  @override
  Widget build(BuildContext context) {
    QuizSeed? seed = QuizSeed.smart;

    final Database db = Modular.get<Database>();

    return StreamBuilder(
        stream: getCategoryOptions(db),
        builder: (BuildContext context, AsyncSnapshot<List<DropdownMenuItem<String>>> snapshot) => Scaffold(
            appBar: null,
            body: ListView(children: [
              Container(
                  margin: const EdgeInsets.all(15),
                  child: Material(
                      elevation: 3,
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      child: Container(
                          padding: const EdgeInsets.all(20),
                          child: Form(
                              key: _quizSettingsFormKey,
                              child: Column(children: [
                                Text(AppLocalizations.of(context)!.quizSettings,
                                    style: const TextStyle(
                                        fontSize: 22, fontWeight: FontWeight.bold, color: BrandColors.colorPrimaryDark)),
                                Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                  Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: Text("${AppLocalizations.of(context)!.category}:",
                                          style: const TextStyle(fontSize: 16))),
                                  DropdownButtonHideUnderline(
                                      child: DropdownButton2(
                                          hint: Text(AppLocalizations.of(context)!.category),
                                          items: snapshot.data,
                                          value: selectedValueCombination,
                                          onChanged: (value) {
                                            setState(() {
                                              selectedValueCombination = value as String;
                                            });
                                          }))
                                ]),
                                ListTile(
                                    title: Text(AppLocalizations.of(context)!.quizSeedOptionRandom),
                                    leading: Radio<QuizSeed>(
                                        value: QuizSeed.random,
                                        groupValue: seed,
                                        onChanged: (QuizSeed? seed) => setState(() {
                                              seed = seed;
                                            }))),
                                ListTile(
                                    title: Text(AppLocalizations.of(context)!.quizSeedOptionOnlyUnlearned),
                                    leading: Radio<QuizSeed>(
                                        value: QuizSeed.onlyUnlearned,
                                        groupValue: seed,
                                        onChanged: (QuizSeed? seed) => setState(() {
                                              seed = seed;
                                            }))),
                                ListTile(
                                    title: Text(AppLocalizations.of(context)!.quizSeedOptionSmart),
                                    leading: Radio<QuizSeed>(
                                        value: QuizSeed.smart,
                                        groupValue: seed,
                                        onChanged: (QuizSeed? seed) => setState(() {
                                              seed = seed;
                                            })))
                              ])))))
            ])));
  }
}
