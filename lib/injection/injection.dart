import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tic_tac_toe/data/repositories/game_repository_impl.dart';
import 'package:tic_tac_toe/data/services/storage_service.dart';
import 'package:tic_tac_toe/domain/repositories/game_repository.dart';
import 'package:tic_tac_toe/domain/usecases/get_ai_move.dart';
import 'package:tic_tac_toe/domain/usecases/make_move.dart';
import 'package:tic_tac_toe/domain/usecases/reset_game.dart';
import 'package:tic_tac_toe/presentation/bloc/settings_cubit.dart';

final getIt = GetIt.instance;

Future<void> configureDependencies() async {
  // External
  final prefs = await SharedPreferences.getInstance();
  getIt.registerSingleton<SharedPreferences>(prefs);

  // Services
  getIt.registerLazySingleton<StorageService>(
    () => StorageService(getIt()),
  );

  // Repository
  getIt.registerLazySingleton<GameRepository>(
    () => GameRepositoryImpl(),
  );

  // Use Cases
  getIt.registerLazySingleton(() => MakeMove(getIt()));
  getIt.registerLazySingleton(() => ResetGame(getIt()));
  getIt.registerLazySingleton(() => GetAiMove(getIt()));

  // Cubits
  getIt.registerLazySingleton(() => SettingsCubit(getIt()));
}
