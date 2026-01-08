import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tic_tac_toe/domain/entities/game_statistics.dart';
import 'package:tic_tac_toe/domain/entities/user_settings.dart';

class StorageService {
  static const String _settingsKey = 'user_settings';
  static const String _statisticsKey = 'game_statistics';

  final SharedPreferences _prefs;

  StorageService(this._prefs);

  UserSettings getSettings() {
    final json = _prefs.getString(_settingsKey);
    if (json == null) return const UserSettings();
    try {
      return UserSettings.fromJson(jsonDecode(json));
    } catch (_) {
      return const UserSettings();
    }
  }

  Future<void> saveSettings(UserSettings settings) async {
    await _prefs.setString(_settingsKey, jsonEncode(settings.toJson()));
  }

  GameStatistics getStatistics() {
    final json = _prefs.getString(_statisticsKey);
    if (json == null) return const GameStatistics();
    try {
      return GameStatistics.fromJson(jsonDecode(json));
    } catch (_) {
      return const GameStatistics();
    }
  }

  Future<void> saveStatistics(GameStatistics statistics) async {
    await _prefs.setString(_statisticsKey, jsonEncode(statistics.toJson()));
  }

  Future<void> resetStatistics() async {
    await _prefs.remove(_statisticsKey);
  }
}
