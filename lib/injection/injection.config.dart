// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

import '../data/repositories/game_repository_impl.dart' as _i471;
import '../data/services/storage_service.dart' as _i1045;
import '../domain/repositories/game_repository.dart' as _i807;
import '../domain/usecases/get_ai_move.dart' as _i294;
import '../domain/usecases/make_move.dart' as _i107;
import '../domain/usecases/reset_game.dart' as _i1021;
import '../presentation/bloc/game_bloc.dart' as _i713;
import '../presentation/bloc/settings_cubit.dart' as _i668;
import 'register_module.dart' as _i291;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => registerModule.prefs,
      preResolve: true,
    );
    gh.lazySingleton<_i1045.StorageService>(
      () => _i1045.StorageService(gh<_i460.SharedPreferences>()),
    );
    gh.lazySingleton<_i807.GameRepository>(() => _i471.GameRepositoryImpl());
    gh.lazySingleton<_i294.GetAiMove>(
      () => _i294.GetAiMove(gh<_i807.GameRepository>()),
    );
    gh.lazySingleton<_i107.MakeMove>(
      () => _i107.MakeMove(gh<_i807.GameRepository>()),
    );
    gh.lazySingleton<_i1021.ResetGame>(
      () => _i1021.ResetGame(gh<_i807.GameRepository>()),
    );
    gh.factory<_i713.GameBloc>(
      () => _i713.GameBloc(
        makeMove: gh<_i107.MakeMove>(),
        resetGame: gh<_i1021.ResetGame>(),
        getAiMove: gh<_i294.GetAiMove>(),
      ),
    );
    gh.lazySingleton<_i668.SettingsCubit>(
      () => _i668.SettingsCubit(gh<_i1045.StorageService>()),
    );
    return this;
  }
}

class _$RegisterModule extends _i291.RegisterModule {}
