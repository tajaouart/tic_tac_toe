import 'package:flutter/material.dart';
import 'package:tic_tac_toe/l10n/generated/app_localizations.dart';
import 'package:tic_tac_toe/domain/entities/game_statistics.dart';

/// Card widget displaying win rate with a progress indicator.
class WinRateCard extends StatelessWidget {
  final GameStatistics statistics;

  const WinRateCard({
    super.key,
    required this.statistics,
  });

  @override
  Widget build(BuildContext context) {
    final winRate = statistics.winRate;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _WinRateHeader(winRate: winRate),
            const SizedBox(height: 12),
            _WinRateProgress(winRate: winRate),
            const SizedBox(height: 8),
            _TotalGamesLabel(totalGames: statistics.totalGames),
          ],
        ),
      ),
    );
  }
}

class _WinRateHeader extends StatelessWidget {
  final double winRate;

  const _WinRateHeader({required this.winRate});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          l10n.winRate,
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
    );
  }
}

class _WinRateProgress extends StatelessWidget {
  final double winRate;

  const _WinRateProgress({required this.winRate});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: LinearProgressIndicator(
        value: winRate / 100,
        minHeight: 12,
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest,
      ),
    );
  }
}

class _TotalGamesLabel extends StatelessWidget {
  final int totalGames;

  const _TotalGamesLabel({required this.totalGames});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Text(
      l10n.totalGames(totalGames),
      style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Theme.of(context).colorScheme.outline,
          ),
    );
  }
}
