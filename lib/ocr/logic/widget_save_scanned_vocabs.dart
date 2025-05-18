import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:scanq_multiplatform/common/data/brand_colors.dart';
import 'package:scanq_multiplatform/gen/l10n/app_localizations.dart';

import '../../database/database.dart';

class SaveScannedVocabs extends StatefulWidget {
  final void Function(int categoryId, String newCategoryName) onAccept;
  final String language;

  const SaveScannedVocabs({super.key, required this.onAccept, required this.language});

  @override
  State<SaveScannedVocabs> createState() => _SaveScannedVocabsState();
}

class _SaveScannedVocabsState extends State<SaveScannedVocabs> {
  String categoryName = "";
  String? selectedValueCombination;

  int get selectedCategoryId => int.parse(selectedValueCombination!.split(";")[0]);

  String get selectedCategoryLang => selectedValueCombination!.split(";")[1];

  Stream<List<DropdownMenuItem<String>>>? getCategoryOptions(final Database db) =>
      db.allCategoriesWithLang(widget.language).map((Category category) {
        selectedValueCombination ??= "${category.id};${category.categoryLanguage}";
        return DropdownMenuItem<String>(
          value: "${category.id};${category.categoryLanguage}",
          child: Text(category.categoryName),
        );
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
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    AppLocalizations.of(context)!.saveVocabs,
                    style: const TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: BrandColors.colorPrimaryDark,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Form(
                  key: _createCategoryFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      DropdownButtonHideUnderline(
                        child: DropdownButton2(
                          hint: Text(AppLocalizations.of(context)!.category),
                          items: snapshot.data,
                          value: selectedValueCombination,
                          onChanged: (value) {
                            setState(() {
                              selectedValueCombination = value as String;
                            });
                          },
                        ),
                      ),
                      Row(
                        children: [
                          const Expanded(
                            child: Divider(
                              height: 60,
                              thickness: 2,
                              color: Colors.black26,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Text(
                              AppLocalizations.of(context)!.or,
                              style: TextStyle(fontSize: 18, color: Colors.black45),
                            ),
                          ),
                          const Expanded(
                            child: Divider(
                              height: 60,
                              thickness: 2,
                              color: Colors.black26,
                            ),
                          ),
                        ],
                      ),
                      TextFormField(
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(),
                          labelText: AppLocalizations.of(context)!.createCategory,
                        ),
                        onChanged: (_) => _createCategoryFormKey.currentState!.validate(),
                        validator: (name) {
                          if (name == null) {
                            return AppLocalizations.of(context)!.pleaseEnterAName;
                          } else if (name.trim().length > 25) {
                            return AppLocalizations.of(context)!.max25CharsAllowed;
                          } else {
                            categoryName = name;
                            return null;
                          }
                        },
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          if (_createCategoryFormKey.currentState!.validate()) {
                            widget.onAccept(
                              selectedCategoryId,
                              categoryName.trim().isNotEmpty ? categoryName : "",
                            );
                            Navigator.of(context).pop();
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor: WidgetStateProperty.resolveWith<Color>(
                            (Set<WidgetState> states) {
                              if (states.contains(WidgetState.pressed) || states.contains(WidgetState.hovered)) {
                                return BrandColors.colorPrimaryDark;
                              } else {
                                return BrandColors.colorPrimary;
                              }
                            },
                          ),
                        ),
                        child: Text(AppLocalizations.of(context)!.save),
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return SizedBox(height: 1);
          }
        } else {
          return SizedBox(height: 1);
        }
      },
    );
  }
}
