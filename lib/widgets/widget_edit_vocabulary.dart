import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:scanq_multiplatform/database/database.dart';
import 'package:scanq_multiplatform/gen/l10n/app_localizations.dart';

import '../common/data/brand_colors.dart';
import '../common/logic/tools.dart';

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

  bool isValidVoc = false;
  bool isValidTrans = false;

  @override
  Widget build(BuildContext context) {
    // check if a change was made
    bool isChanged = (vocabLocal.trim() != widget.vocabulary.vocLocal || vocabForeign.trim() != widget.vocabulary.vocForeign);
    bool isValid = isValidVoc && isValidTrans && isChanged;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(AppLocalizations.of(context)!.editVocabulary,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: BrandColors.colorPrimaryDark,
            )),
        SizedBox(height: 20),
        Form(
            key: _editVocabularyFormKey,
            child: Column(children: [
              TextFormField(
                  initialValue: widget.vocabulary.vocLocal,
                  decoration: InputDecoration(
                      border: const UnderlineInputBorder(),
                      labelText: AppLocalizations.of(context)!.sourceLanguage,
                      icon: getFlagByLanguageCode("DE")),
                  onChanged: (_) => _editVocabularyFormKey.currentState!.validate(),
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      setState(() {
                        isValidTrans = false;
                      });
                      return AppLocalizations.of(context)!.fieldMustntBeEmpty;
                    } else if (value.trim().length > 100) {
                      setState(() {
                        isValidTrans = false;
                        vocabLocal = value.trim();
                      });
                      return "Max. 100 Zeichen erlaubt";
                    } else {
                      setState(() {
                        isValidTrans = true;
                        vocabLocal = value.trim();
                      });
                      return null;
                    }
                  }),
              TextFormField(
                  initialValue: widget.vocabulary.vocForeign,
                  decoration: InputDecoration(
                      border: const UnderlineInputBorder(),
                      labelText: AppLocalizations.of(context)!.targetLanguage,
                      icon: getFlagByLanguageCode(widget.category.categoryLanguage)),
                  onChanged: (_) => _editVocabularyFormKey.currentState!.validate(),
                  validator: (String? value) {
                    if (value == null || value.trim().isEmpty) {
                      setState(() {
                        isValidVoc = false;
                      });
                      return AppLocalizations.of(context)!.fieldMustntBeEmpty;
                    } else if (value.trim().length > 100) {
                      setState(() {
                        isValidVoc = false;
                        vocabForeign = value.trim();
                      });
                      return "Max. 100 Zeichen erlaubt";
                    } else {
                      setState(() {
                        isValidVoc = true;
                        vocabForeign = value.trim();
                      });
                      return null;
                    }
                  }),
              SizedBox(height: 30),
              ElevatedButton(
                  onPressed: !isValid
                      ? null
                      : () async {
                          // save changes to database
                          final Database db = Modular.get<Database>();
                          if (vocabLocal != widget.vocabulary.vocLocal) {
                            await db.changeVocLocal(vocabLocal, widget.vocabulary.id);
                          }
                          if (vocabForeign != widget.vocabulary.vocForeign) {
                            await db.changeVocForeign(vocabForeign, widget.vocabulary.id);
                          }

                          // close the dialog
                          Navigator.of(context).pop();
                        },
                  child: Text(AppLocalizations.of(context)!.save))
            ]))
      ],
    );
  }
}
