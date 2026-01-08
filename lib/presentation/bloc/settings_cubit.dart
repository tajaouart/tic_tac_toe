import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tic_tac_toe/data/services/storage_service.dart';
import 'package:tic_tac_toe/domain/entities/difficulty.dart';
import 'package:tic_tac_toe/domain/entities/game_statistics.dart';
import 'package:tic_tac_toe/domain/entities/user_settings.dart';

class SettingsState extends Equatable {
  final UserSettings settings;
  final GameStatistics statistics;

  const SettingsState({
    required this.settings,
    required this.statistics,
  });

  factory SettingsState.initial() {
    return const SettingsState(
      settings: UserSettings(),
      statistics: GameStatistics(),
    );
  }

  SettingsState copyWith({
    UserSettings? settings,
    GameStatistics? statistics,
  }) {
    return SettingsState(
      settings: settings ?? this.settings,
      statistics: statistics ?? this.statistics,
    );
  }

  @override
  List<Object?> get props => [settings, statistics];
}

class SettingsCubit extends Cubit<SettingsState> {
  final StorageService _storageService;

  SettingsCubit(this._storageService) : super(SettingsState.initial()) {
    _loadData();
  }

  void _loadData() {
    final settings = _storageService.getSettings();
    final statistics = _storageService.getStatistics();
    emit(SettingsState(settings: settings, statistics: statistics));
  }

  Future<void> updatePlayerName(String name) async {
    final newSettings = state.settings.copyWith(playerName: name);
    await _storageService.saveSettings(newSettings);
    emit(state.copyWith(settings: newSettings));
  }

  Future<void> updateDifficulty(Difficulty difficulty) async {
    final newSettings = state.settings.copyWith(difficulty: difficulty);
    await _storageService.saveSettings(newSettings);
    emit(state.copyWith(settings: newSettings));
  }

  Future<void> updateThemeMode(ThemeMode themeMode) async {
    final newSettings = state.settings.copyWith(themeMode: themeMode);
    await _storageService.saveSettings(newSettings);
    emit(state.copyWith(settings: newSettings));
  }

  Future<void> updateSoundEnabled(bool enabled) async {
    final newSettings = state.settings.copyWith(soundEnabled: enabled);
    await _storageService.saveSettings(newSettings);
    emit(state.copyWith(settings: newSettings));
  }

  Future<void> recordWin() async {
    final newStats = state.statistics.recordWin();
    await _storageService.saveStatistics(newStats);
    emit(state.copyWith(statistics: newStats));
  }

  Future<void> recordLoss() async {
    final newStats = state.statistics.recordLoss();
    await _storageService.saveStatistics(newStats);
    emit(state.copyWith(statistics: newStats));
  }

  Future<void> recordDraw() async {
    final newStats = state.statistics.recordDraw();
    await _storageService.saveStatistics(newStats);
    emit(state.copyWith(statistics: newStats));
  }

  Future<void> resetStatistics() async {
    await _storageService.resetStatistics();
    emit(state.copyWith(statistics: const GameStatistics()));
  }
}
