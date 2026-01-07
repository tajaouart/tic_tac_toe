import 'package:equatable/equatable.dart';

abstract class GameEvent extends Equatable {
  const GameEvent();

  @override
  List<Object?> get props => [];
}

class CellTapped extends GameEvent {
  final int index;

  const CellTapped(this.index);

  @override
  List<Object?> get props => [index];
}

class GameReset extends GameEvent {
  const GameReset();
}

class AiMoveRequested extends GameEvent {
  const AiMoveRequested();
}
