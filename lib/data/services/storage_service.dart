import 'dart:convert';
import 'dart:developer' as developer;

import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tic_tac_toe/core/constants/app_constants.dart';
import 'package:tic_tac_toe/core/error/exceptions.dart';
import 'package:tic_tac_toe/core/error/failures.dart';
import 'package:tic_tac_toe/core/error/result.dart';
import 'package:tic_tac_toe/domain/entities/game_statistics.dart';
import 'package:tic_tac_toe/domain/entities/user_settings.dart';

/// Service responsible for persisting and retrieving user data.
///
/// Handles all storage operations for settings and statistics with proper
/// error handling and logging.
@lazySingleton
class StorageService {
  final SharedPreferences _prefs;

  StorageService(this._prefs);

  /// Retrieves user settings from storage.
  ///
  /// Returns default settings if no data exists or if data is corrupted.
  Result<UserSettings> getSettings() {
    try {
      final json = _prefs.getString(AppConstants.settingsStorageKey);
      if (json == null) {
        developer.log('No settings found, returning defaults', name: 'StorageService');
        return const Success(UserSettings());
      }

      final decoded = jsonDecode(json) as Map<String, dynamic>;
      return Success(UserSettings.fromJson(decoded));
    } on FormatException catch (e) {
      developer.log(
        'Settings data corrupted, returning defaults',
        name: 'StorageService',
        error: e,
      );
      return const Fail(SettingsLoadFailure());
    } on TypeError catch (e) {
      developer.log(
        'Settings type error, returning defaults',
        name: 'StorageService',
        error: e,
      );
      return const Fail(SettingsLoadFailure());
    }
  }

  /// Saves user settings to storage.
  ///
  /// Throws [StorageWriteException] if the operation fails.
  Future<Result<void>> saveSettings(UserSettings settings) async {
    try {
      final json = jsonEncode(settings.toJson());
      final success = await _prefs.setString(AppConstants.settingsStorageKey, json);

      if (!success) {
        developer.log('Failed to write settings', name: 'StorageService');
        return const Fail(SettingsSaveFailure());
      }

      return const Success(null);
    } catch (e) {
      developer.log(
        'Error saving settings',
        name: 'StorageService',
        error: e,
      );
      return const Fail(SettingsSaveFailure());
    }
  }

  /// Retrieves game statistics from storage.
  ///
  /// Returns empty statistics if no data exists or if data is corrupted.
  Result<GameStatistics> getStatistics() {
    try {
      final json = _prefs.getString(AppConstants.statisticsStorageKey);
      if (json == null) {
        developer.log('No statistics found, returning defaults', name: 'StorageService');
        return const Success(GameStatistics());
      }

      final decoded = jsonDecode(json) as Map<String, dynamic>;
      return Success(GameStatistics.fromJson(decoded));
    } on FormatException catch (e) {
      developer.log(
        'Statistics data corrupted, returning defaults',
        name: 'StorageService',
        error: e,
      );
      return const Fail(StatisticsLoadFailure());
    } on TypeError catch (e) {
      developer.log(
        'Statistics type error, returning defaults',
        name: 'StorageService',
        error: e,
      );
      return const Fail(StatisticsLoadFailure());
    }
  }

  /// Saves game statistics to storage.
  ///
  /// Throws [StorageWriteException] if the operation fails.
  Future<Result<void>> saveStatistics(GameStatistics statistics) async {
    try {
      final json = jsonEncode(statistics.toJson());
      final success = await _prefs.setString(AppConstants.statisticsStorageKey, json);

      if (!success) {
        developer.log('Failed to write statistics', name: 'StorageService');
        return const Fail(StatisticsSaveFailure());
      }

      return const Success(null);
    } catch (e) {
      developer.log(
        'Error saving statistics',
        name: 'StorageService',
        error: e,
      );
      return const Fail(StatisticsSaveFailure());
    }
  }

  /// Clears all statistics from storage.
  Future<Result<void>> resetStatistics() async {
    try {
      final success = await _prefs.remove(AppConstants.statisticsStorageKey);

      if (!success) {
        developer.log('Failed to reset statistics', name: 'StorageService');
        return const Fail(StatisticsSaveFailure());
      }

      return const Success(null);
    } catch (e) {
      developer.log(
        'Error resetting statistics',
        name: 'StorageService',
        error: e,
      );
      return const Fail(StatisticsSaveFailure());
    }
  }
}
