import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tic_tac_toe/l10n/generated/app_localizations.dart';
import 'package:tic_tac_toe/presentation/bloc/settings_cubit.dart';
import 'package:tic_tac_toe/presentation/widgets/statistics/player_card.dart';
import 'package:tic_tac_toe/presentation/widgets/statistics/stats_grid.dart';
import 'package:tic_tac_toe/presentation/widgets/statistics/streak_card.dart';
import 'package:tic_tac_toe/presentation/widgets/statistics/win_rate_card.dart';

/// Statistics page displaying player game history and performance.
class StatisticsPage extends StatelessWidget {
  const StatisticsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.statistics),
        centerTitle: true,
      ),
      body: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          final stats = state.statistics;
          final settings = state.settings;

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              PlayerCard(playerName: settings.playerName),
              const SizedBox(height: 24),
              StatsGrid(statistics: stats),
              const SizedBox(height: 24),
              StreakCard(statistics: stats),
              const SizedBox(height: 24),
              WinRateCard(statistics: stats),
            ],
          );
        },
      ),
    );
  }
}
