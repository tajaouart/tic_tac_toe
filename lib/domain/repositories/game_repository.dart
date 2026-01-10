import 'package:tic_tac_toe/domain/entities/board.dart';
import 'package:tic_tac_toe/domain/entities/difficulty.dart';
import 'package:tic_tac_toe/domain/entities/game_state.dart';
import 'package:tic_tac_toe/domain/entities/player.dart';

abstract class GameRepository {
  Game makeMove(Game currentState, int cellIndex);
  Game resetGame();
  int getAiMove(Board board, Player aiPlayer, Difficulty difficulty);
  GameStatus checkGameStatus(Board board);
  List<int>? getWinningLine(Board board);
}
