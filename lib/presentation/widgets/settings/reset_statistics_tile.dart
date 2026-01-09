import 'package:flutter/material.dart';
import 'package:tic_tac_toe/presentation/widgets/common/confirmation_dialog.dart';

/// Tile widget for resetting game statistics.
class ResetStatisticsTile extends StatelessWidget {
  final VoidCallback onReset;

  const ResetStatisticsTile({
    super.key,
    required this.onReset,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.delete_outline),
      title: const Text('Reset Statistics'),
      subtitle: const Text('Clear all game history'),
      onTap: () => _showResetConfirmation(context),
    );
  }

  void _showResetConfirmation(BuildContext context) {
    ConfirmationDialog.show(
      context: context,
      title: 'Reset Statistics',
      content: 'This will permanently delete all your game history. This action cannot be undone.',
      confirmLabel: 'Reset',
      onConfirm: () {
        onReset();
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Statistics reset')),
        );
      },
    );
  }
}
