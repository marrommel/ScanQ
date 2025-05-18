import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:scanq_multiplatform/common/ui/widget_dialog_no_vocabulary.dert.dart';
import 'package:scanq_multiplatform/gen/l10n/app_localizations.dart';
import 'package:scanq_multiplatform/speech/voice_output.dart';
import 'package:scanq_multiplatform/widgets/widget_edit_vocabulary.dart';

import '../common/data/brand_colors.dart';
import '../database/database.dart';

enum VocabularyOptions { optionDelete, optionEdit, optionMarkFavourite, optionReadOut }

class VocabularyTable extends StatefulWidget {
  final Category category;

  const VocabularyTable({super.key, required this.category});

  @override
  State<StatefulWidget> createState() => _VocabulariesTable();
}

class _VocabulariesTable extends State<VocabularyTable> {
  Offset _tapPosition = Offset.zero;

  @override
  Widget build(BuildContext context) {
    final Database db = Modular.get<Database>();

    return StreamBuilder<List<TableRow>>(
        stream: getVocabularyRows(db),
        builder: (BuildContext context, AsyncSnapshot<List<TableRow>> snapshot) {
          if (snapshot.connectionState == ConnectionState.active || snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              return Table(
                columnWidths: const {
                  0: FlexColumnWidth(1),
                  1: FlexColumnWidth(1),
                },
                border: TableBorder.symmetric(
                  outside: BorderSide(width: 2, color: Color(0xFFEAECEF)), // Outer border
                  inside: BorderSide.none, // No inner borders
                ),
                children: snapshot.data!,
              );
            } else {
              // show a dialog with options to add a vocabulary for the empty category
              DialogNoVocabulary.show(
                context,
                intentionText: "\"${widget.category.categoryName}\" ${AppLocalizations.of(context)!.toOpen}",
                categoryId: widget.category.id,
              );

              // show an empty screen
              return SizedBox.shrink();
            }
          } else {
            return Container(
                decoration: BoxDecoration(
                    border: Border.all(color: BrandColors.colorPrimaryDark, width: 2.0),
                    borderRadius: const BorderRadius.all(Radius.circular(5))),
                child: const CircularProgressIndicator());
          }
        });
  }

  Stream<List<TableRow>> getVocabularyRows(final Database db) {
    int rowIndex = -1;

    return db.allCategoryVocabularies(widget.category.id).map((vocabulary) {
      rowIndex++;

      Color rowBackgroundColorEven, rowBackgroundColorOdd;
      if (vocabulary.isFavourite) {
        rowBackgroundColorEven = BrandColors.colorMarked.withAlpha(80);
        rowBackgroundColorOdd = BrandColors.colorMarked.withAlpha(50);
      } else {
        rowBackgroundColorEven = Color(0xFFf9f9f9);
        rowBackgroundColorOdd = Colors.white;
      }

      return TableRow(
        decoration: BoxDecoration(
          color: (rowIndex % 2) == 0 ? rowBackgroundColorEven : rowBackgroundColorOdd,
        ),
        children: [
          TableCell(
            verticalAlignment: TableCellVerticalAlignment.middle,
            child: GestureDetector(
              onTapDown: _getTapPosition,
              onLongPress: () => _showContextMenu(context, vocabulary),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Text(
                  vocabulary.vocForeign,
                  style: const TextStyle(color: Colors.black, fontSize: 18),
                ),
              ),
            ),
          ),
          TableCell(
            verticalAlignment: TableCellVerticalAlignment.middle,
            child: GestureDetector(
              onTapDown: _getTapPosition,
              onLongPress: () => _showContextMenu(context, vocabulary),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Text(
                  vocabulary.vocLocal,
                  style: const TextStyle(color: Colors.black, fontSize: 18),
                ),
              ),
            ),
          ),
        ],
      );
    }).watch();
  }

  void _getTapPosition(TapDownDetails details) {
    _tapPosition = details.globalPosition;
  }

  void _showContextMenu(BuildContext context, final Vocabulary vocabulary) async {
    final RenderObject? overlay = Overlay.of(context).context.findRenderObject();
    String textOptionMarkFavourite;

    if (vocabulary.isFavourite) {
      textOptionMarkFavourite = AppLocalizations.of(context)!.unmarkAsFavourite;
    } else {
      textOptionMarkFavourite = AppLocalizations.of(context)!.markAsFavourite;
    }

    final VocabularyOptions? option = await showMenu(
        context: context,
        position: RelativeRect.fromRect(Rect.fromLTWH(_tapPosition.dx, _tapPosition.dy, 30, 30),
            Rect.fromLTWH(0, 0, overlay!.paintBounds.size.width, overlay.paintBounds.size.height)),
        items: [
          PopupMenuItem(value: VocabularyOptions.optionEdit, child: Text(AppLocalizations.of(context)!.edit)),
          PopupMenuItem(value: VocabularyOptions.optionDelete, child: Text(AppLocalizations.of(context)!.delete)),
          PopupMenuItem(value: VocabularyOptions.optionMarkFavourite, child: Text(textOptionMarkFavourite)),
          PopupMenuItem(value: VocabularyOptions.optionReadOut, child: Text(AppLocalizations.of(context)!.readOut))
        ]);

    if (option != null) {
      switch (option) {
        case VocabularyOptions.optionEdit:
          if (mounted) {
            _showVocabEditOverlay(context, vocabulary);
          }
          break;
        case VocabularyOptions.optionDelete:
          if (mounted) {
            final Database db = Modular.get<Database>();
            db.deleteVocabulary(vocabulary.id);
          }
          break;
        case VocabularyOptions.optionReadOut:
          final VoiceOutput voiceOutput = VoiceOutput(language: widget.category.categoryLanguage);
          await voiceOutput.initTts();
          await voiceOutput.speak(vocabulary.vocForeign, null);
          break;
        case VocabularyOptions.optionMarkFavourite:
          if (mounted) {
            final Database db = Modular.get<Database>();
            db.toggleFavouriteStatus(vocabulary.id);
          }
          break;
      }
    }
  }

  void _showVocabEditOverlay(final BuildContext context, final Vocabulary vocabulary) async {
    showDialog(
        context: context,
        barrierDismissible: true,
        useSafeArea: true,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            backgroundColor: Colors.white,
            insetPadding: const EdgeInsets.all(20),
            child: Padding(
              padding: EdgeInsets.all(20),
              child: EditVocabulary(category: widget.category, vocabulary: vocabulary),
            ),
          );
        });
  }
}
