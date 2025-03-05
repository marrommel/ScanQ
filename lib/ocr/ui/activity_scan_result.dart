import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:scanq_multiplatform/widgets/widget_vocabulary_table.dart';

import '../../common/brand_colors.dart';
import '../../common/vocabulary_type.dart';
import '../../database/database.dart';

class ActivityScanResult extends StatefulWidget {
  final List<VocabularyType> vocabularyData;

  const ActivityScanResult({super.key, required this.vocabularyData});

  @override
  State<ActivityScanResult> createState() => _ActivityScanResultState();
}

class _ActivityScanResultState extends State<ActivityScanResult> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
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
    final Database db = Modular.get<Database>();

    for (VocabularyType voc in widget.vocabularyData) {
      db.createVocabulary(voc.translation, voc.vocabulary, 1, false);
    }

    Navigator.pop(context);
  }
}
