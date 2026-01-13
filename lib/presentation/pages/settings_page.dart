import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tic_tac_toe/l10n/generated/app_localizations.dart';
import 'package:tic_tac_toe/presentation/bloc/settings_cubit.dart';
import 'package:tic_tac_toe/presentation/widgets/common/section_card.dart';
import 'package:tic_tac_toe/presentation/widgets/settings/difficulty_tile.dart';
import 'package:tic_tac_toe/presentation/widgets/settings/language_tile.dart';
import 'package:tic_tac_toe/presentation/widgets/settings/player_name_tile.dart';
import 'package:tic_tac_toe/presentation/widgets/settings/reset_statistics_tile.dart';
import 'package:tic_tac_toe/presentation/widgets/settings/theme_mode_tile.dart';

/// Settings page for configuring player preferences.
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.settings),
        centerTitle: true,
      ),
      body: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              SectionCard(
                title: l10n.profile,
                children: [
                  PlayerNameTile(
                    currentName: state.settings.playerName,
                    onChanged: (name) {
                      context.read<SettingsCubit>().updatePlayerName(name);
                    },
                  ),
                ],
              ),
              const SizedBox(height: 24),
              SectionCard(
                title: l10n.gameSettings,
                children: [
                  DifficultyTile(
                    currentDifficulty: state.settings.difficulty,
                    onChanged: (difficulty) {
                      context.read<SettingsCubit>().updateDifficulty(difficulty);
                    },
                  ),
                ],
              ),
              const SizedBox(height: 24),
              SectionCard(
                title: l10n.appearance,
                children: [
                  ThemeModeTile(
                    currentMode: state.settings.themeMode,
                    onChanged: (mode) {
                      context.read<SettingsCubit>().updateThemeMode(mode);
                    },
                  ),
                  const Divider(height: 1),
                  const LanguageTile(),
                ],
              ),
              const SizedBox(height: 24),
              SectionCard(
                title: l10n.dangerZone,
                children: [
                  ResetStatisticsTile(
                    onReset: () {
                      context.read<SettingsCubit>().resetStatistics();
                    },
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
