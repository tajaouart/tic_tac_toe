import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tic_tac_toe/core/router/app_router.dart';
import 'package:tic_tac_toe/injection/injection.dart';
import 'package:tic_tac_toe/presentation/bloc/settings_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(const TicTacToeApp());
}

class TicTacToeApp extends StatelessWidget {
  const TicTacToeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<SettingsCubit>(),
      child: BlocBuilder<SettingsCubit, SettingsState>(
        buildWhen: (previous, current) =>
            previous.settings.themeMode != current.settings.themeMode,
        builder: (context, state) {
          return MaterialApp.router(
            title: 'Tic Tac Toe',
            debugShowCheckedModeBanner: false,
            routerConfig: appRouter,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.indigo,
                brightness: Brightness.light,
              ),
              useMaterial3: true,
            ),
            darkTheme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.indigo,
                brightness: Brightness.dark,
              ),
              useMaterial3: true,
            ),
            themeMode: state.settings.themeMode,
          );
        },
      ),
    );
  }
}
