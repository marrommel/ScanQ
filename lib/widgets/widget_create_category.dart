import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:scanq_multiplatform/common/data/brand_colors.dart';
import 'package:scanq_multiplatform/gen/l10n/app_localizations.dart';
import 'package:scanq_multiplatform/layouts/activity_vocabulary_manually.dart';

import '../database/database.dart';

const List<String> categoryLanguages = <String>["en", "la", "fr", "it", "es"];

class CreateCategory extends StatefulWidget {
  final bool onlyOnce;
  final Category? editCategory;

  const CreateCategory({super.key, required this.onlyOnce, this.editCategory});

  @override
  State<CreateCategory> createState() => _CreateCategoryState();
}

class _CreateCategoryState extends State<CreateCategory> {
  bool isValid = false;

  String categoryName = "";
  String categoryLanguage = "en";

  String initialCategoryName = "";
  int categoryId = -1;

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

    // get name and id of the category to edit
    final bool editMode = widget.editCategory != null;
    if (editMode) {
      initialCategoryName = widget.editCategory!.categoryName;
      categoryId = widget.editCategory!.id;
    }

    // update the validity of the form
    if (editMode) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        isValid = _createCategoryFormKey.currentState!.validate();
      });
    }

    return Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text(editMode ? "\"$initialCategoryName\" bearbeiten" : AppLocalizations.of(context)!.addCategory,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: BrandColors.colorPrimaryDark))),
      Form(
          key: _createCategoryFormKey,
          child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            TextFormField(
                decoration:
                    InputDecoration(border: const UnderlineInputBorder(), labelText: AppLocalizations.of(context)!.categoryName),
                onChanged: (_) => setState(() {
                      isValid = _createCategoryFormKey.currentState!.validate();
                    }),
                initialValue: editMode ? initialCategoryName : null,
                validator: (name) {
                  if (name == null || name.trim().isEmpty) {
                    return AppLocalizations.of(context)!.pleaseEnterAName;
                  } else if (name.trim().length > 25) {
                    return "Max. 25 Zeichen erlaubt";
                  } else {
                    categoryName = name;
                    return null;
                  }
                }),
            /*DropdownButtonHideUnderline(
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
                    })),*/
            SizedBox(height: 30),
            ElevatedButton(
                onPressed: !isValid
                    ? null
                    : () async {
                        if (editMode) {
                          await _editCategory();
                        } else {
                          await _createCategory();
                        }
                      },
                style: ButtonStyle(backgroundColor: WidgetStateProperty.resolveWith<Color>((Set<WidgetState> states) {
                  // return grey for disabled button
                  if (!isValid) return Colors.grey[500]!;

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

  Future<void> _editCategory() async {
    // only save if the category name has changed
    if (initialCategoryName != categoryName) {
      final db = Modular.get<Database>();
      await db.renameCategory(categoryName.trim(), categoryId);
    }

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("\"$categoryName\" gespeichert.")));
      Navigator.pop(context);
    }
  }

  Future<void> _createCategory() async {
    final db = Modular.get<Database>();
    await db.createCategory(categoryName.trim(), categoryLanguage);

    if (mounted) {
      if (widget.onlyOnce) {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ActivityVocabularyManually()));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(AppLocalizations.of(context)!.categoryCreatedText(categoryName))));
      }
    }

    categoryName = "";
    _createCategoryFormKey.currentState?.reset();
  }
}
