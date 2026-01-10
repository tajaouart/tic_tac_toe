import 'package:freezed_annotation/freezed_annotation.dart';

part 'game_statistics.freezed.dart';

@freezed
class GameStatistics with _$GameStatistics {
  const GameStatistics._();

  const factory GameStatistics({
    @Default(0) int wins,
    @Default(0) int losses,
    @Default(0) int draws,
    @Default(0) int currentStreak,
    @Default(0) int bestStreak,
  }) = _GameStatistics;

  int get totalGames => wins + losses + draws;

  double get winRate {
    if (totalGames == 0) return 0;
    return (wins / totalGames) * 100;
  }

  GameStatistics recordWin() {
    final newStreak = currentStreak + 1;
    return copyWith(
      wins: wins + 1,
      currentStreak: newStreak,
      bestStreak: newStreak > bestStreak ? newStreak : bestStreak,
    );
  }

  GameStatistics recordLoss() {
    return copyWith(
      losses: losses + 1,
      currentStreak: 0,
    );
  }

  GameStatistics recordDraw() {
    return copyWith(
      draws: draws + 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'wins': wins,
      'losses': losses,
      'draws': draws,
      'currentStreak': currentStreak,
      'bestStreak': bestStreak,
    };
  }

  factory GameStatistics.fromJson(Map<String, dynamic> json) {
    return GameStatistics(
      wins: json['wins'] ?? 0,
      losses: json['losses'] ?? 0,
      draws: json['draws'] ?? 0,
      currentStreak: json['currentStreak'] ?? 0,
      bestStreak: json['bestStreak'] ?? 0,
    );
  }
}
