import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tic_tac_toe/l10n/generated/app_localizations.dart';
import 'package:tic_tac_toe/presentation/bloc/settings_cubit.dart';

/// Supported language options with their display properties.
enum AppLanguage {
  system(null, 'System'),
  english('en', 'English'),
  french('fr', 'Francais');

  final String? code;
  final String nativeName;

  const AppLanguage(this.code, this.nativeName);

  /// Returns the flag emoji for the language.
  String get flag => switch (this) {
        AppLanguage.system => '\u{1F310}', // Globe
        AppLanguage.english => '\u{1F1EC}\u{1F1E7}', // UK flag
        AppLanguage.french => '\u{1F1EB}\u{1F1F7}', // French flag
      };

  /// Returns the localized name of the language.
  String getLocalizedName(AppLocalizations l10n) => switch (this) {
        AppLanguage.system => l10n.system,
        AppLanguage.english => l10n.english,
        AppLanguage.french => l10n.french,
      };

  /// Gets the AppLanguage from a locale code.
  static AppLanguage fromCode(String? code) {
    if (code == null) return AppLanguage.system;
    return AppLanguage.values.firstWhere(
      (lang) => lang.code == code,
      orElse: () => AppLanguage.system,
    );
  }
}

/// A tile widget for selecting the app language.
class LanguageTile extends StatelessWidget {
  const LanguageTile({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return BlocBuilder<SettingsCubit, SettingsState>(
      buildWhen: (previous, current) =>
          previous.settings.localeCode != current.settings.localeCode,
      builder: (context, state) {
        final currentLanguage = AppLanguage.fromCode(state.settings.localeCode);

        return ListTile(
          leading: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: colorScheme.tertiaryContainer,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(Icons.language_rounded),
          ),
          title: Text(l10n.language),
          subtitle: Text(
            '${currentLanguage.flag} ${currentLanguage.getLocalizedName(l10n)}',
          ),
          trailing: const Icon(Icons.chevron_right_rounded),
          onTap: () => _showLanguageSelector(context, currentLanguage),
        );
      },
    );
  }

  void _showLanguageSelector(BuildContext context, AppLanguage current) {
    final l10n = AppLocalizations.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (sheetContext) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Handle
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: colorScheme.outline.withValues(alpha: 0.3),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 16),
                // Title
                Text(
                  l10n.language,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 16),
                // Language options
                ...AppLanguage.values.map(
                  (language) => _LanguageOption(
                    language: language,
                    isSelected: language == current,
                    onTap: () {
                      context.read<SettingsCubit>().updateLocale(language.code);
                      Navigator.pop(sheetContext);
                    },
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _LanguageOption extends StatelessWidget {
  final AppLanguage language;
  final bool isSelected;
  final VoidCallback onTap;

  const _LanguageOption({
    required this.language,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final colorScheme = Theme.of(context).colorScheme;

    return ListTile(
      leading: Text(
        language.flag,
        style: const TextStyle(fontSize: 28),
      ),
      title: Text(
        language.getLocalizedName(l10n),
        style: TextStyle(
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          color: isSelected ? colorScheme.primary : null,
        ),
      ),
      subtitle: Text(
        language.nativeName,
        style: TextStyle(
          color: colorScheme.outline,
          fontSize: 12,
        ),
      ),
      trailing: isSelected
          ? Icon(
              Icons.check_circle_rounded,
              color: colorScheme.primary,
            )
          : null,
      onTap: onTap,
    );
  }
}
