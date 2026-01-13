import 'package:flutter/material.dart';
import 'package:tic_tac_toe/l10n/generated/app_localizations.dart';

/// Tile widget for displaying and editing the player name.
class PlayerNameTile extends StatelessWidget {
  final String currentName;
  final ValueChanged<String> onChanged;

  const PlayerNameTile({
    super.key,
    required this.currentName,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return ListTile(
      leading: const Icon(Icons.person_outline),
      title: Text(l10n.playerName),
      subtitle: Text(currentName),
      onTap: () => _showNameDialog(context),
    );
  }

  void _showNameDialog(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final controller = TextEditingController(text: currentName);

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.changeName),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(
            labelText: l10n.name,
            border: const OutlineInputBorder(),
          ),
          autofocus: true,
          textCapitalization: TextCapitalization.words,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(l10n.cancel),
          ),
          FilledButton(
            onPressed: () {
              final name = controller.text.trim();
              if (name.isNotEmpty) {
                onChanged(name);
              }
              Navigator.pop(dialogContext);
            },
            child: Text(l10n.save),
          ),
        ],
      ),
    );
  }
}
