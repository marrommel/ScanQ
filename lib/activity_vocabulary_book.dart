import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:scanq_multiplatform/speech/voice_output.dart';
import 'package:scanq_multiplatform/widgets/widget_vocabularies_table.dart';

import 'common/brand_colors.dart';
import 'database/database.dart';

class VocabularyBook extends StatefulWidget {
  final Category category;

  const VocabularyBook({super.key, required this.category});

  @override
  State<VocabularyBook> createState() => _VocabularyBook();
}

class _VocabularyBook extends State<VocabularyBook> {
  bool isReadingOut = false;

  Future readOutNextVocabulary(final BuildContext context, final List<Vocabulary> vocabularies, final int pointer) async {
    final VoiceOutput voiceOutput = VoiceOutput(language: widget.category.categoryLanguage);
    await voiceOutput.initTts();

    await voiceOutput.speakInLanguage(vocabularies[pointer].vocForeign, widget.category.categoryLanguage, () async {
      if (isReadingOut) {
        await voiceOutput.speakInLanguage("${AppLocalizations.of(context)!.means} ${vocabularies[pointer].vocLocal}", "DE", () {
          if (pointer + 1 < vocabularies.length) {
            if (isReadingOut) {
              readOutNextVocabulary(context, vocabularies, pointer + 1);
            }
          } else {
            setState(() {
              isReadingOut = false;
            });
          }
        });
      }
    });
  }

  TextButton getButtonReadingAction() {
    if (isReadingOut) {
      return TextButton.icon(
          onPressed: () {
            setState(() {
              isReadingOut = false;
            });
          },
          icon: const Icon(Icons.speaker_notes_off),
          label: Text(AppLocalizations.of(context)!.stopReadingOut));
    } else {
      return TextButton.icon(
          onPressed: () async {
            setState(() {
              isReadingOut = true;
            });
            final Database db = Provider.of<Database>(context, listen: false);
            final List<Vocabulary> vocabularies = await db.allCategoryVocabularies(widget.category.id).get();

            readOutNextVocabulary(context, vocabularies, 0);
          },
          icon: const Icon(Icons.speaker_notes),
          label: Text(AppLocalizations.of(context)!.readOutVocabularyBook));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: null,
        body: ListView(children: [
          Container(
              margin: const EdgeInsets.all(15),
              child: Material(
                  elevation: 3,
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  child: Container(
                      padding: const EdgeInsets.all(20),
                      child: Column(children: [
                        Text(widget.category.categoryName,
                            style:
                                const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: BrandColors.colorPrimaryDark)),
                        //getButtonReadingAction(),
                        VocabulariesTable(category: widget.category)
                      ]))))
        ]));
  }
}
