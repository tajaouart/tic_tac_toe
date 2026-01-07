import 'dart:math';

import 'package:tic_tac_toe/domain/entities/board.dart';
import 'package:tic_tac_toe/domain/entities/game_state.dart';
import 'package:tic_tac_toe/domain/entities/player.dart';
import 'package:tic_tac_toe/domain/repositories/game_repository.dart';

class GameRepositoryImpl implements GameRepository {
  static const List<List<int>> _winningCombinations = [
    [0, 1, 2], // Top row
    [3, 4, 5], // Middle row
    [6, 7, 8], // Bottom row
    [0, 3, 6], // Left column
    [1, 4, 7], // Middle column
    [2, 5, 8], // Right column
    [0, 4, 8], // Diagonal
    [2, 4, 6], // Anti-diagonal
  ];

  @override
  GameState makeMove(GameState currentState, int cellIndex) {
    if (currentState.isGameOver) return currentState;
    if (!currentState.board.isCellEmpty(cellIndex)) return currentState;

    final newBoard = currentState.board.setCell(
      cellIndex,
      currentState.currentPlayer,
    );

    final status = checkGameStatus(newBoard);
    final winningLine = status != GameStatus.playing ? getWinningLine(newBoard) : null;

    return GameState(
      board: newBoard,
      currentPlayer: currentState.currentPlayer.opponent,
      status: status,
      winningLine: winningLine,
    );
  }

  @override
  GameState resetGame() {
    return GameState.initial();
  }

  @override
  GameStatus checkGameStatus(Board board) {
    final winner = _getWinner(board);
    if (winner == Player.x) return GameStatus.xWins;
    if (winner == Player.o) return GameStatus.oWins;
    if (board.isFull) return GameStatus.draw;
    return GameStatus.playing;
  }

  @override
  List<int>? getWinningLine(Board board) {
    for (final combination in _winningCombinations) {
      final a = board.getCell(combination[0]);
      final b = board.getCell(combination[1]);
      final c = board.getCell(combination[2]);

      if (a != Player.none && a == b && b == c) {
        return combination;
      }
    }
    return null;
  }

  Player _getWinner(Board board) {
    for (final combination in _winningCombinations) {
      final a = board.getCell(combination[0]);
      final b = board.getCell(combination[1]);
      final c = board.getCell(combination[2]);

      if (a != Player.none && a == b && b == c) {
        return a;
      }
    }
    return Player.none;
  }

  @override
  int getAiMove(Board board, Player aiPlayer) {
    final emptyCells = board.emptyCells;
    if (emptyCells.isEmpty) return -1;

    int bestScore = -1000;
    int bestMove = emptyCells.first;

    for (final cell in emptyCells) {
      final newBoard = board.setCell(cell, aiPlayer);
      final score = _minimax(newBoard, 0, false, aiPlayer);

      if (score > bestScore) {
        bestScore = score;
        bestMove = cell;
      }
    }

    return bestMove;
  }

  int _minimax(Board board, int depth, bool isMaximizing, Player aiPlayer) {
    final winner = _getWinner(board);
    final humanPlayer = aiPlayer.opponent;

    if (winner == aiPlayer) return 10 - depth;
    if (winner == humanPlayer) return depth - 10;
    if (board.isFull) return 0;

    if (isMaximizing) {
      int bestScore = -1000;
      for (final cell in board.emptyCells) {
        final newBoard = board.setCell(cell, aiPlayer);
        final score = _minimax(newBoard, depth + 1, false, aiPlayer);
        bestScore = max(bestScore, score);
      }
      return bestScore;
    } else {
      int bestScore = 1000;
      for (final cell in board.emptyCells) {
        final newBoard = board.setCell(cell, humanPlayer);
        final score = _minimax(newBoard, depth + 1, true, aiPlayer);
        bestScore = min(bestScore, score);
      }
      return bestScore;
    }
  }
}
