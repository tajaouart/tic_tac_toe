abstract final class AppConstants {
  // Storage keys
  static const String settingsStorageKey = 'user_settings';
  static const String statisticsStorageKey = 'game_statistics';

  // Animation durations (in milliseconds)
  static const int defaultAnimationDuration = 200;
  static const int aiThinkingDelay = 500;

  // Game configuration
  static const int boardSize = 3;
  static const int totalCells = boardSize * boardSize;

  // AI scoring for minimax algorithm
  static const int minimaxWinScore = 10;
  static const int minimaxLoseScore = -10;
  static const int minimaxDrawScore = 0;
  static const int minimaxInitialBestScore = -1000;
  static const int minimaxInitialWorstScore = 1000;

  // UI constants
  static const double maxBoardWidth = 500.0;
  static const double minBoardSize = 250.0;
  static const double maxBoardSize = 380.0;
  static const double boardHeightFactor = 0.55;
  static const double cellBorderRadius = 12.0;
  static const double cellBorderWidth = 2.0;
  static const double cellFontSize = 48.0;
  static const double statusBarBorderRadius = 24.0;
  static const double statusBarFontSize = 18.0;
}

/// Winning combinations for tic-tac-toe board.
///
/// Each inner list represents indices that form a winning line.
abstract final class WinningCombinations {
  static const List<List<int>> all = [
    [0, 1, 2], // Top row
    [3, 4, 5], // Middle row
    [6, 7, 8], // Bottom row
    [0, 3, 6], // Left column
    [1, 4, 7], // Middle column
    [2, 5, 8], // Right column
    [0, 4, 8], // Main diagonal
    [2, 4, 6], // Anti-diagonal
  ];
}
