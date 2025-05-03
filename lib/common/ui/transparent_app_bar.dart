import 'package:flutter/material.dart';

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
          title: const Text("Einscannen beenden"),
          content: const Text(
              "Bist du sicher, dass du das Einscannen abbrechen willst?\n\n(Hinweis: Die eingescannten Vokabeln gehen verloren)"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(), // Cancel
              child: const Text("Nein"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
                Navigator.of(context).pop(); // Go back
              },
              child: const Text("Ja"),
            ),
          ],
        );
      },
    );
  }
}
