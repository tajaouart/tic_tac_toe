import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:tic_tac_toe/domain/entities/difficulty.dart';

class UserSettings extends Equatable {
  final String playerName;
  final Difficulty difficulty;
  final ThemeMode themeMode;
  final bool soundEnabled;

  const UserSettings({
    this.playerName = 'Player',
    this.difficulty = Difficulty.hard,
    this.themeMode = ThemeMode.system,
    this.soundEnabled = true,
  });

  UserSettings copyWith({
    String? playerName,
    Difficulty? difficulty,
    ThemeMode? themeMode,
    bool? soundEnabled,
  }) {
    return UserSettings(
      playerName: playerName ?? this.playerName,
      difficulty: difficulty ?? this.difficulty,
      themeMode: themeMode ?? this.themeMode,
      soundEnabled: soundEnabled ?? this.soundEnabled,
    );
  }

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

  @override
  List<Object?> get props => [playerName, difficulty, themeMode, soundEnabled];
}
