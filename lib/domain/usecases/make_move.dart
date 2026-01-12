import 'package:injectable/injectable.dart';
import 'package:tic_tac_toe/core/constants/app_constants.dart';
import 'package:tic_tac_toe/core/error/exceptions.dart';
import 'package:tic_tac_toe/core/usecases/usecase.dart';
import 'package:tic_tac_toe/domain/entities/game_state.dart';
import 'package:tic_tac_toe/domain/repositories/game_repository.dart';

/// Use case for making a move in the game.
///
/// Validates the move before delegating to the repository:
/// - Cell index must be within bounds (0-8)
/// - Cell must be empty
/// - Game must not be over
@lazySingleton
class MakeMove implements UseCase<Game, MakeMoveParams> {
  final GameRepository repository;

  MakeMove(this.repository);

  @override
  Game call(MakeMoveParams params) {
    _validate(params);
    return repository.makeMove(params.currentState, params.cellIndex);
  }

  void _validate(MakeMoveParams params) {
    final cellIndex = params.cellIndex;
    final game = params.currentState;

    // Validate cell index bounds
    if (cellIndex < 0 || cellIndex >= AppConstants.totalCells) {
      throw InvalidMoveException(
        cellIndex,
        'Cell index must be between 0 and ${AppConstants.totalCells - 1}',
      );
    }

    // Validate game is not over
    if (game.isGameOver) {
      throw const GameOverException();
    }

    // Validate cell is empty
    if (!game.board.isCellEmpty(cellIndex)) {
      throw InvalidMoveException(cellIndex, 'Cell is already occupied');
    }
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
