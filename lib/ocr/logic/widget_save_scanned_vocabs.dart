import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:scanq_multiplatform/common/brand_colors.dart';

import '../../database/database.dart';

class SaveScannedVocabs extends StatefulWidget {
  const SaveScannedVocabs({super.key});

  @override
  State<SaveScannedVocabs> createState() => _SaveScannedVocabsState();
}

class _SaveScannedVocabsState extends State<SaveScannedVocabs> {
  String categoryName = "";

  String? selectedValueCombination;

  int get selectedCategory => int.parse(selectedValueCombination!.split(";")[0]);

  String get selectedCategoryLang => selectedValueCombination!.split(";")[1];

  Stream<List<DropdownMenuItem<String>>> getCategoryOptions(final Database db) => db.allCategories().map((Category category) {
        selectedValueCombination ??= "${category.id};${category.categoryLanguage}";
        return DropdownMenuItem<String>(value: "${category.id};${category.categoryLanguage}", child: Text(category.categoryName));
      }).watch();

  final _createCategoryFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final Database db = Modular.get<Database>();

    return StreamBuilder(
        stream: getCategoryOptions(db),
        builder: (context, AsyncSnapshot<List<DropdownMenuItem<String>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.active || snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Container(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(AppLocalizations.of(context)!.addCategory,
                        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: BrandColors.colorPrimaryDark))),
                Form(
                    key: _createCategoryFormKey,
                    child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                      DropdownButtonHideUnderline(
                          child: DropdownButton2(
                              hint: Text(AppLocalizations.of(context)!.category),
                              items: snapshot.data,
                              value: selectedValueCombination,
                              onChanged: (value) {
                                setState(() {
                                  selectedValueCombination = value as String;
                                });
                              })),
                      Row(
                        children: [
                          const Expanded(
                            child: Divider(),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: const Text("oder"),
                          ),
                          const Expanded(
                            child: Divider(),
                          ),
                        ],
                      ),
                      TextFormField(
                          decoration: InputDecoration(
                              border: const UnderlineInputBorder(), labelText: AppLocalizations.of(context)!.categoryName),
                          validator: (name) {
                            if (name == null || name.isEmpty) {
                              return AppLocalizations.of(context)!.pleaseEnterAName;
                            } else {
                              categoryName = name;
                              return null;
                            }
                          }),
                      ElevatedButton(
                          onPressed: () async {
                            if (_createCategoryFormKey.currentState!.validate()) {
                              if (categoryName.isNotEmpty) {
                                final db = Modular.get<Database>();
                                await db.createCategory(categoryName, "en");

                                if (mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(AppLocalizations.of(context)!.categoryCreatedText(categoryName))));
                                }

                                categoryName = "";
                                _createCategoryFormKey.currentState?.reset();
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
              return SizedBox(height: 1);
            }
          } else {
            return SizedBox(height: 1);
          }
        });
  }
}
