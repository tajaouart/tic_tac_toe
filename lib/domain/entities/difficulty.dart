enum Difficulty {
  easy,
  medium,
  hard;

  String get displayName {
    switch (this) {
      case Difficulty.easy:
        return 'Easy';
      case Difficulty.medium:
        return 'Medium';
      case Difficulty.hard:
        return 'Hard';
    }
  }

  String get description {
    switch (this) {
      case Difficulty.easy:
        return 'CPU makes random moves';
      case Difficulty.medium:
        return 'CPU plays smart sometimes';
      case Difficulty.hard:
        return 'Unbeatable CPU (minimax)';
    }
  }
}
