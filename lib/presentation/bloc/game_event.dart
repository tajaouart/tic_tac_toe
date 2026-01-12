import 'package:equatable/equatable.dart';
import 'package:tic_tac_toe/domain/entities/difficulty.dart';
import 'package:tic_tac_toe/domain/entities/game_state.dart';

/// Base class for all game events.
abstract class GameEvent extends Equatable {
  const GameEvent();

  @override
  List<Object?> get props => [];
}

/// Event triggered when a cell is tapped.
class CellTapped extends GameEvent {
  final int index;
  final Difficulty difficulty;

  const CellTapped({
    required this.index,
    required this.difficulty,
  });

  @override
  List<Object?> get props => [index, difficulty];
}

/// Event triggered to reset the game.
class GameReset extends GameEvent {
  const GameReset();
}

/// Event triggered to request an AI move.
class AiMoveRequested extends GameEvent {
  final Difficulty difficulty;

  const AiMoveRequested({required this.difficulty});

  @override
  List<Object?> get props => [difficulty];
}

/// Event triggered when a game result has been recorded externally.
/// This marks the result as recorded to prevent duplicate recordings.
class GameResultRecorded extends GameEvent {
  const GameResultRecorded();
}
