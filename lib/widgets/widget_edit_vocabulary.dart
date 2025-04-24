import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:scanq_multiplatform/database/database.dart';

import '../common/tools.dart';

// TODO: rework this (maximized height, save button as external logic)

class EditVocabulary extends StatefulWidget {
  final Category category;
  final Vocabulary vocabulary;

  const EditVocabulary({super.key, required this.category, required this.vocabulary});

  @override
  State<EditVocabulary> createState() => _EditVocabulary();
}

class _EditVocabulary extends State<EditVocabulary> {
  final _editVocabularyFormKey = GlobalKey<FormState>();

  String vocabLocal = "";
  String vocabForeign = "";

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text(AppLocalizations.of(context)!.editVocabulary),
      Form(
          key: _editVocabularyFormKey,
          child: Column(children: [
            TextFormField(
                initialValue: widget.vocabulary.vocLocal,
                decoration: InputDecoration(
                    border: const UnderlineInputBorder(),
                    labelText: AppLocalizations.of(context)!.sourceLanguage,
                    icon: getFlagByCountryCode("DE")),
                validator: (String? value) {
                  if (value == null || value.trim().isEmpty) {
                    return AppLocalizations.of(context)!.fieldMustntBeEmpty;
                  } else {
                    vocabLocal = value.trim();
                    return null;
                  }
                }),
            TextFormField(
                initialValue: widget.vocabulary.vocForeign,
                decoration: InputDecoration(
                    border: const UnderlineInputBorder(),
                    labelText: AppLocalizations.of(context)!.targetLanguage,
                    icon: getFlagByLanguageCode(widget.category.categoryLanguage)),
                validator: (String? value) {
                  if (value == null || value.trim().isEmpty) {
                    return AppLocalizations.of(context)!.fieldMustntBeEmpty;
                  } else {
                    vocabForeign = value.trim();
                    return null;
                  }
                }),
            ElevatedButton(
                onPressed: () async {
                  if (_editVocabularyFormKey.currentState!.validate()) {
                    if (vocabLocal.isNotEmpty &&
                        vocabForeign.isNotEmpty &&
                        (vocabLocal != widget.vocabulary.vocLocal || vocabForeign != widget.vocabulary.vocForeign)) {
                      final Database db = Modular.get<Database>();
                      if (vocabLocal != widget.vocabulary.vocLocal) {
                        await db.changeVocLocal(vocabLocal, widget.vocabulary.id);
                      }
                      if (vocabForeign != widget.vocabulary.vocForeign) {
                        await db.changeVocForeign(vocabForeign, widget.vocabulary.id);
                      }
                    }
                  }
                },
                child: Text(AppLocalizations.of(context)!.save))
          ]))
    ]);
  }
}
