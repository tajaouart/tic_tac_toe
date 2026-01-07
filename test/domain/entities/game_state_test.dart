import 'package:flutter_test/flutter_test.dart';
import 'package:tic_tac_toe/domain/entities/board.dart';
import 'package:tic_tac_toe/domain/entities/game_state.dart';
import 'package:tic_tac_toe/domain/entities/player.dart';

void main() {
  group('GameState', () {
    test('initial state has empty board and X as current player', () {
      final state = GameState.initial();

      expect(state.board.emptyCells.length, 9);
      expect(state.currentPlayer, Player.x);
      expect(state.status, GameStatus.playing);
      expect(state.winningLine, null);
    });

    test('isGameOver returns false when playing', () {
      final state = GameState.initial();

      expect(state.isGameOver, false);
    });

    test('isGameOver returns true when X wins', () {
      final state = GameState(
        board: Board.empty(),
        currentPlayer: Player.x,
        status: GameStatus.xWins,
      );

      expect(state.isGameOver, true);
    });

    test('isGameOver returns true when O wins', () {
      final state = GameState(
        board: Board.empty(),
        currentPlayer: Player.x,
        status: GameStatus.oWins,
      );

      expect(state.isGameOver, true);
    });

    test('isGameOver returns true on draw', () {
      final state = GameState(
        board: Board.empty(),
        currentPlayer: Player.x,
        status: GameStatus.draw,
      );

      expect(state.isGameOver, true);
    });

    test('isHumanTurn returns true when current player is X', () {
      final state = GameState.initial();

      expect(state.isHumanTurn, true);
    });

    test('isHumanTurn returns false when current player is O', () {
      final state = GameState(
        board: Board.empty(),
        currentPlayer: Player.o,
        status: GameStatus.playing,
      );

      expect(state.isHumanTurn, false);
    });
  });
}
