import 'package:flutter/material.dart';

/// A reusable confirmation dialog widget.
class ConfirmationDialog extends StatelessWidget {
  final String title;
  final String content;
  final String cancelLabel;
  final String confirmLabel;
  final VoidCallback onConfirm;

  const ConfirmationDialog({
    super.key,
    required this.title,
    required this.content,
    this.cancelLabel = 'Cancel',
    this.confirmLabel = 'Confirm',
    required this.onConfirm,
  });

  /// Shows the confirmation dialog.
  static Future<bool?> show({
    required BuildContext context,
    required String title,
    required String content,
    String cancelLabel = 'Cancel',
    String confirmLabel = 'Confirm',
    required VoidCallback onConfirm,
  }) {
    return showDialog<bool>(
      context: context,
      builder: (dialogContext) => ConfirmationDialog(
        title: title,
        content: content,
        cancelLabel: cancelLabel,
        confirmLabel: confirmLabel,
        onConfirm: () {
          onConfirm();
          Navigator.pop(dialogContext, true);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: Text(cancelLabel),
        ),
        FilledButton(
          onPressed: onConfirm,
          child: Text(confirmLabel),
        ),
      ],
    );
  }
}
