import 'package:flutter/material.dart';
import 'package:tic_tac_toe/l10n/generated/app_localizations.dart';
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
    final l10n = AppLocalizations.of(context);

    return ListTile(
      leading: const Icon(Icons.delete_outline),
      title: Text(l10n.resetStatistics),
      subtitle: Text(l10n.resetStatisticsDescription),
      onTap: () => _showResetConfirmation(context),
    );
  }

  void _showResetConfirmation(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    ConfirmationDialog.show(
      context: context,
      title: l10n.confirmReset,
      content: l10n.resetConfirmationMessage,
      confirmLabel: l10n.reset,
      onConfirm: () {
        onReset();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.statisticsReset)),
        );
      },
    );
  }
}
