import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:scanq_multiplatform/common/brand_colors.dart';
import 'package:scanq_multiplatform/widgets/widget_category_entry.dart';

import '../database/database.dart';

class CategoriesOverview extends StatelessWidget {
  const CategoriesOverview({super.key});

  Stream<List<CategoryEntry>> getcategoryEntries(final Database db) =>
      db.allCategories().map((Category category) =>
        CategoryEntry(
            category: category
        )
    ).watch();

  @override
  Widget build(BuildContext context) {
    Container header = Container(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(
            AppLocalizations.of(context)!.savedCategories,
            style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: BrandColors.colorPrimaryDark
            )
        )
    );

    final db = Provider.of<Database>(context);

    return StreamBuilder<List<CategoryEntry>>(
      stream: getcategoryEntries(db),
      builder: (context, AsyncSnapshot<List<CategoryEntry>> snapshot) {
        if (snapshot.connectionState == ConnectionState.active ||
            snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasData) {
            return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  header,
                  Container(
                      padding: const EdgeInsets.only(top: 12, bottom: 12),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: snapshot.data!
                      )
                  )
                ]
              );
          } else {
            return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  header,
                  Text(
                      AppLocalizations.of(context)!.noDataFound
                  )
                ]
            );
          }
        } else {
          return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                header,
                const Center(
                  child: CircularProgressIndicator()
                )
              ]
          );
        }
      }
    );
  }

}
