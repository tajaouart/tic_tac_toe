import 'package:flutter/material.dart';
import 'package:tic_tac_toe/domain/entities/game_state.dart';

class GameStatusBar extends StatelessWidget {
  final GameStatus status;
  final bool isAiThinking;

  const GameStatusBar({
    super.key,
    required this.status,
    this.isAiThinking = false,
  });

  String get _statusText {
    if (isAiThinking) return 'CPU is thinking...';

    switch (status) {
      case GameStatus.playing:
        return 'Your turn';
      case GameStatus.xWins:
        return 'You win!';
      case GameStatus.oWins:
        return 'CPU wins!';
      case GameStatus.draw:
        return "It's a draw!";
    }
  }

  Color _getStatusColor(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    switch (status) {
      case GameStatus.playing:
        return isAiThinking ? colorScheme.tertiary : colorScheme.primary;
      case GameStatus.xWins:
        return Colors.green;
      case GameStatus.oWins:
        return colorScheme.error;
      case GameStatus.draw:
        return colorScheme.outline;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      decoration: BoxDecoration(
        color: _getStatusColor(context).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isAiThinking) ...[
            SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: _getStatusColor(context),
              ),
            ),
            const SizedBox(width: 8),
          ],
          Text(
            _statusText,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: _getStatusColor(context),
            ),
          ),
        ],
      ),
    );
  }
}
