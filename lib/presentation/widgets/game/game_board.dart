import 'package:flutter/material.dart';
import 'package:tic_tac_toe/domain/entities/board.dart';
import 'package:tic_tac_toe/presentation/widgets/game/game_cell.dart';

/// Widget displaying the 3x3 Tic-Tac-Toe game board.
class GameBoard extends StatelessWidget {
  final Board board;
  final List<int>? winningLine;
  final bool isEnabled;
  final bool isAiThinking;
  final Function(int) onCellTap;

  const GameBoard({
    super.key,
    required this.board,
    required this.onCellTap,
    this.winningLine,
    this.isEnabled = true,
    this.isAiThinking = false,
  });

  @override
  Widget build(BuildContext context) {
    // Get all empty cell indices for scan animation sequencing
    final emptyCells = board.emptyCells;
    final totalEmptyCells = emptyCells.length;

    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        padding: const EdgeInsets.all(8),
        child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemCount: 9,
          itemBuilder: (context, index) {
            final isWinningCell = winningLine?.contains(index) ?? false;
            final cellEnabled = isEnabled && board.isCellEmpty(index);

            // Calculate scan index for this cell (position among empty cells)
            final scanIndex = emptyCells.indexOf(index);

            return GameCell(
              player: board.getCell(index),
              isWinningCell: isWinningCell,
              isEnabled: cellEnabled,
              isAiThinking: isAiThinking,
              scanIndex: scanIndex >= 0 ? scanIndex : 0,
              totalEmptyCells: totalEmptyCells,
              onTap: () => onCellTap(index),
            );
          },
        ),
      ),
    );
  }
}
