import 'package:flutter/material.dart';
import 'package:tic_tac_toe/domain/entities/player.dart';

class GameCell extends StatelessWidget {
  final Player player;
  final VoidCallback onTap;
  final bool isWinningCell;
  final bool isEnabled;

  const GameCell({
    super.key,
    required this.player,
    required this.onTap,
    this.isWinningCell = false,
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: isEnabled ? onTap : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: isWinningCell
              ? colorScheme.primaryContainer
              : colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: colorScheme.outline.withValues(alpha: 0.3),
            width: 2,
          ),
        ),
        child: Center(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            child: player != Player.none
                ? Text(
                    player.symbol,
                    key: ValueKey(player),
                    style: TextStyle(
                      fontSize: 48,
                      fontWeight: FontWeight.bold,
                      color: player == Player.x
                          ? colorScheme.primary
                          : colorScheme.secondary,
                    ),
                  )
                : const SizedBox.shrink(),
          ),
        ),
      ),
    );
  }
}
