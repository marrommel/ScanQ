import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'app_module.dart';
import 'app_widget.dart';

// organization https://felipeemidio.medium.com/folder-structure-for-flutter-with-clean-architecture-how-i-do-bbe29225774f
// https://pub.dev/packages/flutter_modular

// or define SENTRY_DSN via Dart environment variable (--dart-define)

Future<void> main() async {
  await SentryFlutter.init((options) {
    options.dsn = 'https://4264f8f510f73a0b9e8fb47552c0e19a@o4508443303477248.ingest.de.sentry.io/4508443306950736';
  }, appRunner: () => runApp(ModularApp(module: AppModule(), child: AppWidget())));
}
