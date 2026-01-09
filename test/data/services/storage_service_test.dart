import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tic_tac_toe/core/constants/app_constants.dart';
import 'package:tic_tac_toe/core/error/result.dart';
import 'package:tic_tac_toe/data/services/storage_service.dart';
import 'package:tic_tac_toe/domain/entities/difficulty.dart';
import 'package:tic_tac_toe/domain/entities/game_statistics.dart';
import 'package:tic_tac_toe/domain/entities/user_settings.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late StorageService storageService;
  late MockSharedPreferences mockPrefs;

  setUp(() {
    mockPrefs = MockSharedPreferences();
    storageService = StorageService(mockPrefs);
  });

  group('StorageService', () {
    group('getSettings', () {
      test('returns default settings when no data exists', () {
        when(() => mockPrefs.getString(AppConstants.settingsStorageKey))
            .thenReturn(null);

        final result = storageService.getSettings();

        expect(result.isSuccess, true);
        expect(result.value, const UserSettings());
      });

      test('returns stored settings when data exists', () {
        final settings = const UserSettings(
          playerName: 'TestPlayer',
          difficulty: Difficulty.easy,
        );
        when(() => mockPrefs.getString(AppConstants.settingsStorageKey))
            .thenReturn(jsonEncode(settings.toJson()));

        final result = storageService.getSettings();

        expect(result.isSuccess, true);
        expect(result.value.playerName, 'TestPlayer');
        expect(result.value.difficulty, Difficulty.easy);
      });

      test('returns failure when JSON is invalid', () {
        when(() => mockPrefs.getString(AppConstants.settingsStorageKey))
            .thenReturn('invalid json');

        final result = storageService.getSettings();

        expect(result.isFailure, true);
      });
    });

    group('saveSettings', () {
      test('saves settings successfully', () async {
        when(() => mockPrefs.setString(any(), any()))
            .thenAnswer((_) async => true);

        final result = await storageService.saveSettings(const UserSettings());

        expect(result.isSuccess, true);
        verify(() => mockPrefs.setString(
              AppConstants.settingsStorageKey,
              any(),
            )).called(1);
      });

      test('returns failure when save fails', () async {
        when(() => mockPrefs.setString(any(), any()))
            .thenAnswer((_) async => false);

        final result = await storageService.saveSettings(const UserSettings());

        expect(result.isFailure, true);
      });
    });

    group('getStatistics', () {
      test('returns default statistics when no data exists', () {
        when(() => mockPrefs.getString(AppConstants.statisticsStorageKey))
            .thenReturn(null);

        final result = storageService.getStatistics();

        expect(result.isSuccess, true);
        expect(result.value, const GameStatistics());
      });

      test('returns stored statistics when data exists', () {
        final stats = const GameStatistics(wins: 5, losses: 3, draws: 2);
        when(() => mockPrefs.getString(AppConstants.statisticsStorageKey))
            .thenReturn(jsonEncode(stats.toJson()));

        final result = storageService.getStatistics();

        expect(result.isSuccess, true);
        expect(result.value.wins, 5);
        expect(result.value.losses, 3);
        expect(result.value.draws, 2);
      });

      test('returns failure when JSON is invalid', () {
        when(() => mockPrefs.getString(AppConstants.statisticsStorageKey))
            .thenReturn('invalid json');

        final result = storageService.getStatistics();

        expect(result.isFailure, true);
      });
    });

    group('saveStatistics', () {
      test('saves statistics successfully', () async {
        when(() => mockPrefs.setString(any(), any()))
            .thenAnswer((_) async => true);

        final result = await storageService.saveStatistics(const GameStatistics());

        expect(result.isSuccess, true);
      });

      test('returns failure when save fails', () async {
        when(() => mockPrefs.setString(any(), any()))
            .thenAnswer((_) async => false);

        final result = await storageService.saveStatistics(const GameStatistics());

        expect(result.isFailure, true);
      });
    });

    group('resetStatistics', () {
      test('resets statistics successfully', () async {
        when(() => mockPrefs.remove(any())).thenAnswer((_) async => true);

        final result = await storageService.resetStatistics();

        expect(result.isSuccess, true);
        verify(() => mockPrefs.remove(AppConstants.statisticsStorageKey)).called(1);
      });

      test('returns failure when reset fails', () async {
        when(() => mockPrefs.remove(any())).thenAnswer((_) async => false);

        final result = await storageService.resetStatistics();

        expect(result.isFailure, true);
      });
    });
  });
}
