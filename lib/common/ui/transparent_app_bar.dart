import 'package:flutter/material.dart';

import '../../gen/l10n/app_localizations.dart';

class TransparentAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool showWaringOnClose;

  const TransparentAppBar({super.key, this.showWaringOnClose = false});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () {
          if (showWaringOnClose) {
            _showWarningDialog(context);
          } else {
            Navigator.of(context).pop();
          }
        },
      ),
    );
  }

  void _showWarningDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(AppLocalizations.of(context)!.endScan),
          content: Text(AppLocalizations.of(context)!.cancelScanWarning),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(), // Cancel
              child: Text(AppLocalizations.of(context)!.no),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
                Navigator.of(context).pop(); // Go back
              },
              child: Text(AppLocalizations.of(context)!.yes),
            ),
          ],
        );
      },
    );
  }
}
