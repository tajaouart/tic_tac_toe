import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tic_tac_toe/core/usecases/usecase.dart';
import 'package:tic_tac_toe/domain/entities/player.dart';
import 'package:tic_tac_toe/domain/usecases/get_ai_move.dart';
import 'package:tic_tac_toe/domain/usecases/make_move.dart';
import 'package:tic_tac_toe/domain/usecases/reset_game.dart';
import 'package:tic_tac_toe/presentation/bloc/game_event.dart';
import 'package:tic_tac_toe/presentation/bloc/game_state_bloc.dart';

class GameBloc extends Bloc<GameEvent, GameBlocState> {
  final MakeMove makeMove;
  final ResetGame resetGame;
  final GetAiMove getAiMove;

  static const Player humanPlayer = Player.x;
  static const Player aiPlayer = Player.o;

  GameBloc({
    required this.makeMove,
    required this.resetGame,
    required this.getAiMove,
  }) : super(const GameInitial()) {
    on<CellTapped>(_onCellTapped);
    on<GameReset>(_onGameReset);
    on<AiMoveRequested>(_onAiMoveRequested);

    add(const GameReset());
  }

  Future<void> _onCellTapped(
    CellTapped event,
    Emitter<GameBlocState> emit,
  ) async {
    final currentState = state;
    if (currentState is! GameInProgress) return;
    if (currentState.isAiThinking) return;
    if (currentState.gameState.isGameOver) return;
    if (!currentState.gameState.isHumanTurn) return;

    final newGameState = makeMove(MakeMoveParams(
      currentState: currentState.gameState,
      cellIndex: event.index,
    ));

    if (newGameState == currentState.gameState) return;

    emit(GameInProgress(gameState: newGameState));

    if (!newGameState.isGameOver && !newGameState.isHumanTurn) {
      add(const AiMoveRequested());
    }
  }

  Future<void> _onAiMoveRequested(
    AiMoveRequested event,
    Emitter<GameBlocState> emit,
  ) async {
    final currentState = state;
    if (currentState is! GameInProgress) return;
    if (currentState.gameState.isGameOver) return;
    if (currentState.gameState.isHumanTurn) return;

    emit(currentState.copyWith(isAiThinking: true));

    await Future.delayed(const Duration(milliseconds: 500));

    final aiMoveIndex = getAiMove(GetAiMoveParams(
      board: currentState.gameState.board,
      aiPlayer: aiPlayer,
    ));

    if (aiMoveIndex == -1) return;

    final newGameState = makeMove(MakeMoveParams(
      currentState: currentState.gameState,
      cellIndex: aiMoveIndex,
    ));

    emit(GameInProgress(gameState: newGameState, isAiThinking: false));
  }

  void _onGameReset(
    GameReset event,
    Emitter<GameBlocState> emit,
  ) {
    final initialState = resetGame(const NoParams());
    emit(GameInProgress(gameState: initialState));
  }
}
