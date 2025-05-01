import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:scanq_multiplatform/gen/l10n/app_localizations.dart';

import 'common/data/brand_colors.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'ScanQ',
      theme: ThemeData(primarySwatch: BrandColors.colorPrimaryMaterial, useMaterial3: false),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: Modular.routerConfig,
    );
  }
}
