import 'package:flutter/material.dart';
import 'package:tic_tac_toe/domain/entities/game_statistics.dart';
import 'package:tic_tac_toe/presentation/widgets/statistics/stat_card.dart';

/// Grid widget displaying wins, losses, and draws statistics.
class StatsGrid extends StatelessWidget {
  final GameStatistics statistics;

  const StatsGrid({
    super.key,
    required this.statistics,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: StatCard(
            title: 'Wins',
            value: statistics.wins.toString(),
            icon: Icons.emoji_events,
            color: Colors.green,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: StatCard(
            title: 'Losses',
            value: statistics.losses.toString(),
            icon: Icons.close,
            color: Colors.red,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: StatCard(
            title: 'Draws',
            value: statistics.draws.toString(),
            icon: Icons.handshake,
            color: Colors.orange,
          ),
        ),
      ],
    );
  }
}
