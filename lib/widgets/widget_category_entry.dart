import 'dart:developer' as developer;

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:scanq_multiplatform/database/database.dart';
import 'package:scanq_multiplatform/layouts/activity_vocabulary_book.dart';

import '../common/data/brand_colors.dart';

enum CategoryOptions { optionDelete, optionEdit }

class CategoryEntry extends StatefulWidget {
  final Category category;

  const CategoryEntry({super.key, required this.category});

  @override
  State<CategoryEntry> createState() => _CategoryEntry();
}

class _CategoryEntry extends State<CategoryEntry> {
  Offset _tapPosition = Offset.zero;

  void _getTapPosition(TapDownDetails details) {
    // final RenderBox referenceBox = context.findRenderObject() as RenderBox;
    //setState(() {
    // _tapPosition = referenceBox.globalToLocal(details.globalPosition);
    _tapPosition = details.globalPosition;
    //});
  }

  void _showContextMenu(BuildContext context) async {
    final RenderObject? overlay = Overlay.of(context).context.findRenderObject();

    final CategoryOptions? option = await showMenu(
        context: context,
        position: RelativeRect.fromRect(Rect.fromLTWH(_tapPosition.dx, _tapPosition.dy, 30, 30),
            Rect.fromLTWH(0, 0, overlay!.paintBounds.size.width, overlay.paintBounds.size.height)),
        items: [
          PopupMenuItem(value: CategoryOptions.optionEdit, child: Text(AppLocalizations.of(context)!.edit)),
          PopupMenuItem(value: CategoryOptions.optionDelete, child: Text(AppLocalizations.of(context)!.delete))
        ]);

    if (option != null) {
      switch (option) {
        case CategoryOptions.optionEdit:
          // TODO: implement!
          break;
        case CategoryOptions.optionDelete:
          if (mounted) {
            final Database db = Modular.get<Database>();
            db.deleteCategory(widget.category.id);
          }
          break;
      }
    }
  }

  Stream<CategoryLearnInfoResult> getCategoryLearnInfo(final Database db) =>
      db.categoryLearnInfo(widget.category.id).watchSingle();

  @override
  Widget build(BuildContext context) {
    final Database db = Modular.get<Database>();

    return StreamBuilder(
        stream: getCategoryLearnInfo(db),
        builder: (context, AsyncSnapshot<CategoryLearnInfoResult> snapshot) {
          if (snapshot.connectionState == ConnectionState.active || snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return GestureDetector(
                  onTap: () {
                    developer.log("Opening category: ${widget.category.toString()}");
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) => VocabularyBook(category: widget.category)));
                  },
                  onTapDown: (TapDownDetails details) {
                    _getTapPosition(details);
                  },
                  onLongPress: () {
                    _showContextMenu(context);
                  },
                  child: Container(
                      decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black12))),
                      padding: const EdgeInsets.only(bottom: 10),
                      margin: const EdgeInsets.only(bottom: 20),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Padding(
                                padding: const EdgeInsets.only(left: 10, bottom: 5),
                                child: Text(widget.category.categoryName,
                                    textAlign: TextAlign.start,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(fontSize: 24, color: BrandColors.colorPrimary))),
                            Text(
                                AppLocalizations.of(context)!
                                    .xOfXVocabsLearned(snapshot.data!.amountLearned, snapshot.data!.categoryVocabsTotal),
                                style: const TextStyle(fontSize: 14))
                          ])));
            } else {
              return GestureDetector(
                  onTapDown: (TapDownDetails details) {
                    _getTapPosition(details);
                  },
                  onLongPress: () {
                    _showContextMenu(context);
                  },
                  child: Container(
                      decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black12))),
                      padding: const EdgeInsets.only(bottom: 10),
                      margin: const EdgeInsets.only(bottom: 20),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Padding(
                                padding: const EdgeInsets.only(left: 10, bottom: 5),
                                child: Text(widget.category.categoryName,
                                    textAlign: TextAlign.start,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(fontSize: 24, color: BrandColors.colorPrimary))),
                            Text(AppLocalizations.of(context)!.noVocabulariesYet, style: const TextStyle(fontSize: 14))
                          ])));
            }
          } else {
            return GestureDetector(
                onTapDown: (TapDownDetails details) {
                  _getTapPosition(details);
                },
                onLongPress: () {
                  _showContextMenu(context);
                },
                child: Container(
                    decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: Colors.black12))),
                    padding: const EdgeInsets.only(bottom: 10),
                    margin: const EdgeInsets.only(bottom: 20),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                              padding: const EdgeInsets.only(left: 10, bottom: 5),
                              child: Text(widget.category.categoryName,
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(fontSize: 24, color: BrandColors.colorPrimary))),
                          const Center(child: CircularProgressIndicator())
                        ])));
          }
        });
  }
}
