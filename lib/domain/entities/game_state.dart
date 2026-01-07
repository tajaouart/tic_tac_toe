import 'package:equatable/equatable.dart';
import 'package:tic_tac_toe/domain/entities/board.dart';
import 'package:tic_tac_toe/domain/entities/player.dart';

enum GameStatus {
  playing,
  xWins,
  oWins,
  draw,
}

class GameState extends Equatable {
  final Board board;
  final Player currentPlayer;
  final GameStatus status;
  final List<int>? winningLine;

  const GameState({
    required this.board,
    required this.currentPlayer,
    required this.status,
    this.winningLine,
  });

  factory GameState.initial() {
    return GameState(
      board: Board.empty(),
      currentPlayer: Player.x,
      status: GameStatus.playing,
    );
  }

  GameState copyWith({
    Board? board,
    Player? currentPlayer,
    GameStatus? status,
    List<int>? winningLine,
  }) {
    return GameState(
      board: board ?? this.board,
      currentPlayer: currentPlayer ?? this.currentPlayer,
      status: status ?? this.status,
      winningLine: winningLine ?? this.winningLine,
    );
  }

  bool get isGameOver => status != GameStatus.playing;

  bool get isHumanTurn => currentPlayer == Player.x;

  @override
  List<Object?> get props => [board, currentPlayer, status, winningLine];
}
