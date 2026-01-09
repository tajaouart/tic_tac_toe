import 'package:flutter/material.dart';

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
    return ListTile(
      leading: const Icon(Icons.person_outline),
      title: const Text('Player Name'),
      subtitle: Text(currentName),
      onTap: () => _showNameDialog(context),
    );
  }

  void _showNameDialog(BuildContext context) {
    final controller = TextEditingController(text: currentName);

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Change Name'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            labelText: 'Name',
            border: OutlineInputBorder(),
          ),
          autofocus: true,
          textCapitalization: TextCapitalization.words,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              final name = controller.text.trim();
              if (name.isNotEmpty) {
                onChanged(name);
              }
              Navigator.pop(dialogContext);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}
