import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tic_tac_toe/domain/usecases/get_ai_move.dart';
import 'package:tic_tac_toe/domain/usecases/make_move.dart';
import 'package:tic_tac_toe/domain/usecases/reset_game.dart';
import 'package:tic_tac_toe/injection/injection.dart';
import 'package:tic_tac_toe/presentation/bloc/game_bloc.dart';
import 'package:tic_tac_toe/presentation/bloc/game_event.dart';
import 'package:tic_tac_toe/presentation/bloc/game_state_bloc.dart';
import 'package:tic_tac_toe/presentation/bloc/settings_cubit.dart';
import 'package:tic_tac_toe/presentation/widgets/game_board.dart';
import 'package:tic_tac_toe/presentation/widgets/game_status_bar.dart';

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context) {
    final settingsCubit = context.read<SettingsCubit>();
    return BlocProvider(
      create: (_) => GameBloc(
        makeMove: getIt<MakeMove>(),
        resetGame: getIt<ResetGame>(),
        getAiMove: getIt<GetAiMove>(),
        settingsCubit: settingsCubit,
      ),
      child: const _GamePageContent(),
    );
  }
}

class _GamePageContent extends StatelessWidget {
  const _GamePageContent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<SettingsCubit, SettingsState>(
          builder: (context, state) {
            return Text('${state.settings.playerName}\'s Game');
          },
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              context.read<GameBloc>().add(const GameReset());
            },
            tooltip: 'New Game',
          ),
          IconButton(
            icon: const Icon(Icons.bar_chart),
            onPressed: () => context.push('/statistics'),
            tooltip: 'Statistics',
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => context.push('/settings'),
            tooltip: 'Settings',
          ),
        ],
      ),
      body: SafeArea(
        child: BlocBuilder<GameBloc, GameBlocState>(
          builder: (context, state) {
            if (state is! GameInProgress) {
              return const Center(child: CircularProgressIndicator());
            }

            final gameState = state.gameState;
            final isGameOver = gameState.isGameOver;

            return LayoutBuilder(
              builder: (context, constraints) {
                final maxBoardSize = constraints.maxHeight * 0.55;
                final boardSize = maxBoardSize.clamp(200.0, 400.0);

                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(),
                    BlocBuilder<SettingsCubit, SettingsState>(
                      builder: (context, settingsState) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Text(
                            'Difficulty: ${settingsState.settings.difficulty.displayName}',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: Theme.of(context).colorScheme.outline,
                                ),
                          ),
                        );
                      },
                    ),
                    GameStatusBar(
                      status: gameState.status,
                      isAiThinking: state.isAiThinking,
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      width: boardSize,
                      height: boardSize,
                      child: GameBoard(
                        board: gameState.board,
                        winningLine: gameState.winningLine,
                        isEnabled: !isGameOver && !state.isAiThinking,
                        onCellTap: (index) {
                          context.read<GameBloc>().add(CellTapped(index));
                        },
                      ),
                    ),
                    const Spacer(),
                    if (isGameOver)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: FilledButton.icon(
                          onPressed: () {
                            context.read<GameBloc>().add(const GameReset());
                          },
                          icon: const Icon(Icons.refresh),
                          label: const Text('Play Again'),
                        ),
                      ),
                    const SizedBox(height: 16),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}
