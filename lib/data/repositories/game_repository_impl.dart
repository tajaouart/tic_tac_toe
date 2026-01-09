import 'dart:math';

import 'package:injectable/injectable.dart';
import 'package:tic_tac_toe/core/constants/app_constants.dart';
import 'package:tic_tac_toe/domain/entities/board.dart';
import 'package:tic_tac_toe/domain/entities/difficulty.dart';
import 'package:tic_tac_toe/domain/entities/game_state.dart';
import 'package:tic_tac_toe/domain/entities/player.dart';
import 'package:tic_tac_toe/domain/repositories/game_repository.dart';

/// Implementation of [GameRepository] providing game logic.
///
/// Handles move validation, game status checking, and AI opponent logic
/// using the minimax algorithm for hard difficulty.
@LazySingleton(as: GameRepository)
class GameRepositoryImpl implements GameRepository {
  final Random _random = Random();

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
    for (final combination in WinningCombinations.all) {
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
    for (final combination in WinningCombinations.all) {
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
  int getAiMove(Board board, Player aiPlayer, Difficulty difficulty) {
    final emptyCells = board.emptyCells;
    if (emptyCells.isEmpty) return -1;

    switch (difficulty) {
      case Difficulty.easy:
        return _getRandomMove(emptyCells);
      case Difficulty.medium:
        return _getMediumMove(board, aiPlayer, emptyCells);
      case Difficulty.hard:
        return _getMinimaxMove(board, aiPlayer, emptyCells);
    }
  }

  int _getRandomMove(List<int> emptyCells) {
    return emptyCells[_random.nextInt(emptyCells.length)];
  }

  int _getMediumMove(Board board, Player aiPlayer, List<int> emptyCells) {
    // 50% chance to play optimal, 50% random
    if (_random.nextBool()) {
      return _getMinimaxMove(board, aiPlayer, emptyCells);
    }

    // Try to win if possible
    final winningMove = _findWinningMove(board, aiPlayer);
    if (winningMove != null) return winningMove;

    // Block opponent if they can win
    final blockingMove = _findWinningMove(board, aiPlayer.opponent);
    if (blockingMove != null) return blockingMove;

    // Otherwise random
    return _getRandomMove(emptyCells);
  }

  int? _findWinningMove(Board board, Player player) {
    for (final cell in board.emptyCells) {
      final newBoard = board.setCell(cell, player);
      if (_getWinner(newBoard) == player) {
        return cell;
      }
    }
    return null;
  }

  /// Finds the best move using the minimax algorithm.
  ///
  /// The minimax algorithm evaluates all possible game states to find the
  /// optimal move. It assumes both players play optimally and returns
  /// the move that maximizes the AI's chances of winning while minimizing
  /// the opponent's chances.
  int _getMinimaxMove(Board board, Player aiPlayer, List<int> emptyCells) {
    int bestScore = AppConstants.minimaxInitialBestScore;
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

  /// Recursive minimax evaluation function.
  ///
  /// [board] - Current board state to evaluate
  /// [depth] - Current search depth (used to prefer faster wins)
  /// [isMaximizing] - True if evaluating AI's turn, false for human
  /// [aiPlayer] - The player the AI is controlling
  ///
  /// Returns a score where positive values favor AI, negative favor human.
  int _minimax(Board board, int depth, bool isMaximizing, Player aiPlayer) {
    final winner = _getWinner(board);
    final humanPlayer = aiPlayer.opponent;

    // Terminal state evaluation - prefer faster wins/slower losses
    if (winner == aiPlayer) return AppConstants.minimaxWinScore - depth;
    if (winner == humanPlayer) return depth + AppConstants.minimaxLoseScore;
    if (board.isFull) return AppConstants.minimaxDrawScore;

    if (isMaximizing) {
      int bestScore = AppConstants.minimaxInitialBestScore;
      for (final cell in board.emptyCells) {
        final newBoard = board.setCell(cell, aiPlayer);
        final score = _minimax(newBoard, depth + 1, false, aiPlayer);
        bestScore = max(bestScore, score);
      }
      return bestScore;
    } else {
      int bestScore = AppConstants.minimaxInitialWorstScore;
      for (final cell in board.emptyCells) {
        final newBoard = board.setCell(cell, humanPlayer);
        final score = _minimax(newBoard, depth + 1, true, aiPlayer);
        bestScore = min(bestScore, score);
      }
      return bestScore;
    }
  }
}
