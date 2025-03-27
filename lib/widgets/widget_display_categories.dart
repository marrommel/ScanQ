import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';
import 'package:scanq_multiplatform/common/brand_colors.dart';
import 'package:scanq_multiplatform/widgets/widget_category_entry.dart';

import '../database/database.dart';

class CategoriesOverview extends StatelessWidget {
  CategoriesOverview({super.key});

  Stream<List<CategoryEntry>> getcategoryEntries(final Database db) =>
      db.allCategories().map((Category category) => CategoryEntry(category: category)).watch();

  bool _isDialogShown = false;

  @override
  Widget build(BuildContext context) {
    Container header = Container(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(AppLocalizations.of(context)!.savedCategories,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: BrandColors.colorPrimaryDark)));

    final db = Modular.get<Database>();

    return StreamBuilder<List<CategoryEntry>>(
        stream: getcategoryEntries(db),
        builder: (context, AsyncSnapshot<List<CategoryEntry>> snapshot) {
          if (snapshot.connectionState == ConnectionState.active || snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              return Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
                header,
                Container(
                    padding: const EdgeInsets.only(top: 12, bottom: 12),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: snapshot.data!))
              ]);
            } else {
              Future.microtask(() {
                QuickAlert.show(
                    context: context,
                    type: QuickAlertType.info,
                    barrierColor: BrandColors.colorPrimary,
                    text:
                        "Du hast noch keine Vokabeln gespeichert. Scanne oder tippe neue Vokabeln ein, um die Übersicht zu öffnen.",
                    confirmBtnColor: Color(0xFFFFC847),
                    confirmBtnText: "OK",
                    title: "Vokabeln hinzufügen");
              });

              _isDialogShown = true;

              // close the underlying activity
              Navigator.pop(context);
              return const SizedBox(height: 1);
            }
          } else {
            return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [header, const Center(child: CircularProgressIndicator())]);
          }
        });
  }
}
