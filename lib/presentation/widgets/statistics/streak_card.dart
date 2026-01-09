import 'package:flutter/material.dart';
import 'package:tic_tac_toe/domain/entities/game_statistics.dart';

/// Card widget displaying current and best winning streaks.
class StreakCard extends StatelessWidget {
  final GameStatistics statistics;

  const StreakCard({
    super.key,
    required this.statistics,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            Expanded(
              child: _StreakItem(
                title: 'Current Streak',
                value: statistics.currentStreak,
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
                value: statistics.bestStreak,
                icon: Icons.star,
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
