import 'package:flutter/material.dart';
import 'package:tic_tac_toe/domain/entities/difficulty.dart';

/// Tile widget for selecting game difficulty.
class DifficultyTile extends StatelessWidget {
  final Difficulty currentDifficulty;
  final ValueChanged<Difficulty> onChanged;

  const DifficultyTile({
    super.key,
    required this.currentDifficulty,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.psychology_outlined),
      title: const Text('Difficulty'),
      subtitle: Text(currentDifficulty.displayName),
      onTap: () => _showDifficultyDialog(context),
    );
  }

  void _showDifficultyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => _DifficultyDialog(
        currentDifficulty: currentDifficulty,
        onSelected: (difficulty) {
          onChanged(difficulty);
          Navigator.pop(dialogContext);
        },
      ),
    );
  }
}

class _DifficultyDialog extends StatefulWidget {
  final Difficulty currentDifficulty;
  final ValueChanged<Difficulty> onSelected;

  const _DifficultyDialog({
    required this.currentDifficulty,
    required this.onSelected,
  });

  @override
  State<_DifficultyDialog> createState() => _DifficultyDialogState();
}

class _DifficultyDialogState extends State<_DifficultyDialog> {
  late Difficulty _selectedDifficulty;

  @override
  void initState() {
    super.initState();
    _selectedDifficulty = widget.currentDifficulty;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Select Difficulty'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: Difficulty.values.map((difficulty) {
          return _DifficultyOption(
            difficulty: difficulty,
            isSelected: _selectedDifficulty == difficulty,
            onTap: () {
              setState(() => _selectedDifficulty = difficulty);
              widget.onSelected(difficulty);
            },
          );
        }).toList(),
      ),
    );
  }
}

class _DifficultyOption extends StatelessWidget {
  final Difficulty difficulty;
  final bool isSelected;
  final VoidCallback onTap;

  const _DifficultyOption({
    required this.difficulty,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: isSelected ? colorScheme.primaryContainer : null,
        ),
        child: Row(
          children: [
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
              color: isSelected ? colorScheme.primary : colorScheme.outline,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    difficulty.displayName,
                    style: TextStyle(
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      color: isSelected ? colorScheme.onPrimaryContainer : null,
                    ),
                  ),
                  Text(
                    difficulty.description,
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: isSelected
                              ? colorScheme.onPrimaryContainer.withValues(alpha: 0.7)
                              : colorScheme.outline,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
