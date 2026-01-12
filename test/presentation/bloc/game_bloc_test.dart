import 'package:bloc_test/bloc_test.dart';
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
  late GameRepositoryImpl repository;
  late MakeMove makeMove;
  late ResetGame resetGame;
  late GetAiMove getAiMove;

  setUp(() {
    repository = GameRepositoryImpl();
    makeMove = MakeMove(repository);
    resetGame = ResetGame(repository);
    getAiMove = GetAiMove(repository);
  });

  group('GameBloc', () {
    blocTest<GameBloc, GameBlocState>(
      'emits GameInProgress on construction',
      build: () => GameBloc(
        makeMove: makeMove,
        resetGame: resetGame,
        getAiMove: getAiMove,
      ),
      expect: () => [isA<GameInProgress>()],
    );

    test('resets to fresh state when GameReset is added', () async {
      final bloc = GameBloc(
        makeMove: makeMove,
        resetGame: resetGame,
        getAiMove: getAiMove,
      );

      await Future.delayed(const Duration(milliseconds: 100));
      bloc.add(const GameReset());
      await Future.delayed(const Duration(milliseconds: 100));

      expect(bloc.state, isA<GameInProgress>());
      final state = bloc.state as GameInProgress;
      expect(state.game.board.emptyCells.length, 9);
      expect(state.game.status, GameStatus.playing);

      await bloc.close();
    });

    blocTest<GameBloc, GameBlocState>(
      'updates board when CellTapped is processed',
      build: () => GameBloc(
        makeMove: makeMove,
        resetGame: resetGame,
        getAiMove: getAiMove,
      ),
      act: (bloc) async {
        await Future.delayed(const Duration(milliseconds: 50));
        bloc.add(const CellTapped(index: 4, difficulty: Difficulty.easy));
      },
      wait: const Duration(milliseconds: 600),
      verify: (bloc) {
        final state = bloc.state as GameInProgress;
        expect(state.game.board.emptyCells.length, lessThan(9));
      },
    );

    test('marks result as recorded when GameResultRecorded is added', () async {
      final bloc = GameBloc(
        makeMove: makeMove,
        resetGame: resetGame,
        getAiMove: getAiMove,
      );

      await Future.delayed(const Duration(milliseconds: 100));

      // Simulate a game ending and result being recorded
      bloc.add(const CellTapped(index: 0, difficulty: Difficulty.easy));
      await Future.delayed(const Duration(milliseconds: 700));

      final stateBefore = bloc.state as GameInProgress;
      expect(stateBefore.resultRecorded, false);

      // Mark result as recorded
      bloc.add(const GameResultRecorded());
      await Future.delayed(const Duration(milliseconds: 100));

      final stateAfter = bloc.state as GameInProgress;
      expect(stateAfter.resultRecorded, true);

      await bloc.close();
    });
  });
}
