import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tic_tac_toe/core/constants/app_constants.dart';
import 'package:tic_tac_toe/domain/entities/game_state.dart';
import 'package:tic_tac_toe/injection/injection.dart';
import 'package:tic_tac_toe/presentation/bloc/game_bloc.dart';
import 'package:tic_tac_toe/presentation/bloc/game_event.dart';
import 'package:tic_tac_toe/presentation/bloc/game_state_bloc.dart';
import 'package:tic_tac_toe/presentation/bloc/settings_cubit.dart';
import 'package:tic_tac_toe/presentation/widgets/game/difficulty_indicator.dart';
import 'package:tic_tac_toe/presentation/widgets/game/game_board.dart';
import 'package:tic_tac_toe/presentation/widgets/game/game_status_bar.dart';
import 'package:tic_tac_toe/presentation/widgets/common/app_icon_button.dart';

/// Main game page displaying the Tic-Tac-Toe board.
class GamePage extends StatelessWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final bloc = getIt<GameBloc>();
        // Connect game results to settings cubit for statistics tracking
        bloc.onGameResult = (status) => _recordGameResult(context, status);
        return bloc;
      },
      child: const _GamePageContent(),
    );
  }

  void _recordGameResult(BuildContext context, GameStatus status) {
    final settingsCubit = context.read<SettingsCubit>();
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
}

class _GamePageContent extends StatelessWidget {
  const _GamePageContent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: SafeArea(
        child: BlocBuilder<GameBloc, GameBlocState>(
          builder: (context, state) {
            if (state is! GameInProgress) {
              return const Center(child: CircularProgressIndicator());
            }

            return _GameBody(
              gameState: state.gameState,
              isAiThinking: state.isAiThinking,
            );
          },
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      title: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          return Text('${state.settings.playerName}\'s Game');
        },
      ),
      centerTitle: true,
      actions: [
        AppIconButton(
          icon: Icons.refresh,
          tooltip: 'New Game',
          onPressed: () => context.read<GameBloc>().add(const GameReset()),
        ),
        AppIconButton(
          icon: Icons.bar_chart,
          tooltip: 'Statistics',
          onPressed: () => context.push('/statistics'),
        ),
        AppIconButton(
          icon: Icons.settings,
          tooltip: 'Settings',
          onPressed: () => context.push('/settings'),
        ),
      ],
    );
  }
}

class _GameBody extends StatelessWidget {
  final GameState gameState;
  final bool isAiThinking;

  const _GameBody({
    required this.gameState,
    required this.isAiThinking,
  });

  @override
  Widget build(BuildContext context) {
    final isGameOver = gameState.isGameOver;

    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: AppConstants.maxBoardWidth),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final maxBoardSize = constraints.maxHeight * AppConstants.boardHeightFactor;
            final boardSize = maxBoardSize.clamp(
              AppConstants.minBoardSize,
              AppConstants.maxBoardSize,
            );

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(),
                const DifficultyIndicator(),
                GameStatusBar(
                  status: gameState.status,
                  isAiThinking: isAiThinking,
                ),
                const SizedBox(height: 24),
                _buildGameBoard(context, boardSize, isGameOver),
                const Spacer(),
                if (isGameOver) _buildPlayAgainButton(context),
                const SizedBox(height: 16),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildGameBoard(BuildContext context, double boardSize, bool isGameOver) {
    return SizedBox(
      width: boardSize,
      height: boardSize,
      child: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, settingsState) {
          return GameBoard(
            board: gameState.board,
            winningLine: gameState.winningLine,
            isEnabled: !isGameOver && !isAiThinking,
            onCellTap: (index) {
              context.read<GameBloc>().add(CellTapped(
                index: index,
                difficulty: settingsState.settings.difficulty,
              ));
            },
          );
        },
      ),
    );
  }

  Widget _buildPlayAgainButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: FilledButton.icon(
        onPressed: () => context.read<GameBloc>().add(const GameReset()),
        icon: const Icon(Icons.refresh),
        label: const Text('Play Again'),
      ),
    );
  }
}
