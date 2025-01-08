import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:scanq_multiplatform/widgets/widget_vocabulary_table.dart';

import '../../database/database.dart';
import '../data/scan_result.dart';

class ActivityScanResult extends StatefulWidget {
  final List<ScanResult> vocabularyData;

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
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                children: [
                  VocabularyTable(data: widget.vocabularyData, editable: true),
                  SizedBox(height: 30),
                  ElevatedButton(onPressed: _saveVocabs, child: Text("speichern"))
                ],
              )),
        ),
      ),
    );
  }

  void _saveVocabs() {
    final Database db = Modular.get<Database>();

    for (ScanResult voc in widget.vocabularyData) {
      db.createVocabulary(voc.translation, voc.vocabulary, 1, false);
    }

    Navigator.pop(context);
  }
}
