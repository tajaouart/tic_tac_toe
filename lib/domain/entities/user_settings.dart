import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tic_tac_toe/domain/entities/difficulty.dart';

part 'user_settings.freezed.dart';

@freezed
class UserSettings with _$UserSettings {
  const UserSettings._();

  const factory UserSettings({
    @Default('Player') String playerName,
    @Default(Difficulty.hard) Difficulty difficulty,
    @Default(ThemeMode.system) ThemeMode themeMode,
    @Default(true) bool soundEnabled,
    /// Locale code (e.g., 'en', 'fr'). Null means system default.
    String? localeCode,
  }) = _UserSettings;

  Map<String, dynamic> toJson() {
    return {
      'playerName': playerName,
      'difficulty': difficulty.name,
      'themeMode': themeMode.name,
      'soundEnabled': soundEnabled,
      'localeCode': localeCode,
    };
  }

  factory UserSettings.fromJson(Map<String, dynamic> json) {
    return UserSettings(
      playerName: _parsePlayerName(json['playerName']),
      difficulty: _parseDifficulty(json['difficulty']),
      themeMode: _parseThemeMode(json['themeMode']),
      soundEnabled: json['soundEnabled'] ?? true,
      localeCode: _parseLocaleCode(json['localeCode']),
    );
  }

  static String? _parseLocaleCode(dynamic value) {
    if (value is String && (value == 'en' || value == 'fr')) {
      return value;
    }
    return null; // System default
  }

  static String _parsePlayerName(dynamic value) {
    if (value is String && value.isNotEmpty && value.length <= 20) {
      return value;
    }
    return 'Player';
  }

  static Difficulty _parseDifficulty(dynamic value) {
    if (value is String) {
      return Difficulty.values.firstWhere(
        (e) => e.name == value,
        orElse: () => Difficulty.hard,
      );
    }
    if (value is int && value >= 0 && value < Difficulty.values.length) {
      return Difficulty.values[value];
    }
    return Difficulty.hard;
  }

  static ThemeMode _parseThemeMode(dynamic value) {
    if (value is String) {
      return ThemeMode.values.firstWhere(
        (e) => e.name == value,
        orElse: () => ThemeMode.system,
      );
    }
    if (value is int && value >= 0 && value < ThemeMode.values.length) {
      return ThemeMode.values[value];
    }
    return ThemeMode.system;
  }
}
