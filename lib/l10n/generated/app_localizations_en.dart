// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Tic Tac Toe';

  @override
  String get player => 'Player';

  @override
  String get cpu => 'CPU';

  @override
  String get vs => 'VS';

  @override
  String wins(int count) {
    return '$count wins';
  }

  @override
  String get yourTurn => 'Your turn';

  @override
  String get cpuThinking => 'CPU is thinking...';

  @override
  String get youWin => 'You Win!';

  @override
  String get cpuWins => 'CPU Wins';

  @override
  String get draw => 'It\'s a Draw';

  @override
  String get playAgain => 'Play Again';

  @override
  String get newGame => 'New Game';

  @override
  String get settings => 'Settings';

  @override
  String get statistics => 'Statistics';

  @override
  String get profile => 'Profile';

  @override
  String get playerName => 'Player Name';

  @override
  String get enterYourName => 'Enter your name';

  @override
  String get gameSettings => 'Game Settings';

  @override
  String get difficulty => 'Difficulty';

  @override
  String get easy => 'Easy';

  @override
  String get medium => 'Medium';

  @override
  String get hard => 'Hard';

  @override
  String get appearance => 'Appearance';

  @override
  String get theme => 'Theme';

  @override
  String get system => 'System';

  @override
  String get light => 'Light';

  @override
  String get dark => 'Dark';

  @override
  String get language => 'Language';

  @override
  String get english => 'English';

  @override
  String get french => 'French';

  @override
  String get sound => 'Sound';

  @override
  String get soundEffects => 'Sound Effects';

  @override
  String get dangerZone => 'Danger Zone';

  @override
  String get resetStatistics => 'Reset Statistics';

  @override
  String get resetStatisticsDescription => 'Clear all your game history';

  @override
  String get confirmReset => 'Confirm Reset';

  @override
  String get resetConfirmationMessage =>
      'Are you sure you want to reset all statistics? This action cannot be undone.';

  @override
  String get cancel => 'Cancel';

  @override
  String get reset => 'Reset';

  @override
  String get gamesPlayed => 'Games Played';

  @override
  String get winsLabel => 'Wins';

  @override
  String get lossesLabel => 'Losses';

  @override
  String get drawsLabel => 'Draws';

  @override
  String get winRate => 'Win Rate';

  @override
  String get currentStreak => 'Current Streak';

  @override
  String get bestStreak => 'Best Streak';

  @override
  String get overview => 'Overview';

  @override
  String get performance => 'Performance';

  @override
  String get noGamesYet => 'No games played yet';

  @override
  String get startPlaying => 'Start playing to see your statistics!';

  @override
  String totalGames(int count) {
    return 'Total games: $count';
  }

  @override
  String get champion => 'Tic Tac Toe Champion';

  @override
  String get selectDifficulty => 'Select Difficulty';

  @override
  String get changeName => 'Change Name';

  @override
  String get name => 'Name';

  @override
  String get save => 'Save';

  @override
  String get selectTheme => 'Select Theme';

  @override
  String get statisticsReset => 'Statistics reset';

  @override
  String get easyDescription => 'Random moves, perfect for beginners';

  @override
  String get mediumDescription => 'Mix of strategy and random moves';

  @override
  String get hardDescription => 'Optimal strategy, nearly unbeatable';
}
