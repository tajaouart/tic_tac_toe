import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tic_tac_toe/domain/entities/difficulty.dart';
import 'package:tic_tac_toe/presentation/bloc/settings_cubit.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
      ),
      body: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _buildSection(
                context,
                title: 'Profile',
                children: [
                  _PlayerNameTile(
                    currentName: state.settings.playerName,
                    onChanged: (name) {
                      context.read<SettingsCubit>().updatePlayerName(name);
                    },
                  ),
                ],
              ),
              const SizedBox(height: 24),
              _buildSection(
                context,
                title: 'Game',
                children: [
                  _DifficultyTile(
                    currentDifficulty: state.settings.difficulty,
                    onChanged: (difficulty) {
                      context.read<SettingsCubit>().updateDifficulty(difficulty);
                    },
                  ),
                ],
              ),
              const SizedBox(height: 24),
              _buildSection(
                context,
                title: 'Appearance',
                children: [
                  _ThemeModeTile(
                    currentMode: state.settings.themeMode,
                    onChanged: (mode) {
                      context.read<SettingsCubit>().updateThemeMode(mode);
                    },
                  ),
                ],
              ),
              const SizedBox(height: 24),
              _buildSection(
                context,
                title: 'Data',
                children: [
                  ListTile(
                    leading: const Icon(Icons.delete_outline),
                    title: const Text('Reset Statistics'),
                    subtitle: const Text('Clear all game history'),
                    onTap: () => _showResetConfirmation(context),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSection(
    BuildContext context, {
    required String title,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16, bottom: 8),
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  color: Theme.of(context).colorScheme.primary,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        Card(
          child: Column(children: children),
        ),
      ],
    );
  }

  void _showResetConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Reset Statistics'),
        content: const Text(
          'This will permanently delete all your game history. This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              context.read<SettingsCubit>().resetStatistics();
              Navigator.pop(dialogContext);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Statistics reset')),
              );
            },
            child: const Text('Reset'),
          ),
        ],
      ),
    );
  }
}

class _PlayerNameTile extends StatelessWidget {
  final String currentName;
  final ValueChanged<String> onChanged;

  const _PlayerNameTile({
    required this.currentName,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.person_outline),
      title: const Text('Player Name'),
      subtitle: Text(currentName),
      onTap: () => _showNameDialog(context),
    );
  }

  void _showNameDialog(BuildContext context) {
    final controller = TextEditingController(text: currentName);

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Change Name'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(
            labelText: 'Name',
            border: OutlineInputBorder(),
          ),
          autofocus: true,
          textCapitalization: TextCapitalization.words,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              final name = controller.text.trim();
              if (name.isNotEmpty) {
                onChanged(name);
              }
              Navigator.pop(dialogContext);
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }
}

class _DifficultyTile extends StatelessWidget {
  final Difficulty currentDifficulty;
  final ValueChanged<Difficulty> onChanged;

  const _DifficultyTile({
    required this.currentDifficulty,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.psychology_outlined),
      title: const Text('Difficulty'),
      subtitle: Text(currentDifficulty.displayName),
      onTap: () => _showDifficultyDialog(context),
    );
  }

  void _showDifficultyDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Select Difficulty'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: Difficulty.values.map((difficulty) {
            return RadioListTile<Difficulty>(
              title: Text(difficulty.displayName),
              subtitle: Text(difficulty.description),
              value: difficulty,
              groupValue: currentDifficulty,
              onChanged: (value) {
                if (value != null) {
                  onChanged(value);
                  Navigator.pop(dialogContext);
                }
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}

class _ThemeModeTile extends StatelessWidget {
  final ThemeMode currentMode;
  final ValueChanged<ThemeMode> onChanged;

  const _ThemeModeTile({
    required this.currentMode,
    required this.onChanged,
  });

  String _getModeName(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.system:
        return 'System';
      case ThemeMode.light:
        return 'Light';
      case ThemeMode.dark:
        return 'Dark';
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.palette_outlined),
      title: const Text('Theme'),
      subtitle: Text(_getModeName(currentMode)),
      onTap: () => _showThemeDialog(context),
    );
  }

  void _showThemeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Select Theme'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: ThemeMode.values.map((mode) {
            return RadioListTile<ThemeMode>(
              title: Text(_getModeName(mode)),
              value: mode,
              groupValue: currentMode,
              onChanged: (value) {
                if (value != null) {
                  onChanged(value);
                  Navigator.pop(dialogContext);
                }
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}
