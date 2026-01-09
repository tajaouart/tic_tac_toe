import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:tic_tac_toe/core/constants/app_constants.dart';
import 'package:tic_tac_toe/core/usecases/usecase.dart';
import 'package:tic_tac_toe/domain/entities/game_state.dart';
import 'package:tic_tac_toe/domain/entities/player.dart';
import 'package:tic_tac_toe/domain/usecases/get_ai_move.dart';
import 'package:tic_tac_toe/domain/usecases/make_move.dart';
import 'package:tic_tac_toe/domain/usecases/reset_game.dart';
import 'package:tic_tac_toe/presentation/bloc/game_event.dart';
import 'package:tic_tac_toe/presentation/bloc/game_state_bloc.dart';

/// Callback type for recording game results.
typedef GameResultCallback = void Function(GameStatus status);

/// BLoC responsible for managing game state and logic.
///
/// This BLoC is decoupled from SettingsCubit - difficulty is passed through
/// events and game results are communicated via callbacks.
@injectable
class GameBloc extends Bloc<GameEvent, GameBlocState> {
  final MakeMove makeMove;
  final ResetGame resetGame;
  final GetAiMove getAiMove;

  /// Callback invoked when a game ends with a result.
  GameResultCallback? onGameResult;

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
    on<GameResultRecorded>(_onGameResultRecorded);

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
      _notifyGameResult(newGameState.status);
    } else if (!newGameState.isHumanTurn) {
      add(AiMoveRequested(difficulty: event.difficulty));
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

    await Future.delayed(
      const Duration(milliseconds: AppConstants.aiThinkingDelay),
    );

    final aiMoveIndex = getAiMove(GetAiMoveParams(
      board: currentState.gameState.board,
      aiPlayer: aiPlayer,
      difficulty: event.difficulty,
    ));

    if (aiMoveIndex == -1) return;

    final newGameState = makeMove(MakeMoveParams(
      currentState: currentState.gameState,
      cellIndex: aiMoveIndex,
    ));

    emit(GameInProgress(gameState: newGameState, isAiThinking: false));

    if (newGameState.isGameOver) {
      _notifyGameResult(newGameState.status);
    }
  }

  void _notifyGameResult(GameStatus status) {
    onGameResult?.call(status);
  }

  void _onGameResultRecorded(
    GameResultRecorded event,
    Emitter<GameBlocState> emit,
  ) {
    // This event is for external tracking - no state change needed
  }

  void _onGameReset(
    GameReset event,
    Emitter<GameBlocState> emit,
  ) {
    final initialState = resetGame(const NoParams());
    emit(GameInProgress(gameState: initialState));
  }
}
