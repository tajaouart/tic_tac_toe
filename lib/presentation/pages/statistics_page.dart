import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tic_tac_toe/presentation/bloc/settings_cubit.dart';

class StatisticsPage extends StatelessWidget {
  const StatisticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Statistics'),
        centerTitle: true,
      ),
      body: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          final stats = state.statistics;
          final settings = state.settings;

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _buildPlayerCard(context, settings.playerName),
              const SizedBox(height: 24),
              _buildStatsGrid(context, stats),
              const SizedBox(height: 24),
              _buildStreakCard(context, stats),
              const SizedBox(height: 24),
              _buildWinRateCard(context, stats),
            ],
          );
        },
      ),
    );
  }

  Widget _buildPlayerCard(BuildContext context, String playerName) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            CircleAvatar(
              radius: 32,
              backgroundColor: Theme.of(context).colorScheme.primaryContainer,
              child: Text(
                playerName.isNotEmpty ? playerName[0].toUpperCase() : 'P',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    playerName,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  Text(
                    'Tic Tac Toe Champion',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Theme.of(context).colorScheme.outline,
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatsGrid(BuildContext context, stats) {
    return Row(
      children: [
        Expanded(
          child: _StatCard(
            title: 'Wins',
            value: stats.wins.toString(),
            icon: Icons.emoji_events,
            color: Colors.green,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _StatCard(
            title: 'Losses',
            value: stats.losses.toString(),
            icon: Icons.close,
            color: Colors.red,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _StatCard(
            title: 'Draws',
            value: stats.draws.toString(),
            icon: Icons.handshake,
            color: Colors.orange,
          ),
        ),
      ],
    );
  }

  Widget _buildStreakCard(BuildContext context, stats) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Expanded(
              child: _StreakItem(
                title: 'Current Streak',
                value: stats.currentStreak,
                icon: Icons.local_fire_department,
              ),
            ),
            Container(
              width: 1,
              height: 50,
              color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.3),
            ),
            Expanded(
              child: _StreakItem(
                title: 'Best Streak',
                value: stats.bestStreak,
                icon: Icons.star,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWinRateCard(BuildContext context, stats) {
    final winRate = stats.winRate;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Win Rate',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                Text(
                  '${winRate.toStringAsFixed(1)}%',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: winRate / 100,
                minHeight: 12,
                backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Total games: ${stats.totalGames}',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.outline,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const _StatCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(icon, color: color, size: 28),
            const SizedBox(height: 8),
            Text(
              value,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            Text(
              title,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.outline,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StreakItem extends StatelessWidget {
  final String title;
  final int value;
  final IconData icon;

  const _StreakItem({
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          color: value > 0 ? Colors.orange : Theme.of(context).colorScheme.outline,
          size: 28,
        ),
        const SizedBox(height: 4),
        Text(
          value.toString(),
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        Text(
          title,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Theme.of(context).colorScheme.outline,
              ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
