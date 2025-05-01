import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:scanq_multiplatform/widgets/widget_vocabulary_table.dart';

import '../../common/data/brand_colors.dart';
import '../../common/ui/transparent_app_bar.dart';
import '../../common/data/vocabulary_type.dart';
import '../../database/database.dart';
import '../logic/widget_save_scanned_vocabs.dart';

class ActivityScanResult extends StatefulWidget {
  final List<VocabularyType> vocabularyData;

  const ActivityScanResult({super.key, required this.vocabularyData});

  @override
  State<ActivityScanResult> createState() => _ActivityScanResultState();
}

class _ActivityScanResultState extends State<ActivityScanResult> {
  bool createNewCategory = false;
  int? categoryId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TransparentAppBar(),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 0),
              child: Column(
                children: [
                  SizedBox(height: 60),
                  Text(
                    "Eingescannte Vokabeln",
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: BrandColors.colorPrimaryDark,
                    ),
                  ),
                  SizedBox(height: 20),
                  VocabularyTable(data: widget.vocabularyData, editable: true),
                  SizedBox(height: 30),
                  ElevatedButton(onPressed: _saveVocabs, child: Text("speichern")),
                  SizedBox(height: 30),
                ],
              )),
        ),
      ),
    );
  }

  void _saveVocabs() {
    showDialog(
        context: context,
        barrierDismissible: true,
        useSafeArea: true,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            backgroundColor: Colors.white,
            child: Padding(
              padding: EdgeInsets.all(20),
              child: SaveScannedVocabs(
                language: "en",
                onAccept: (id, name) async {
                  final Database db = Modular.get<Database>();
                  if (name.isNotEmpty) {
                    await db.createCategory(name, "en");
                    Category newCategory = await db.lastlyInsertedCategory().getSingle();

                    for (VocabularyType voc in widget.vocabularyData) {
                      db.createVocabulary(voc.translation, voc.vocabulary, newCategory.id, false);
                    }
                  } else {
                    for (VocabularyType voc in widget.vocabularyData) {
                      db.createVocabulary(voc.translation, voc.vocabulary, id, false);
                    }
                  }

                  if (context.mounted) {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Vokabeln erfolgreich gespeichert!")));
                  }
                },
              ),
            ),
          );
        });
  }

  Stream<List<DropdownMenuItem<String>>> getCategoryOptions(final Database db) =>
      db.allCategoriesWithLang("en").map((Category category) {
        return DropdownMenuItem<String>(value: "${category.id}", child: Text(category.categoryName));
      }).watch();
}
