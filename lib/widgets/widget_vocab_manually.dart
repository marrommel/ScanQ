import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:scanq_multiplatform/database/database.dart';

import '../common/brand_colors.dart';
import '../common/tools.dart';

class VocabManually extends StatefulWidget {
  const VocabManually({super.key});

  @override
  State<VocabManually> createState() => _VocabManually();
}

class _VocabManually extends State<VocabManually> {
  String vocabLocal = "";
  String vocabForeign = "";
  String? selectedValueCombination;

  int get selectedCategory => int.parse(selectedValueCombination!.split(";")[0]);

  String get selectedCategoryLang => selectedValueCombination!.split(";")[1];

  final _createVocabFormKey = GlobalKey<FormState>();

  Stream<List<DropdownMenuItem<String>>> getCategoryOptions(final Database db) => db.allCategories().map((Category category) {
        selectedValueCombination ??= "${category.id};${category.categoryLanguage}";
        return DropdownMenuItem<String>(value: "${category.id};${category.categoryLanguage}", child: Text(category.categoryName));
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

    final Database db = Provider.of<Database>(context);

    return StreamBuilder(
        stream: getCategoryOptions(db),
        builder: (context, AsyncSnapshot<List<DropdownMenuItem<String>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.active || snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                header,
                Form(
                    key: _createVocabFormKey,
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                              icon: getFlagByCountryCode("DE")),
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return AppLocalizations.of(context)!.fieldMustntBeEmpty;
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
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return AppLocalizations.of(context)!.fieldMustntBeEmpty;
                            } else {
                              vocabForeign = value;
                              return null;
                            }
                          }),
                      ElevatedButton(
                          onPressed: () async {
                            if (_createVocabFormKey.currentState!.validate()) {
                              if (vocabLocal.isNotEmpty && vocabForeign.isNotEmpty && selectedCategory != 0) {
                                await db.createVocabulary(vocabLocal, vocabForeign, selectedCategory, false);

                                if (mounted) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(content: Text(AppLocalizations.of(context)!.vocabSaved)));
                                }

                                vocabLocal = "";
                                vocabForeign = "";
                                _createVocabFormKey.currentState?.reset();
                              }
                            }
                          },
                          style: ButtonStyle(backgroundColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
                            if (states.contains(WidgetState.pressed) || states.contains(WidgetState.hovered)) {
                              return BrandColors.colorPrimaryDark;
                            } else {
                              return BrandColors.colorPrimary;
                            }
                          })),
                          child: Text(AppLocalizations.of(context)!.save))
                    ]))
              ]);
            } else {
              return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [header, Text(AppLocalizations.of(context)!.noDataFound)]);
            }
          } else {
            return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [header, const Center(child: CircularProgressIndicator())]);
          }
        });
  }
}
