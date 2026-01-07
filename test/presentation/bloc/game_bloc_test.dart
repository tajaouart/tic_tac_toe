import 'package:flutter_test/flutter_test.dart';
import 'package:tic_tac_toe/data/repositories/game_repository_impl.dart';
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

      bloc.add(const CellTapped(4));
      await Future.delayed(const Duration(milliseconds: 100));

      expect(bloc.state, isA<GameInProgress>());
      final state = bloc.state as GameInProgress;
      expect(state.gameState.board.emptyCells.length, lessThan(9));
    });
  });
}
