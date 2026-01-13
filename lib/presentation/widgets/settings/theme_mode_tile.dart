import 'package:flutter/material.dart';
import 'package:tic_tac_toe/l10n/generated/app_localizations.dart';

/// Tile widget for selecting the app theme mode.
class ThemeModeTile extends StatelessWidget {
  final ThemeMode currentMode;
  final ValueChanged<ThemeMode> onChanged;

  const ThemeModeTile({
    super.key,
    required this.currentMode,
    required this.onChanged,
  });

  String _getModeName(BuildContext context, ThemeMode mode) {
    final l10n = AppLocalizations.of(context);
    switch (mode) {
      case ThemeMode.system:
        return l10n.system;
      case ThemeMode.light:
        return l10n.light;
      case ThemeMode.dark:
        return l10n.dark;
    }
  }

  IconData _getModeIcon(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.system:
        return Icons.brightness_auto;
      case ThemeMode.light:
        return Icons.light_mode;
      case ThemeMode.dark:
        return Icons.dark_mode;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return ListTile(
      leading: const Icon(Icons.palette_outlined),
      title: Text(l10n.theme),
      subtitle: Text(_getModeName(context, currentMode)),
      onTap: () => _showThemeDialog(context),
    );
  }

  void _showThemeDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => _ThemeModeDialog(
        currentMode: currentMode,
        onSelected: (mode) {
          onChanged(mode);
          Navigator.pop(dialogContext);
        },
        getModeName: (mode) => _getModeName(context, mode),
        getModeIcon: _getModeIcon,
      ),
    );
  }
}

class _ThemeModeDialog extends StatefulWidget {
  final ThemeMode currentMode;
  final ValueChanged<ThemeMode> onSelected;
  final String Function(ThemeMode) getModeName;
  final IconData Function(ThemeMode) getModeIcon;

  const _ThemeModeDialog({
    required this.currentMode,
    required this.onSelected,
    required this.getModeName,
    required this.getModeIcon,
  });

  @override
  State<_ThemeModeDialog> createState() => _ThemeModeDialogState();
}

class _ThemeModeDialogState extends State<_ThemeModeDialog> {
  late ThemeMode _selectedMode;

  @override
  void initState() {
    super.initState();
    _selectedMode = widget.currentMode;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return AlertDialog(
      title: Text(l10n.selectTheme),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: ThemeMode.values.map((mode) {
          return _ThemeModeOption(
            mode: mode,
            isSelected: _selectedMode == mode,
            modeName: widget.getModeName(mode),
            modeIcon: widget.getModeIcon(mode),
            onTap: () {
              setState(() => _selectedMode = mode);
              widget.onSelected(mode);
            },
          );
        }).toList(),
      ),
    );
  }
}

class _ThemeModeOption extends StatelessWidget {
  final ThemeMode mode;
  final bool isSelected;
  final String modeName;
  final IconData modeIcon;
  final VoidCallback onTap;

  const _ThemeModeOption({
    required this.mode,
    required this.isSelected,
    required this.modeName,
    required this.modeIcon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: isSelected ? colorScheme.primaryContainer : null,
        ),
        child: Row(
          children: [
            Icon(
              isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
              color: isSelected ? colorScheme.primary : colorScheme.outline,
            ),
            const SizedBox(width: 16),
            Icon(
              modeIcon,
              color: isSelected ? colorScheme.onPrimaryContainer : colorScheme.outline,
            ),
            const SizedBox(width: 12),
            Text(
              modeName,
              style: TextStyle(
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                color: isSelected ? colorScheme.onPrimaryContainer : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
