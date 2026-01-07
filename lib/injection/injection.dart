import 'package:get_it/get_it.dart';
import 'package:tic_tac_toe/data/repositories/game_repository_impl.dart';
import 'package:tic_tac_toe/domain/repositories/game_repository.dart';
import 'package:tic_tac_toe/domain/usecases/get_ai_move.dart';
import 'package:tic_tac_toe/domain/usecases/make_move.dart';
import 'package:tic_tac_toe/domain/usecases/reset_game.dart';
import 'package:tic_tac_toe/presentation/bloc/game_bloc.dart';

final getIt = GetIt.instance;

void configureDependencies() {
  // Repository
  getIt.registerLazySingleton<GameRepository>(
    () => GameRepositoryImpl(),
  );

  // Use Cases
  getIt.registerLazySingleton(() => MakeMove(getIt()));
  getIt.registerLazySingleton(() => ResetGame(getIt()));
  getIt.registerLazySingleton(() => GetAiMove(getIt()));

  // BLoC
  getIt.registerFactory(
    () => GameBloc(
      makeMove: getIt(),
      resetGame: getIt(),
      getAiMove: getIt(),
    ),
  );
}
