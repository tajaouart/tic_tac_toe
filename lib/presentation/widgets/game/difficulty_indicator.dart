import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tic_tac_toe/presentation/bloc/settings_cubit.dart';

/// Widget displaying the current difficulty level.
class DifficultyIndicator extends StatelessWidget {
  const DifficultyIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
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
    );
  }
}
