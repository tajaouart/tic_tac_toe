import 'package:injectable/injectable.dart';
import 'package:tic_tac_toe/core/usecases/usecase.dart';
import 'package:tic_tac_toe/domain/entities/board.dart';
import 'package:tic_tac_toe/domain/entities/difficulty.dart';
import 'package:tic_tac_toe/domain/entities/player.dart';
import 'package:tic_tac_toe/domain/repositories/game_repository.dart';

@lazySingleton
class GetAiMove implements UseCase<int, GetAiMoveParams> {
  final GameRepository repository;

  GetAiMove(this.repository);

  @override
  int call(GetAiMoveParams params) {
    return repository.getAiMove(params.board, params.aiPlayer, params.difficulty);
  }
}

class GetAiMoveParams {
  final Board board;
  final Player aiPlayer;
  final Difficulty difficulty;

  const GetAiMoveParams({
    required this.board,
    required this.aiPlayer,
    required this.difficulty,
  });
}
