import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:scanq_multiplatform/common/brand_colors.dart';
import 'package:scanq_multiplatform/common/tools.dart';

import '../database/database.dart';

const List<String> categoryLanguages = <String>["en", "la", "fr", "it", "es"];

class CreateCategory extends StatefulWidget {
  const CreateCategory({super.key});

  @override
  State<CreateCategory> createState() => _CreateCategoryState();
}

class _CreateCategoryState extends State<CreateCategory> {
  String categoryName = "";
  String categoryLanguage = "en";

  final _createCategoryFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final List<String> categoryLanguageOptions = <String>[
      AppLocalizations.of(context)!.english,
      AppLocalizations.of(context)!.latin,
      AppLocalizations.of(context)!.french,
      AppLocalizations.of(context)!.italian,
      AppLocalizations.of(context)!.spanish
    ];

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text(AppLocalizations.of(context)!.addCategory,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: BrandColors.colorPrimaryDark))),
      Form(
          key: _createCategoryFormKey,
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            TextFormField(
                decoration:
                    InputDecoration(border: const UnderlineInputBorder(), labelText: AppLocalizations.of(context)!.categoryName),
                validator: (name) {
                  if (name == null || name.isEmpty) {
                    return AppLocalizations.of(context)!.pleaseEnterAName;
                  } else {
                    categoryName = name;
                    return null;
                  }
                }),
            DropdownButtonHideUnderline(
                child: DropdownButton2(
                    isExpanded: true,
                    hint: Text(AppLocalizations.of(context)!.language),
                    items: categoryLanguageOptions.map((String language) {
                      final value = categoryLanguages[categoryLanguageOptions.indexOf(language)];
                      return DropdownMenuItem(
                          value: value,
                          child: Row(children: [
                            getFlagByLanguageCode(value),
                            Container(padding: const EdgeInsets.only(left: 10, right: 10), child: Text(language))
                          ]));
                    }).toList(),
                    value: categoryLanguage,
                    onChanged: (value) {
                      setState(() {
                        categoryLanguage = value as String;
                      });
                    })),
            ElevatedButton(
                onPressed: () async {
                  if (_createCategoryFormKey.currentState!.validate()) {
                    if (categoryName.isNotEmpty) {
                      final db = Modular.get<Database>();
                      await db.createCategory(categoryName, categoryLanguage);

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
  }
}
