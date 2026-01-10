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
  }) = _UserSettings;

  Map<String, dynamic> toJson() {
    return {
      'playerName': playerName,
      'difficulty': difficulty.index,
      'themeMode': themeMode.index,
      'soundEnabled': soundEnabled,
    };
  }

  factory UserSettings.fromJson(Map<String, dynamic> json) {
    return UserSettings(
      playerName: json['playerName'] ?? 'Player',
      difficulty: Difficulty.values[json['difficulty'] ?? 2],
      themeMode: ThemeMode.values[json['themeMode'] ?? 0],
      soundEnabled: json['soundEnabled'] ?? true,
    );
  }
}
