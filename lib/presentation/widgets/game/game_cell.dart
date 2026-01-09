import 'package:flutter/material.dart';
import 'package:tic_tac_toe/core/constants/app_constants.dart';
import 'package:tic_tac_toe/domain/entities/player.dart';

/// Widget representing a single cell in the game board.
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
        duration: const Duration(milliseconds: AppConstants.defaultAnimationDuration),
        decoration: BoxDecoration(
          color: isWinningCell
              ? colorScheme.primaryContainer
              : colorScheme.surface,
          borderRadius: BorderRadius.circular(AppConstants.cellBorderRadius),
          border: Border.all(
            color: colorScheme.outline.withValues(alpha: 0.3),
            width: AppConstants.cellBorderWidth,
          ),
        ),
        child: Center(
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: AppConstants.defaultAnimationDuration),
            child: player != Player.none
                ? _PlayerSymbol(player: player)
                : const SizedBox.shrink(),
          ),
        ),
      ),
    );
  }
}

class _PlayerSymbol extends StatelessWidget {
  final Player player;

  const _PlayerSymbol({required this.player});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Text(
      player.symbol,
      key: ValueKey(player),
      style: TextStyle(
        fontSize: AppConstants.cellFontSize,
        fontWeight: FontWeight.bold,
        color: player == Player.x
            ? colorScheme.primary
            : colorScheme.secondary,
      ),
    );
  }
}
