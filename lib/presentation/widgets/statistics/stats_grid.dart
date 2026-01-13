import 'package:flutter/material.dart';
import 'package:tic_tac_toe/l10n/generated/app_localizations.dart';
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
    final l10n = AppLocalizations.of(context);

    return Row(
      children: [
        Expanded(
          child: StatCard(
            title: l10n.winsLabel,
            value: statistics.wins.toString(),
            icon: Icons.emoji_events,
            color: Colors.green,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: StatCard(
            title: l10n.lossesLabel,
            value: statistics.losses.toString(),
            icon: Icons.close,
            color: Colors.red,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: StatCard(
            title: l10n.drawsLabel,
            value: statistics.draws.toString(),
            icon: Icons.handshake,
            color: Colors.orange,
          ),
        ),
      ],
    );
  }
}
