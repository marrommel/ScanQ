import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:scanq_multiplatform/database/database.dart';
import 'package:scanq_multiplatform/gen/l10n/app_localizations.dart';

import '../common/data/brand_colors.dart';
import '../common/logic/tools.dart';
import '../layouts/activity_create_category.dart';

class VocabManually extends StatefulWidget {
  final int? categoryId;

  const VocabManually({super.key, this.categoryId});

  @override
  State<VocabManually> createState() => _VocabManually();
}

class _VocabManually extends State<VocabManually> {
  String vocabLocal = "";
  String vocabForeign = "";
  String? selectedValueCombination;

  // prevent validators from being triggered when the form is reset
  bool firstChangeVoc = false;
  bool firstChangeTrans = false;

  int get selectedCategory => int.parse(selectedValueCombination!.split(";")[0]);

  String get selectedCategoryLang => selectedValueCombination!.split(";")[1];

  final _createVocabFormKey = GlobalKey<FormState>();

  Stream<List<DropdownMenuItem<String>>> getCategoryOptions(final Database db) => db.allCategories().map((Category category) {
        if (widget.categoryId != null) {
          // select the provided category
          if (category.id == widget.categoryId) {
            selectedValueCombination = "${category.id};${category.categoryLanguage}";
          }
        } else {
          // if no category is selected, select the first one
          selectedValueCombination ??= "${category.id};${category.categoryLanguage}";
        }

        return DropdownMenuItem<String>(
          value: "${category.id};${category.categoryLanguage}",
          child: SizedBox(
            width: 120,
            child: Text(
              maxLines: 1,
              category.categoryName,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        );
      }).watch();

  @override
  Widget build(BuildContext context) {
    Container header = Container(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        AppLocalizations.of(context)!.addVocabulary,
        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: BrandColors.colorPrimaryDark),
      ),
    );

    final Database db = Modular.get<Database>();

    return StreamBuilder(
        stream: getCategoryOptions(db),
        builder: (context, AsyncSnapshot<List<DropdownMenuItem<String>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.active || snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                header,
                Form(
                    key: _createVocabFormKey,
                    child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                      Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
                        Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: Text("${AppLocalizations.of(context)!.category}:", style: const TextStyle(fontSize: 16))),
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
                      TextFormField(
                          decoration: InputDecoration(
                              border: const UnderlineInputBorder(),
                              labelText: AppLocalizations.of(context)!.sourceLanguage,
                              icon: getFlagByLanguageCode("DE")),
                          onChanged: (value) {
                            if (firstChangeTrans) {
                              firstChangeTrans = false;
                            } else {
                              _createVocabFormKey.currentState!.validate();
                            }
                          },
                          validator: (String? value) {
                            if (value == null || value.trim().isEmpty) {
                              return AppLocalizations.of(context)!.fieldMustntBeEmpty;
                            } else if (value.trim().length > 100) {
                              return AppLocalizations.of(context)!.max100CharsAllowed;
                            } else {
                              vocabLocal = value;
                              return null;
                            }
                          }),
                      TextFormField(
                          decoration: InputDecoration(
                              border: const UnderlineInputBorder(),
                              labelText: AppLocalizations.of(context)!.targetLanguage,
                              icon: getFlagByLanguageCode(selectedCategoryLang)),
                          onChanged: (value) {
                            if (firstChangeVoc) {
                              firstChangeVoc = false;
                            } else {
                              _createVocabFormKey.currentState!.validate();
                            }
                          },
                          validator: (String? value) {
                            if (value == null || value.trim().isEmpty) {
                              return AppLocalizations.of(context)!.fieldMustntBeEmpty;
                            } else if (value.trim().length > 100) {
                              return AppLocalizations.of(context)!.max100CharsAllowed;
                            } else {
                              vocabForeign = value;
                              return null;
                            }
                          }),
                      SizedBox(height: 20),
                      ElevatedButton(
                          onPressed: () async {
                            if (_createVocabFormKey.currentState!.validate()) {
                              if (vocabLocal.trim().isNotEmpty && vocabForeign.isNotEmpty && selectedCategory != 0) {
                                await db.createVocabulary(vocabLocal, vocabForeign, selectedCategory, false);

                                if (mounted) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(content: Text(AppLocalizations.of(context)!.vocabSaved)));
                                }

                                vocabLocal = "";
                                vocabForeign = "";
                                firstChangeTrans = true;
                                firstChangeVoc = true;
                                _createVocabFormKey.currentState?.reset();
                              }
                            }
                          },
                          child: Text(AppLocalizations.of(context)!.save))
                    ]))
              ]);
            } else {
              // redirect to create a category
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => ActivityCreateCategory(onlyOnce: true)),
                );
              });

              // return an empty screen of no categories are found
              return SizedBox.shrink();
            }
          } else {
            return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [header, const Center(child: CircularProgressIndicator())]);
          }
        });
  }
}
