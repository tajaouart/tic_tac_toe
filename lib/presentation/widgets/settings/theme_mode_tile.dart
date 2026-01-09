import 'package:flutter/material.dart';

/// Tile widget for selecting the app theme mode.
class ThemeModeTile extends StatelessWidget {
  final ThemeMode currentMode;
  final ValueChanged<ThemeMode> onChanged;

  const ThemeModeTile({
    super.key,
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
      builder: (dialogContext) => _ThemeModeDialog(
        currentMode: currentMode,
        onSelected: (mode) {
          onChanged(mode);
          Navigator.pop(dialogContext);
        },
        getModeName: _getModeName,
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
    return AlertDialog(
      title: const Text('Select Theme'),
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
