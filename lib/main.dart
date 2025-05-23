import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import 'app_module.dart';
import 'app_widget.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isAndroid) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));
  }

  // configure Sentry for capturing errors
  await SentryFlutter.init(
    (options) {
      options.dsn = 'https://4264f8f510f73a0b9e8fb47552c0e19a@o4508443303477248.ingest.de.sentry.io/4508443306950736';
      options.debug = false;
      options.experimental.replay.sessionSampleRate = 1.0;
      options.experimental.replay.onErrorSampleRate = 1.0;
      options.attachScreenshot = true;
      options.enableAppHangTracking = true;
      options.experimental.privacy.maskAllImages = false;
      options.experimental.privacy.maskAllText = false;
    },

    // start the app inside a Sentry widget
    appRunner: () => runApp(
      SentryWidget(
        child: ModularApp(module: AppModule(), child: AppWidget()),
      ),
    ),
  );
}
