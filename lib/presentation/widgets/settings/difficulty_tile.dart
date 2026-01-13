import 'package:flutter/material.dart';
import 'package:tic_tac_toe/l10n/generated/app_localizations.dart';
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
    final l10n = AppLocalizations.of(context);

    return ListTile(
      leading: const Icon(Icons.psychology_outlined),
      title: Text(l10n.difficulty),
      subtitle: Text(_getDifficultyName(context, currentDifficulty)),
      onTap: () => _showDifficultyDialog(context),
    );
  }

  String _getDifficultyName(BuildContext context, Difficulty difficulty) {
    final l10n = AppLocalizations.of(context);
    return switch (difficulty) {
      Difficulty.easy => l10n.easy,
      Difficulty.medium => l10n.medium,
      Difficulty.hard => l10n.hard,
    };
  }

  String _getDifficultyDescription(BuildContext context, Difficulty difficulty) {
    final l10n = AppLocalizations.of(context);
    return switch (difficulty) {
      Difficulty.easy => l10n.easyDescription,
      Difficulty.medium => l10n.mediumDescription,
      Difficulty.hard => l10n.hardDescription,
    };
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
        getDifficultyName: (d) => _getDifficultyName(context, d),
        getDifficultyDescription: (d) => _getDifficultyDescription(context, d),
      ),
    );
  }
}

class _DifficultyDialog extends StatefulWidget {
  final Difficulty currentDifficulty;
  final ValueChanged<Difficulty> onSelected;
  final String Function(Difficulty) getDifficultyName;
  final String Function(Difficulty) getDifficultyDescription;

  const _DifficultyDialog({
    required this.currentDifficulty,
    required this.onSelected,
    required this.getDifficultyName,
    required this.getDifficultyDescription,
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
    final l10n = AppLocalizations.of(context);

    return AlertDialog(
      title: Text(l10n.selectDifficulty),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: Difficulty.values.map((difficulty) {
          return _DifficultyOption(
            difficulty: difficulty,
            isSelected: _selectedDifficulty == difficulty,
            difficultyName: widget.getDifficultyName(difficulty),
            difficultyDescription: widget.getDifficultyDescription(difficulty),
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
  final String difficultyName;
  final String difficultyDescription;
  final VoidCallback onTap;

  const _DifficultyOption({
    required this.difficulty,
    required this.isSelected,
    required this.difficultyName,
    required this.difficultyDescription,
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
                    difficultyName,
                    style: TextStyle(
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      color: isSelected ? colorScheme.onPrimaryContainer : null,
                    ),
                  ),
                  Text(
                    difficultyDescription,
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
