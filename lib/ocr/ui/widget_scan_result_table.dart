import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../../common/data/vocabulary_type.dart';
import '../../gen/l10n/app_localizations.dart';

class ScanResultTable extends StatefulWidget {
  final List<VocabularyType> data;
  final bool editable;

  final void Function(bool)? onValidityChanged;

  const ScanResultTable({
    super.key,
    required this.data,
    this.editable = false,
    this.onValidityChanged,
  });

  @override
  State<ScanResultTable> createState() => _ScanResultTableState();
}

class _ScanResultTableState extends State<ScanResultTable> {
  final _editScanResultFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // check once if the form is valid
      _notifyFormValidity();
    });

    return Form(
      key: _editScanResultFormKey,
      child: Table(
        border: TableBorder.symmetric(
          outside: BorderSide(width: 2, color: Color(0xFFEAECEF)), // Outer border
          inside: BorderSide.none, // No inner borders
        ),
        columnWidths: const {
          0: FlexColumnWidth(1),
          1: FlexColumnWidth(1),
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
                    // check if the form is valid
                    _notifyFormValidity();

                    // store the input
                    scanResult.vocabulary = value;
                  });
                },
              ),
              _vocabTableCell(
                editable: widget.editable,
                value: scanResult.translation,
                onChanged: (value) {
                  setState(() {
                    // check if the form is valid
                    _notifyFormValidity();

                    // store the input
                    scanResult.translation = value;
                  });
                },
              ),
            ],
          );
        }).toList(),
      ),
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
          style: TextStyle(color: Colors.black),
          decoration: InputDecoration(
            border: InputBorder.none,
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 2),
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.red, width: 2),
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            errorStyle: const TextStyle(fontWeight: FontWeight.w700),
          ),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return AppLocalizations.of(context)!.mayNotBeEmpty;
            } else if (value.length > 100) {
              return AppLocalizations.of(context)!.max100CharsAllowed;
            }

            // return null if the input is valid
            return null;
          },
          maxLines: null,
          enabled: editable,
          initialValue: value,
          onChanged: onChanged,
        ),
      ),
    );
  }

  void _notifyFormValidity() {
    if (widget.onValidityChanged != null) {
      final isValid = _editScanResultFormKey.currentState?.validate() ?? false;
      widget.onValidityChanged!(isValid);
    }
  }
}
