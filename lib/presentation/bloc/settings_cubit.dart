import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:tic_tac_toe/data/services/storage_service.dart';
import 'package:tic_tac_toe/domain/entities/difficulty.dart';
import 'package:tic_tac_toe/domain/entities/game_statistics.dart';
import 'package:tic_tac_toe/domain/entities/user_settings.dart';

/// State for the settings cubit.
class SettingsState extends Equatable {
  final UserSettings settings;
  final GameStatistics statistics;
  final bool isLoading;
  final String? errorMessage;

  const SettingsState({
    required this.settings,
    required this.statistics,
    this.isLoading = false,
    this.errorMessage,
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
    bool? isLoading,
    String? errorMessage,
  }) {
    return SettingsState(
      settings: settings ?? this.settings,
      statistics: statistics ?? this.statistics,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }

  /// Clears any error message.
  SettingsState clearError() => copyWith(errorMessage: null);

  @override
  List<Object?> get props => [settings, statistics, isLoading, errorMessage];
}

/// Cubit responsible for managing user settings and game statistics.
///
/// Handles persistence of settings and statistics, providing a reactive
/// interface for the UI to consume.
@lazySingleton
class SettingsCubit extends Cubit<SettingsState> {
  final StorageService _storageService;

  SettingsCubit(this._storageService) : super(SettingsState.initial()) {
    _loadData();
  }

  void _loadData() {
    final settingsResult = _storageService.getSettings();
    final statisticsResult = _storageService.getStatistics();

    emit(SettingsState(
      settings: settingsResult.getOrElse(const UserSettings()),
      statistics: statisticsResult.getOrElse(const GameStatistics()),
    ));
  }

  Future<void> updatePlayerName(String name) async {
    final newSettings = state.settings.copyWith(playerName: name);
    await _saveSettings(newSettings);
  }

  Future<void> updateDifficulty(Difficulty difficulty) async {
    final newSettings = state.settings.copyWith(difficulty: difficulty);
    await _saveSettings(newSettings);
  }

  Future<void> updateThemeMode(ThemeMode themeMode) async {
    final newSettings = state.settings.copyWith(themeMode: themeMode);
    await _saveSettings(newSettings);
  }

  Future<void> updateSoundEnabled(bool enabled) async {
    final newSettings = state.settings.copyWith(soundEnabled: enabled);
    await _saveSettings(newSettings);
  }

  Future<void> _saveSettings(UserSettings newSettings) async {
    emit(state.copyWith(settings: newSettings));

    final result = await _storageService.saveSettings(newSettings);
    if (result.isFailure) {
      emit(state.copyWith(errorMessage: 'Failed to save settings'));
    }
  }

  Future<void> recordWin() async {
    final newStats = state.statistics.recordWin();
    await _saveStatistics(newStats);
  }

  Future<void> recordLoss() async {
    final newStats = state.statistics.recordLoss();
    await _saveStatistics(newStats);
  }

  Future<void> recordDraw() async {
    final newStats = state.statistics.recordDraw();
    await _saveStatistics(newStats);
  }

  Future<void> _saveStatistics(GameStatistics newStats) async {
    emit(state.copyWith(statistics: newStats));

    final result = await _storageService.saveStatistics(newStats);
    if (result.isFailure) {
      emit(state.copyWith(errorMessage: 'Failed to save statistics'));
    }
  }

  Future<void> resetStatistics() async {
    final result = await _storageService.resetStatistics();

    if (result.isSuccess) {
      emit(state.copyWith(statistics: const GameStatistics()));
    } else {
      emit(state.copyWith(errorMessage: 'Failed to reset statistics'));
    }
  }

  void clearError() {
    emit(state.clearError());
  }
}
