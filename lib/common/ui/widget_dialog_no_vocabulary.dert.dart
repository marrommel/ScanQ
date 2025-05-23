import 'package:flutter/material.dart';
import 'package:quickalert/quickalert.dart';

import '../../gen/l10n/app_localizations.dart';
import '../../layouts/activity_vocabulary_manually.dart';
import '../../ocr/ui/activity_image_select.dart';
import '../data/brand_colors.dart';

class DialogNoVocabulary {
  static void show(
    BuildContext context, {
    String? title,
    String? intentionText,
    String? customText,
    bool showScanOption = true,
    bool showEnterManuallyOption = true,
    int? categoryId,
  }) {
    final loc = AppLocalizations.of(context)!;

    title = title ?? loc.addVocabularies;
    intentionText = intentionText ?? loc.toContinue;
    final String displayText = customText ?? '${loc.customNoVocabDialogText} $intentionText.';

    Future.microtask(() {
      QuickAlert.show(
        context: context,
        title: title,
        text: displayText,
        type: QuickAlertType.info,
        barrierColor: BrandColors.colorPrimary,
        disableBackBtn: false,
        barrierDismissible: false,
        confirmBtnColor: Colors.black.withAlpha(200),
        confirmBtnText: loc.back,
        confirmBtnTextStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
        onConfirmBtnTap: () {
          Navigator.of(context).pop(); // Close the dialog
          Navigator.of(context).pop(); // Close the underlying screen
        },
        widget: _buildOptions(context, categoryId, showScanOption, showEnterManuallyOption),
      );
    });
  }

  static Widget _buildOptions(BuildContext context, int? categoryId, bool showScanOption, bool showEnterManuallyOption) {
    List<Widget> buttons = [];

    if (showScanOption) {
      buttons.add(
        ElevatedButton(
          style: ButtonStyle(backgroundColor: WidgetStateProperty.all(Color(0xFFFBB307))),
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => ActivityImageSelect()));
          },
          child: Text(AppLocalizations.of(context)!.scanTitle, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        ),
      );
    }

    if (showEnterManuallyOption) {
      buttons.add(
        ElevatedButton(
          style: ButtonStyle(backgroundColor: WidgetStateProperty.all(Color(0xFFFBB307))),
          onPressed: () {
            Navigator.of(context).pop();
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (_) => ActivityVocabularyManually(categoryId: categoryId)));
          },
          child:
              Text(AppLocalizations.of(context)!.tapManuallyTitle, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        ),
      );
    }

    return buttons.isEmpty
        ? SizedBox.shrink()
        : Padding(
            padding: EdgeInsets.only(top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: buttons,
            ),
          );
  }
}
