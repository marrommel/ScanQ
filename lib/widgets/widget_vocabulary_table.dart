import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../common/data/vocabulary_type.dart';

class VocabularyTable extends StatefulWidget {
  final List<VocabularyType> data;
  final bool editable;

  const VocabularyTable({
    super.key,
    required this.data,
    this.editable = false,
  });

  @override
  State<VocabularyTable> createState() => _VocabularyTableState();
}

class _VocabularyTableState extends State<VocabularyTable> {
  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.symmetric(
        outside: BorderSide(width: 2, color: Color(0xFFEAECEF)), // Outer border
        inside: BorderSide.none, // No inner borders
      ),
      columnWidths: const {
        0: FlexColumnWidth(1), // Vocabulary column
        1: FlexColumnWidth(1), // Translation column
      },
      children: widget.data.mapIndexed((i, scanResult) {
        return TableRow(
          decoration: BoxDecoration(
            color: (i % 2) == 0 ? Color(0xFFf9f9f9) : Colors.white,
          ),
          children: [
            _vocabTableCell(
              editable: widget.editable,
              value: scanResult.vocabulary,
              onChanged: (value) {
                setState(() {
                  scanResult.vocabulary = value;
                });
              },
            ),
            _vocabTableCell(
              editable: widget.editable,
              value: scanResult.translation,
              onChanged: (value) {
                setState(() {
                  scanResult.translation = value;
                });
              },
            ),
          ],
        );
      }).toList(),
    );
  }

  TableCell _vocabTableCell({
    required bool editable,
    required String value,
    required ValueChanged<String> onChanged,
  }) {
    return TableCell(
      verticalAlignment: TableCellVerticalAlignment.middle,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: TextFormField(
          style: const TextStyle(color: Colors.black),
          decoration: const InputDecoration(
            border: InputBorder.none,
          ),
          maxLines: null,
          enabled: editable,
          initialValue: value,
          onChanged: onChanged,
        ),
      ),
    );
  }
}
