import 'package:equatable/equatable.dart';
import 'package:tic_tac_toe/domain/entities/player.dart';

class Board extends Equatable {
  final List<Player> cells;

  const Board({required this.cells});

  factory Board.empty() {
    return Board(cells: List.filled(9, Player.none));
  }

  Board copyWith({List<Player>? cells}) {
    return Board(cells: cells ?? List.from(this.cells));
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
    for (int i = 0; i < 9; i++) {
      if (cells[i] == Player.none) {
        empty.add(i);
      }
    }
    return empty;
  }

  bool get isFull => emptyCells.isEmpty;

  @override
  List<Object?> get props => [cells];
}
