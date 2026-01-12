import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tic_tac_toe/data/services/sound_service.dart';
import 'package:tic_tac_toe/domain/entities/difficulty.dart';
import 'package:tic_tac_toe/domain/entities/game_state.dart';
import 'package:tic_tac_toe/injection/injection.dart';
import 'package:tic_tac_toe/presentation/bloc/game_bloc.dart';
import 'package:tic_tac_toe/presentation/bloc/game_event.dart';
import 'package:tic_tac_toe/presentation/bloc/game_state_bloc.dart';
import 'package:tic_tac_toe/presentation/bloc/settings_cubit.dart';
import 'package:tic_tac_toe/presentation/widgets/game/game_board.dart';

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) {
        final bloc = getIt<GameBloc>();
        bloc.onGameResult = (status) => _recordGameResult(context, status);
        return bloc;
      },
      child: const _GamePageContent(),
    );
  }

  void _recordGameResult(BuildContext context, GameStatus status) {
    final settingsCubit = context.read<SettingsCubit>();
    final soundService = getIt<SoundService>();

    switch (status) {
      case GameStatus.xWins:
        settingsCubit.recordWin();
        soundService.playSuccess();
        break;
      case GameStatus.oWins:
        settingsCubit.recordLoss();
        soundService.playLost();
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
      body: SafeArea(
        child: BlocBuilder<GameBloc, GameBlocState>(
          builder: (context, state) {
            return state.when(
              initial: () => const Center(child: CircularProgressIndicator()),
              inProgress: (game, isAiThinking) => _GameBody(
                game: game,
                isAiThinking: isAiThinking,
              ),
            );
          },
        ),
      ),
    );
  }
}

class _GameBody extends StatelessWidget {
  final Game game;
  final bool isAiThinking;

  const _GameBody({
    required this.game,
    required this.isAiThinking,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isGameOver = game.isGameOver;

    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, settingsState) {
        final soundService = getIt<SoundService>();
        soundService.setEnabled(settingsState.settings.soundEnabled);

        return Column(
          children: [
            // Top bar with actions
            _buildTopBar(context),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const SizedBox(height: 16),

                    // Player vs CPU card
                    _buildPlayersCard(context, settingsState),

                    const SizedBox(height: 24),

                    // Status indicator
                    _buildStatusChip(context, colorScheme),

                    const SizedBox(height: 24),

                    // Game board
                    _buildGameBoard(context, settingsState),

                    const SizedBox(height: 32),

                    // Action buttons
                    if (isGameOver) _buildGameOverActions(context),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
      child: Row(
        children: [
          IconButton(
            onPressed: () => context.read<GameBloc>().add(const GameReset()),
            icon: const Icon(Icons.refresh_rounded),
            tooltip: 'New Game',
          ),
          const Spacer(),
          IconButton(
            onPressed: () => context.push('/statistics'),
            icon: const Icon(Icons.emoji_events_outlined),
            tooltip: 'Statistics',
          ),
          IconButton(
            onPressed: () => context.push('/settings'),
            icon: const Icon(Icons.settings_outlined),
            tooltip: 'Settings',
          ),
        ],
      ),
    );
  }

  Widget _buildPlayersCard(BuildContext context, SettingsState settingsState) {
    final colorScheme = Theme.of(context).colorScheme;
    final stats = settingsState.statistics;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            colorScheme.primaryContainer.withValues(alpha: 0.5),
            colorScheme.secondaryContainer.withValues(alpha: 0.5),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: colorScheme.outline.withValues(alpha: 0.1),
        ),
      ),
      child: Column(
        children: [
          // Difficulty badge
          _buildDifficultyBadge(context, settingsState.settings.difficulty),
          const SizedBox(height: 16),

          // Players row
          Row(
            children: [
              // Player
              Expanded(
                child: _buildPlayerInfo(
                  context,
                  name: settingsState.settings.playerName,
                  symbol: 'X',
                  score: stats.wins,
                  color: colorScheme.primary,
                  isActive: !isAiThinking && game.status == GameStatus.playing,
                ),
              ),

              // VS divider
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Text(
                      'VS',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: colorScheme.outline,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: colorScheme.surfaceContainerHighest,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        '${stats.draws}',
                        style: TextStyle(
                          fontSize: 11,
                          color: colorScheme.outline,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // CPU
              Expanded(
                child: _buildPlayerInfo(
                  context,
                  name: 'CPU',
                  symbol: 'O',
                  score: stats.losses,
                  color: colorScheme.secondary,
                  isActive: isAiThinking,
                  isRightAligned: true,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDifficultyBadge(BuildContext context, Difficulty difficulty) {
    final color = switch (difficulty) {
      Difficulty.easy => Colors.green,
      Difficulty.medium => Colors.orange,
      Difficulty.hard => Colors.red,
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            switch (difficulty) {
              Difficulty.easy => Icons.sentiment_satisfied_rounded,
              Difficulty.medium => Icons.psychology_outlined,
              Difficulty.hard => Icons.local_fire_department_rounded,
            },
            size: 16,
            color: color,
          ),
          const SizedBox(width: 6),
          Text(
            difficulty.displayName,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPlayerInfo(
    BuildContext context, {
    required String name,
    required String symbol,
    required int score,
    required Color color,
    required bool isActive,
    bool isRightAligned = false,
  }) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment:
          isRightAligned ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        // Avatar with symbol
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isActive
                ? color.withValues(alpha: 0.2)
                : colorScheme.surfaceContainerHighest,
            shape: BoxShape.circle,
            border: Border.all(
              color: isActive ? color : Colors.transparent,
              width: 2,
            ),
            boxShadow: isActive
                ? [
                    BoxShadow(
                      color: color.withValues(alpha: 0.3),
                      blurRadius: 12,
                      spreadRadius: 2,
                    ),
                  ]
                : null,
          ),
          child: Text(
            symbol,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
        ),
        const SizedBox(height: 8),

        // Name
        Text(
          name,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: colorScheme.onSurface,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),

        // Score
        Text(
          '$score wins',
          style: TextStyle(
            fontSize: 12,
            color: colorScheme.outline,
          ),
        ),
      ],
    );
  }

  Widget _buildStatusChip(BuildContext context, ColorScheme colorScheme) {
    final (text, color, icon) = switch (game.status) {
      GameStatus.playing when isAiThinking => (
          'CPU is thinking...',
          colorScheme.tertiary,
          null,
        ),
      GameStatus.playing => (
          'Your turn',
          colorScheme.primary,
          Icons.touch_app_rounded,
        ),
      GameStatus.xWins => (
          '🎉 You Win!',
          Colors.green,
          Icons.celebration_rounded,
        ),
      GameStatus.oWins => (
          'CPU Wins',
          colorScheme.error,
          Icons.smart_toy_rounded,
        ),
      GameStatus.draw => (
          "It's a Draw",
          colorScheme.outline,
          Icons.handshake_rounded,
        ),
    };

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isAiThinking) ...[
            SizedBox(
              width: 18,
              height: 18,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: color,
              ),
            ),
            const SizedBox(width: 10),
          ] else if (icon != null) ...[
            Icon(icon, size: 20, color: color),
            const SizedBox(width: 8),
          ],
          Text(
            text,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGameBoard(BuildContext context, SettingsState settingsState) {
    final colorScheme = Theme.of(context).colorScheme;
    final isGameOver = game.isGameOver;
    final soundService = getIt<SoundService>();

    return Container(
      constraints: const BoxConstraints(maxWidth: 400),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withValues(alpha: 0.1),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: AspectRatio(
        aspectRatio: 1,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: GameBoard(
            board: game.board,
            winningLine: game.winningLine,
            isEnabled: !isGameOver && !isAiThinking,
            isAiThinking: isAiThinking,
            onCellTap: (index) {
              soundService.playTap();
              context.read<GameBloc>().add(CellTapped(
                    index: index,
                    difficulty: settingsState.settings.difficulty,
                  ));
            },
          ),
        ),
      ),
    );
  }

  Widget _buildGameOverActions(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FilledButton.icon(
          onPressed: () => context.read<GameBloc>().add(const GameReset()),
          icon: const Icon(Icons.replay_rounded),
          label: const Text('Play Again'),
          style: FilledButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
        const SizedBox(width: 12),
        OutlinedButton.icon(
          onPressed: () => context.push('/settings'),
          icon: const Icon(Icons.tune_rounded),
          label: const Text('Settings'),
          style: OutlinedButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            side: BorderSide(color: colorScheme.outline.withValues(alpha: 0.5)),
          ),
        ),
      ],
    );
  }
}
