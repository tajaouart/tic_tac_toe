import 'package:tic_tac_toe/core/usecases/usecase.dart';
import 'package:tic_tac_toe/domain/entities/game_state.dart';
import 'package:tic_tac_toe/domain/repositories/game_repository.dart';

class MakeMove implements UseCase<GameState, MakeMoveParams> {
  final GameRepository repository;

  MakeMove(this.repository);

  @override
  GameState call(MakeMoveParams params) {
    return repository.makeMove(params.currentState, params.cellIndex);
  }
}

class MakeMoveParams {
  final GameState currentState;
  final int cellIndex;

  const MakeMoveParams({
    required this.currentState,
    required this.cellIndex,
  });
}
