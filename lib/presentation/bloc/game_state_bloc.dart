import 'package:equatable/equatable.dart';
import 'package:tic_tac_toe/domain/entities/game_state.dart' as domain;

abstract class GameBlocState extends Equatable {
  const GameBlocState();

  @override
  List<Object?> get props => [];
}

class GameInitial extends GameBlocState {
  const GameInitial();
}

class GameInProgress extends GameBlocState {
  final domain.GameState gameState;
  final bool isAiThinking;

  const GameInProgress({
    required this.gameState,
    this.isAiThinking = false,
  });

  @override
  List<Object?> get props => [gameState, isAiThinking];

  GameInProgress copyWith({
    domain.GameState? gameState,
    bool? isAiThinking,
  }) {
    return GameInProgress(
      gameState: gameState ?? this.gameState,
      isAiThinking: isAiThinking ?? this.isAiThinking,
    );
  }
}
