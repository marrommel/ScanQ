import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:scanq_multiplatform/database/database.dart';
import 'package:scanq_multiplatform/widgets/widget_main_menu.dart';

import 'common/brand_colors.dart';

void main() async {
  runApp(Provider<Database>(create: (context) => Database(), child: const DataManager(), dispose: (context, db) => db.close()));
}

class DataManager extends StatelessWidget {
  const DataManager({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ScanQ',
      theme: ThemeData(
          // colorSchemeSeed: BrandColors.colorPrimaryMaterial,
          primarySwatch: BrandColors.colorPrimaryMaterial,
          useMaterial3: false),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: Scaffold(
        appBar: null,
        body: ListView(children: [
          Container(
              margin: const EdgeInsets.all(15),
              child: Material(
                  elevation: 3,
                  borderRadius: const BorderRadius.all(Radius.circular(5)),
                  child: Container(padding: const EdgeInsets.all(20), child: const MainMenu())))
        ]),
      ),
    );
  }
}
