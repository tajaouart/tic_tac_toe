import 'package:flutter_test/flutter_test.dart';
import 'package:tic_tac_toe/domain/entities/board.dart';
import 'package:tic_tac_toe/domain/entities/player.dart';

void main() {
  group('Board', () {
    test('empty board has 9 empty cells', () {
      final board = Board.empty();

      expect(board.cells.length, 9);
      expect(board.cells.every((cell) => cell == Player.none), true);
    });

    test('setCell places player at correct index', () {
      final board = Board.empty().setCell(4, Player.x);

      expect(board.getCell(4), Player.x);
      expect(board.getCell(0), Player.none);
    });

    test('isCellEmpty returns correct value', () {
      final board = Board.empty().setCell(0, Player.x);

      expect(board.isCellEmpty(0), false);
      expect(board.isCellEmpty(1), true);
    });

    test('emptyCells returns list of empty cell indices', () {
      var board = Board.empty();
      board = board.setCell(0, Player.x);
      board = board.setCell(4, Player.o);

      expect(board.emptyCells, [1, 2, 3, 5, 6, 7, 8]);
    });

    test('isFull returns true when all cells are filled', () {
      var board = Board.empty();
      for (int i = 0; i < 9; i++) {
        board = board.setCell(i, i % 2 == 0 ? Player.x : Player.o);
      }

      expect(board.isFull, true);
    });

    test('isFull returns false when board has empty cells', () {
      final board = Board.empty().setCell(0, Player.x);

      expect(board.isFull, false);
    });

    test('setCell ignores invalid indices', () {
      final board = Board.empty();

      expect(board.setCell(-1, Player.x), board);
      expect(board.setCell(9, Player.x), board);
    });

    test('getCell returns Player.none for invalid indices', () {
      final board = Board.empty();

      expect(board.getCell(-1), Player.none);
      expect(board.getCell(9), Player.none);
    });
  });
}
