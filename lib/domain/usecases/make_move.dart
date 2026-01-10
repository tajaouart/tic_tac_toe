import 'package:injectable/injectable.dart';
import 'package:tic_tac_toe/core/usecases/usecase.dart';
import 'package:tic_tac_toe/domain/entities/game_state.dart';
import 'package:tic_tac_toe/domain/repositories/game_repository.dart';

@lazySingleton
class MakeMove implements UseCase<Game, MakeMoveParams> {
  final GameRepository repository;

  MakeMove(this.repository);

  @override
  Game call(MakeMoveParams params) {
    return repository.makeMove(params.currentState, params.cellIndex);
  }
}

class MakeMoveParams {
  final Game currentState;
  final int cellIndex;

  const MakeMoveParams({
    required this.currentState,
    required this.cellIndex,
  });
}
