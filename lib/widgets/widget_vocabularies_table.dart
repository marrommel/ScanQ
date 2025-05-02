import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:scanq_multiplatform/common/ui/widget_dialog_no_vocabulary.dert.dart';
import 'package:scanq_multiplatform/gen/l10n/app_localizations.dart';
import 'package:scanq_multiplatform/speech/voice_output.dart';
import 'package:scanq_multiplatform/widgets/widget_edit_vocabulary.dart';

import '../common/data/brand_colors.dart';
import '../database/database.dart';

enum VocabularyOptions { optionDelete, optionEdit, optionMarkFavourite, optionReadOut }

class VocabulariesTable extends StatefulWidget {
  final Category category;

  const VocabulariesTable({super.key, required this.category});

  @override
  State<StatefulWidget> createState() => _VocabulariesTable();
}

class _VocabulariesTable extends State<VocabulariesTable> {
  Offset _tapPosition = Offset.zero;

  void _getTapPosition(TapDownDetails details) {
    //setState(() {
    _tapPosition = details.globalPosition;
    //});
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
            child: Padding(
              padding: EdgeInsets.all(20),
              child: EditVocabulary(category: widget.category, vocabulary: vocabulary),
            ),
          );
        });
  }

  Stream<List<TableRow>> getVocabularyRows(final Database db) =>
      db.allCategoryVocabularies(widget.category.id).map((Vocabulary vocabulary) {
        Color rowBackgroundColor;
        if (vocabulary.isFavourite) {
          rowBackgroundColor = BrandColors.colorMarked;
        } else {
          rowBackgroundColor = BrandColors.colorAccent;
        }
        return TableRow(children: [
          TableCell(
              child: GestureDetector(
                  onTapDown: _getTapPosition,
                  onLongPress: () => _showContextMenu(context, vocabulary),
                  child: Expanded(
                      child: Container(
                          color: rowBackgroundColor,
                          margin: const EdgeInsets.only(right: 2, bottom: 4),
                          child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Text(vocabulary.vocForeign,
                                  style: const TextStyle(color: BrandColors.colorText, fontSize: 18))))))),
          TableCell(
              child: GestureDetector(
                  onTapDown: _getTapPosition,
                  onLongPress: () => _showContextMenu(context, vocabulary),
                  child: Expanded(
                      child: Container(
                          color: rowBackgroundColor,
                          margin: const EdgeInsets.only(left: 2, bottom: 4),
                          child: Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: Text(vocabulary.vocLocal,
                                  style: const TextStyle(color: BrandColors.colorText, fontSize: 18)))))))
        ]);
      }).watch();

  @override
  Widget build(BuildContext context) {
    final Database db = Modular.get<Database>();

    return StreamBuilder<List<TableRow>>(
        stream: getVocabularyRows(db),
        builder: (BuildContext context, AsyncSnapshot<List<TableRow>> snapshot) {
          if (snapshot.connectionState == ConnectionState.active || snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              return Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: BrandColors.colorPrimaryDark, width: 2.0),
                      borderRadius: const BorderRadius.all(Radius.circular(5)),
                      color: BrandColors.colorTableBackground),
                  padding: const EdgeInsets.all(5.0),
                  child: Table(defaultColumnWidth: const FlexColumnWidth(), children: snapshot.data!));
            } else {
              // show a dialog with options to add a vocabulary for the empty category
              DialogNoVocabulary.show(
                context,
                intentionText: "\"${widget.category.categoryName}\" zu öffnen",
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
}
