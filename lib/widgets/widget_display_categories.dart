import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lottie/lottie.dart';
import 'package:scanq_multiplatform/common/data/brand_colors.dart';
import 'package:scanq_multiplatform/gen/l10n/app_localizations.dart';
import 'package:scanq_multiplatform/widgets/widget_category_entry.dart';

import '../database/database.dart';

class CategoriesOverview extends StatelessWidget {
  CategoriesOverview({super.key});

  Stream<List<CategoryEntry>> getcategoryEntries(final Database db) =>
      db.allCategories().map((Category category) => CategoryEntry(category: category)).watch();

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
              // return a hint that is visible if the user cancels the dialog with back button
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 220,
                    width: 220,
                    child: Lottie.asset(
                      "assets/animation/empty_ghost.json",
                      fit: BoxFit.contain,
                      repeat: true,
                    ),
                  ),
                  Text(
                    AppLocalizations.of(context)!.noCategoriesFound,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 18,
                      color: BrandColors.colorPrimaryDark,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    AppLocalizations.of(context)!.instructionAddCategroy,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              );
            }
          } else {
            return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [header, const Center(child: CircularProgressIndicator())]);
          }
        });
  }
}
