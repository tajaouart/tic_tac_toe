import 'package:equatable/equatable.dart';

class GameStatistics extends Equatable {
  final int wins;
  final int losses;
  final int draws;
  final int currentStreak;
  final int bestStreak;

  const GameStatistics({
    this.wins = 0,
    this.losses = 0,
    this.draws = 0,
    this.currentStreak = 0,
    this.bestStreak = 0,
  });

  int get totalGames => wins + losses + draws;

  double get winRate {
    if (totalGames == 0) return 0;
    return (wins / totalGames) * 100;
  }

  GameStatistics recordWin() {
    final newStreak = currentStreak + 1;
    return GameStatistics(
      wins: wins + 1,
      losses: losses,
      draws: draws,
      currentStreak: newStreak,
      bestStreak: newStreak > bestStreak ? newStreak : bestStreak,
    );
  }

  GameStatistics recordLoss() {
    return GameStatistics(
      wins: wins,
      losses: losses + 1,
      draws: draws,
      currentStreak: 0,
      bestStreak: bestStreak,
    );
  }

  GameStatistics recordDraw() {
    return GameStatistics(
      wins: wins,
      losses: losses,
      draws: draws + 1,
      currentStreak: currentStreak,
      bestStreak: bestStreak,
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

  @override
  List<Object?> get props => [wins, losses, draws, currentStreak, bestStreak];
}
