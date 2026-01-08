import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tic_tac_toe/core/usecases/usecase.dart';
import 'package:tic_tac_toe/domain/entities/game_state.dart';
import 'package:tic_tac_toe/domain/entities/player.dart';
import 'package:tic_tac_toe/domain/usecases/get_ai_move.dart';
import 'package:tic_tac_toe/domain/usecases/make_move.dart';
import 'package:tic_tac_toe/domain/usecases/reset_game.dart';
import 'package:tic_tac_toe/presentation/bloc/game_event.dart';
import 'package:tic_tac_toe/presentation/bloc/game_state_bloc.dart';
import 'package:tic_tac_toe/presentation/bloc/settings_cubit.dart';

class GameBloc extends Bloc<GameEvent, GameBlocState> {
  final MakeMove makeMove;
  final ResetGame resetGame;
  final GetAiMove getAiMove;
  final SettingsCubit settingsCubit;

  static const Player humanPlayer = Player.x;
  static const Player aiPlayer = Player.o;

  GameBloc({
    required this.makeMove,
    required this.resetGame,
    required this.getAiMove,
    required this.settingsCubit,
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

    if (newGameState.isGameOver) {
      _recordGameResult(newGameState.status);
    } else if (!newGameState.isHumanTurn) {
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

    final difficulty = settingsCubit.state.settings.difficulty;
    final aiMoveIndex = getAiMove(GetAiMoveParams(
      board: currentState.gameState.board,
      aiPlayer: aiPlayer,
      difficulty: difficulty,
    ));

    if (aiMoveIndex == -1) return;

    final newGameState = makeMove(MakeMoveParams(
      currentState: currentState.gameState,
      cellIndex: aiMoveIndex,
    ));

    emit(GameInProgress(gameState: newGameState, isAiThinking: false));

    if (newGameState.isGameOver) {
      _recordGameResult(newGameState.status);
    }
  }

  void _recordGameResult(GameStatus status) {
    switch (status) {
      case GameStatus.xWins:
        settingsCubit.recordWin();
        break;
      case GameStatus.oWins:
        settingsCubit.recordLoss();
        break;
      case GameStatus.draw:
        settingsCubit.recordDraw();
        break;
      case GameStatus.playing:
        break;
    }
  }

  void _onGameReset(
    GameReset event,
    Emitter<GameBlocState> emit,
  ) {
    final initialState = resetGame(const NoParams());
    emit(GameInProgress(gameState: initialState));
  }
}
