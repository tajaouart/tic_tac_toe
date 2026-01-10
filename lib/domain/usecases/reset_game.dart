import 'package:injectable/injectable.dart';
import 'package:tic_tac_toe/core/usecases/usecase.dart';
import 'package:tic_tac_toe/domain/entities/game_state.dart';
import 'package:tic_tac_toe/domain/repositories/game_repository.dart';

@lazySingleton
class ResetGame implements UseCase<Game, NoParams> {
  final GameRepository repository;

  ResetGame(this.repository);

  @override
  Game call(NoParams params) {
    return repository.resetGame();
  }
}
