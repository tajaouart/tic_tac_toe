import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tic_tac_toe/domain/entities/board.dart';
import 'package:tic_tac_toe/domain/entities/player.dart';

part 'game_state.freezed.dart';

enum GameStatus {
  playing,
  xWins,
  oWins,
  draw,
}

@freezed
class Game with _$Game {
  const Game._();

  const factory Game({
    required Board board,
    required Player currentPlayer,
    required GameStatus status,
    List<int>? winningLine,
  }) = _Game;

  factory Game.initial() {
    return Game(
      board: Board.empty(),
      currentPlayer: Player.x,
      status: GameStatus.playing,
    );
  }

  bool get isGameOver => status != GameStatus.playing;

  bool get isHumanTurn => currentPlayer == Player.x;
}
