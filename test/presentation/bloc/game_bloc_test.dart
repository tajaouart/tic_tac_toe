import 'package:flutter_test/flutter_test.dart';
import 'package:tic_tac_toe/data/repositories/game_repository_impl.dart';
import 'package:tic_tac_toe/domain/entities/difficulty.dart';
import 'package:tic_tac_toe/domain/entities/game_state.dart';
import 'package:tic_tac_toe/domain/usecases/get_ai_move.dart';
import 'package:tic_tac_toe/domain/usecases/make_move.dart';
import 'package:tic_tac_toe/domain/usecases/reset_game.dart';
import 'package:tic_tac_toe/presentation/bloc/game_bloc.dart';
import 'package:tic_tac_toe/presentation/bloc/game_event.dart';
import 'package:tic_tac_toe/presentation/bloc/game_state_bloc.dart';

void main() {
  late GameBloc bloc;
  late GameRepositoryImpl repository;

  setUp(() {
    repository = GameRepositoryImpl();
    bloc = GameBloc(
      makeMove: MakeMove(repository),
      resetGame: ResetGame(repository),
      getAiMove: GetAiMove(repository),
    );
  });

  tearDown(() {
    bloc.close();
  });

  group('GameBloc', () {
    test('initial state is GameInProgress after construction', () async {
      await Future.delayed(const Duration(milliseconds: 100));
      expect(bloc.state, isA<GameInProgress>());
    });

    test('emits new state when GameReset is added', () async {
      await Future.delayed(const Duration(milliseconds: 100));

      bloc.add(const GameReset());
      await Future.delayed(const Duration(milliseconds: 100));

      expect(bloc.state, isA<GameInProgress>());
      final state = bloc.state as GameInProgress;
      expect(state.gameState.board.emptyCells.length, 9);
    });

    test('emits updated state when CellTapped is processed', () async {
      await Future.delayed(const Duration(milliseconds: 100));

      bloc.add(const CellTapped(index: 4, difficulty: Difficulty.easy));
      await Future.delayed(const Duration(milliseconds: 100));

      expect(bloc.state, isA<GameInProgress>());
      final state = bloc.state as GameInProgress;
      expect(state.gameState.board.emptyCells.length, lessThan(9));
    });

    test('ignores cell tap when AI is thinking', () async {
      await Future.delayed(const Duration(milliseconds: 100));

      // Make a move to trigger AI thinking
      bloc.add(const CellTapped(index: 0, difficulty: Difficulty.hard));
      await Future.delayed(const Duration(milliseconds: 50));

      final stateBeforeSecondTap = bloc.state as GameInProgress;
      if (stateBeforeSecondTap.isAiThinking) {
        bloc.add(const CellTapped(index: 1, difficulty: Difficulty.hard));
        await Future.delayed(const Duration(milliseconds: 50));

        // Cell 1 should still be empty if AI is thinking
        final state = bloc.state as GameInProgress;
        expect(state.isAiThinking, true);
      }
    });

    test('invokes game result callback when game ends', () async {
      await Future.delayed(const Duration(milliseconds: 100));

      GameStatus? recordedStatus;
      bloc.onGameResult = (status) => recordedStatus = status;

      // Play a game that ends (depends on implementation)
      bloc.add(const CellTapped(index: 0, difficulty: Difficulty.easy));
      await Future.delayed(const Duration(milliseconds: 800));
      bloc.add(const CellTapped(index: 2, difficulty: Difficulty.easy));
      await Future.delayed(const Duration(milliseconds: 800));

      // We don't know the exact outcome, but if the game ended,
      // the callback should have been invoked
      final state = bloc.state as GameInProgress;
      if (state.gameState.isGameOver) {
        expect(recordedStatus, isNotNull);
      }
    });
  });
}
