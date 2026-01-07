import 'package:tic_tac_toe/core/usecases/usecase.dart';
import 'package:tic_tac_toe/domain/entities/game_state.dart';
import 'package:tic_tac_toe/domain/repositories/game_repository.dart';

class ResetGame implements UseCase<GameState, NoParams> {
  final GameRepository repository;

  ResetGame(this.repository);

  @override
  GameState call(NoParams params) {
    return repository.resetGame();
  }
}
