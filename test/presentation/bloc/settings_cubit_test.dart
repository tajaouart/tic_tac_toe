import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tic_tac_toe/data/services/storage_service.dart';
import 'package:tic_tac_toe/domain/entities/difficulty.dart';
import 'package:tic_tac_toe/domain/entities/game_statistics.dart';
import 'package:tic_tac_toe/domain/entities/user_settings.dart';
import 'package:tic_tac_toe/presentation/bloc/settings_cubit.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late SettingsCubit cubit;
  late MockSharedPreferences mockPrefs;
  late StorageService storageService;

  setUp(() {
    mockPrefs = MockSharedPreferences();
    when(() => mockPrefs.getString(any())).thenReturn(null);
    when(() => mockPrefs.setString(any(), any())).thenAnswer((_) async => true);
    when(() => mockPrefs.remove(any())).thenAnswer((_) async => true);

    storageService = StorageService(mockPrefs);
    cubit = SettingsCubit(storageService);
  });

  tearDown(() {
    cubit.close();
  });

  group('SettingsCubit', () {
    test('initial state has default values', () {
      expect(cubit.state.settings, const UserSettings());
      expect(cubit.state.statistics, const GameStatistics());
    });

    group('settings updates', () {
      test('updatePlayerName updates player name', () async {
        await cubit.updatePlayerName('NewPlayer');

        expect(cubit.state.settings.playerName, 'NewPlayer');
      });

      test('updateDifficulty updates difficulty', () async {
        await cubit.updateDifficulty(Difficulty.easy);

        expect(cubit.state.settings.difficulty, Difficulty.easy);
      });

      test('updateThemeMode updates theme mode', () async {
        await cubit.updateThemeMode(ThemeMode.dark);

        expect(cubit.state.settings.themeMode, ThemeMode.dark);
      });

      test('updateSoundEnabled updates sound setting', () async {
        await cubit.updateSoundEnabled(false);

        expect(cubit.state.settings.soundEnabled, false);
      });
    });

    group('statistics', () {
      test('recordWin increments wins and updates streak', () async {
        await cubit.recordWin();

        expect(cubit.state.statistics.wins, 1);
        expect(cubit.state.statistics.currentStreak, 1);
        expect(cubit.state.statistics.bestStreak, 1);
      });

      test('recordLoss increments losses and resets streak', () async {
        await cubit.recordWin();
        await cubit.recordLoss();

        expect(cubit.state.statistics.wins, 1);
        expect(cubit.state.statistics.losses, 1);
        expect(cubit.state.statistics.currentStreak, 0);
        expect(cubit.state.statistics.bestStreak, 1);
      });

      test('recordDraw increments draws and preserves streak', () async {
        await cubit.recordWin();
        await cubit.recordDraw();

        expect(cubit.state.statistics.wins, 1);
        expect(cubit.state.statistics.draws, 1);
        expect(cubit.state.statistics.currentStreak, 1);
      });

      test('resetStatistics clears all statistics', () async {
        await cubit.recordWin();
        await cubit.recordWin();
        await cubit.recordLoss();

        await cubit.resetStatistics();

        expect(cubit.state.statistics, const GameStatistics());
      });

      test('win rate calculates correctly', () async {
        await cubit.recordWin();
        await cubit.recordWin();
        await cubit.recordLoss();
        await cubit.recordDraw();

        // 2 wins out of 4 games = 50%
        expect(cubit.state.statistics.winRate, 50.0);
      });
    });

    group('error handling', () {
      test('clearError clears error message', () async {
        // Simulate an error state
        cubit.emit(cubit.state.copyWith(errorMessage: 'Test error'));
        expect(cubit.state.errorMessage, 'Test error');

        cubit.clearError();
        expect(cubit.state.errorMessage, isNull);
      });
    });
  });
}
