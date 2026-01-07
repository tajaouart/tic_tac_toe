import 'package:flutter_test/flutter_test.dart';
import 'package:tic_tac_toe/data/repositories/game_repository_impl.dart';
import 'package:tic_tac_toe/domain/entities/board.dart';
import 'package:tic_tac_toe/domain/entities/game_state.dart';
import 'package:tic_tac_toe/domain/entities/player.dart';

void main() {
  late GameRepositoryImpl repository;

  setUp(() {
    repository = GameRepositoryImpl();
  });

  group('GameRepositoryImpl', () {
    group('makeMove', () {
      test('places player marker and switches turn', () {
        final initialState = GameState.initial();
        final newState = repository.makeMove(initialState, 0);

        expect(newState.board.getCell(0), Player.x);
        expect(newState.currentPlayer, Player.o);
      });

      test('ignores move on occupied cell', () {
        var state = GameState.initial();
        state = repository.makeMove(state, 0);
        final newState = repository.makeMove(state, 0);

        expect(newState.board.getCell(0), Player.x);
        expect(newState.currentPlayer, Player.o);
      });

      test('ignores move when game is over', () {
        final state = GameState(
          board: Board.empty(),
          currentPlayer: Player.x,
          status: GameStatus.xWins,
        );
        final newState = repository.makeMove(state, 4);

        expect(newState, state);
      });

      test('detects X win', () {
        var state = GameState.initial();
        // X plays: 0, 1, 2 (top row)
        state = repository.makeMove(state, 0); // X at 0
        state = repository.makeMove(state, 3); // O at 3
        state = repository.makeMove(state, 1); // X at 1
        state = repository.makeMove(state, 4); // O at 4
        state = repository.makeMove(state, 2); // X at 2 - wins

        expect(state.status, GameStatus.xWins);
        expect(state.winningLine, [0, 1, 2]);
      });

      test('detects O win', () {
        var state = GameState.initial();
        state = repository.makeMove(state, 0); // X at 0
        state = repository.makeMove(state, 3); // O at 3
        state = repository.makeMove(state, 1); // X at 1
        state = repository.makeMove(state, 4); // O at 4
        state = repository.makeMove(state, 8); // X at 8
        state = repository.makeMove(state, 5); // O at 5 - wins

        expect(state.status, GameStatus.oWins);
        expect(state.winningLine, [3, 4, 5]);
      });

      test('detects draw', () {
        var state = GameState.initial();
        // X O X
        // X X O
        // O X O
        state = repository.makeMove(state, 0); // X
        state = repository.makeMove(state, 1); // O
        state = repository.makeMove(state, 2); // X
        state = repository.makeMove(state, 5); // O
        state = repository.makeMove(state, 3); // X
        state = repository.makeMove(state, 6); // O
        state = repository.makeMove(state, 4); // X
        state = repository.makeMove(state, 8); // O
        state = repository.makeMove(state, 7); // X - draw

        expect(state.status, GameStatus.draw);
      });
    });

    group('resetGame', () {
      test('returns initial game state', () {
        final state = repository.resetGame();

        expect(state.board.emptyCells.length, 9);
        expect(state.currentPlayer, Player.x);
        expect(state.status, GameStatus.playing);
      });
    });

    group('checkGameStatus', () {
      test('returns playing for empty board', () {
        final board = Board.empty();

        expect(repository.checkGameStatus(board), GameStatus.playing);
      });

      test('returns xWins for horizontal win', () {
        var board = Board.empty();
        board = board.setCell(0, Player.x);
        board = board.setCell(1, Player.x);
        board = board.setCell(2, Player.x);

        expect(repository.checkGameStatus(board), GameStatus.xWins);
      });

      test('returns oWins for vertical win', () {
        var board = Board.empty();
        board = board.setCell(0, Player.o);
        board = board.setCell(3, Player.o);
        board = board.setCell(6, Player.o);

        expect(repository.checkGameStatus(board), GameStatus.oWins);
      });

      test('returns xWins for diagonal win', () {
        var board = Board.empty();
        board = board.setCell(0, Player.x);
        board = board.setCell(4, Player.x);
        board = board.setCell(8, Player.x);

        expect(repository.checkGameStatus(board), GameStatus.xWins);
      });

      test('returns draw for full board with no winner', () {
        var board = Board.empty();
        // X O X
        // X X O
        // O X O
        board = board.setCell(0, Player.x);
        board = board.setCell(1, Player.o);
        board = board.setCell(2, Player.x);
        board = board.setCell(3, Player.x);
        board = board.setCell(4, Player.x);
        board = board.setCell(5, Player.o);
        board = board.setCell(6, Player.o);
        board = board.setCell(7, Player.x);
        board = board.setCell(8, Player.o);

        expect(repository.checkGameStatus(board), GameStatus.draw);
      });
    });

    group('getWinningLine', () {
      test('returns null for no winner', () {
        final board = Board.empty();

        expect(repository.getWinningLine(board), null);
      });

      test('returns correct winning line for top row', () {
        var board = Board.empty();
        board = board.setCell(0, Player.x);
        board = board.setCell(1, Player.x);
        board = board.setCell(2, Player.x);

        expect(repository.getWinningLine(board), [0, 1, 2]);
      });

      test('returns correct winning line for diagonal', () {
        var board = Board.empty();
        board = board.setCell(2, Player.o);
        board = board.setCell(4, Player.o);
        board = board.setCell(6, Player.o);

        expect(repository.getWinningLine(board), [2, 4, 6]);
      });
    });

    group('getAiMove', () {
      test('returns valid cell index', () {
        final board = Board.empty();
        final move = repository.getAiMove(board, Player.o);

        expect(move >= 0 && move < 9, true);
      });

      test('blocks opponent winning move', () {
        var board = Board.empty();
        board = board.setCell(0, Player.x);
        board = board.setCell(1, Player.x);
        // X needs cell 2 to win, AI should block

        final move = repository.getAiMove(board, Player.o);
        expect(move, 2);
      });

      test('takes winning move when available', () {
        var board = Board.empty();
        board = board.setCell(0, Player.o);
        board = board.setCell(1, Player.o);
        board = board.setCell(4, Player.x);
        board = board.setCell(8, Player.x);
        // O can win with cell 2

        final move = repository.getAiMove(board, Player.o);
        expect(move, 2);
      });

      test('returns -1 for full board', () {
        var board = Board.empty();
        for (int i = 0; i < 9; i++) {
          board = board.setCell(i, i % 2 == 0 ? Player.x : Player.o);
        }

        final move = repository.getAiMove(board, Player.o);
        expect(move, -1);
      });
    });
  });
}
