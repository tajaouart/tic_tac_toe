import 'package:tic_tac_toe/core/usecases/usecase.dart';
import 'package:tic_tac_toe/domain/entities/board.dart';
import 'package:tic_tac_toe/domain/entities/player.dart';
import 'package:tic_tac_toe/domain/repositories/game_repository.dart';

class GetAiMove implements UseCase<int, GetAiMoveParams> {
  final GameRepository repository;

  GetAiMove(this.repository);

  @override
  int call(GetAiMoveParams params) {
    return repository.getAiMove(params.board, params.aiPlayer);
  }
}

class GetAiMoveParams {
  final Board board;
  final Player aiPlayer;

  const GetAiMoveParams({
    required this.board,
    required this.aiPlayer,
  });
}
