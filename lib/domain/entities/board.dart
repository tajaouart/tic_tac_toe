import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tic_tac_toe/domain/entities/player.dart';

part 'board.freezed.dart';

@freezed
class Board with _$Board {
  const Board._();

  const factory Board({
    required List<Player> cells,
  }) = _Board;

  factory Board.empty() {
    return Board(cells: List.filled(9, Player.none));
  }

  Player getCell(int index) {
    if (index < 0 || index >= 9) return Player.none;
    return cells[index];
  }

  Board setCell(int index, Player player) {
    if (index < 0 || index >= 9) return this;
    final newCells = List<Player>.from(cells);
    newCells[index] = player;
    return Board(cells: newCells);
  }

  bool isCellEmpty(int index) {
    return getCell(index) == Player.none;
  }

  List<int> get emptyCells {
    final empty = <int>[];
    for (var i = 0; i < 9; i++) {
      if (cells[i] == Player.none) {
        empty.add(i);
      }
    }
    return empty;
  }

  bool get isFull => emptyCells.isEmpty;
}
