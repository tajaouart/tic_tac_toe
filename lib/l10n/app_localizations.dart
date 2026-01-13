import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('fr'),
  ];

  /// The title of the application
  ///
  /// In en, this message translates to:
  /// **'Tic Tac Toe'**
  String get appTitle;

  /// Default player name
  ///
  /// In en, this message translates to:
  /// **'Player'**
  String get player;

  /// Computer opponent name
  ///
  /// In en, this message translates to:
  /// **'CPU'**
  String get cpu;

  /// Versus abbreviation
  ///
  /// In en, this message translates to:
  /// **'VS'**
  String get vs;

  /// Number of wins
  ///
  /// In en, this message translates to:
  /// **'{count} wins'**
  String wins(int count);

  /// Status when it's player's turn
  ///
  /// In en, this message translates to:
  /// **'Your turn'**
  String get yourTurn;

  /// Status when CPU is thinking
  ///
  /// In en, this message translates to:
  /// **'CPU is thinking...'**
  String get cpuThinking;

  /// Status when player wins
  ///
  /// In en, this message translates to:
  /// **'You Win!'**
  String get youWin;

  /// Status when CPU wins
  ///
  /// In en, this message translates to:
  /// **'CPU Wins'**
  String get cpuWins;

  /// Status when game is a draw
  ///
  /// In en, this message translates to:
  /// **'It\'s a Draw'**
  String get draw;

  /// Button to start a new game
  ///
  /// In en, this message translates to:
  /// **'Play Again'**
  String get playAgain;

  /// Tooltip for new game button
  ///
  /// In en, this message translates to:
  /// **'New Game'**
  String get newGame;

  /// Settings page title and button
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// Statistics page title
  ///
  /// In en, this message translates to:
  /// **'Statistics'**
  String get statistics;

  /// Profile section title
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// Player name setting label
  ///
  /// In en, this message translates to:
  /// **'Player Name'**
  String get playerName;

  /// Player name input hint
  ///
  /// In en, this message translates to:
  /// **'Enter your name'**
  String get enterYourName;

  /// Game settings section title
  ///
  /// In en, this message translates to:
  /// **'Game Settings'**
  String get gameSettings;

  /// Difficulty setting label
  ///
  /// In en, this message translates to:
  /// **'Difficulty'**
  String get difficulty;

  /// Easy difficulty level
  ///
  /// In en, this message translates to:
  /// **'Easy'**
  String get easy;

  /// Medium difficulty level
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get medium;

  /// Hard difficulty level
  ///
  /// In en, this message translates to:
  /// **'Hard'**
  String get hard;

  /// Appearance section title
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get appearance;

  /// Theme setting label
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// System theme option
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get system;

  /// Light theme option
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get light;

  /// Dark theme option
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get dark;

  /// Language setting label
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// English language option
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// French language option
  ///
  /// In en, this message translates to:
  /// **'French'**
  String get french;

  /// Sound setting label
  ///
  /// In en, this message translates to:
  /// **'Sound'**
  String get sound;

  /// Sound effects setting description
  ///
  /// In en, this message translates to:
  /// **'Sound Effects'**
  String get soundEffects;

  /// Danger zone section title
  ///
  /// In en, this message translates to:
  /// **'Danger Zone'**
  String get dangerZone;

  /// Reset statistics button
  ///
  /// In en, this message translates to:
  /// **'Reset Statistics'**
  String get resetStatistics;

  /// Reset statistics description
  ///
  /// In en, this message translates to:
  /// **'Clear all your game history'**
  String get resetStatisticsDescription;

  /// Confirm reset dialog title
  ///
  /// In en, this message translates to:
  /// **'Confirm Reset'**
  String get confirmReset;

  /// Reset confirmation message
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to reset all statistics? This action cannot be undone.'**
  String get resetConfirmationMessage;

  /// Cancel button
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// Reset button
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get reset;

  /// Games played statistic label
  ///
  /// In en, this message translates to:
  /// **'Games Played'**
  String get gamesPlayed;

  /// Wins statistic label
  ///
  /// In en, this message translates to:
  /// **'Wins'**
  String get winsLabel;

  /// Losses statistic label
  ///
  /// In en, this message translates to:
  /// **'Losses'**
  String get lossesLabel;

  /// Draws statistic label
  ///
  /// In en, this message translates to:
  /// **'Draws'**
  String get drawsLabel;

  /// Win rate statistic label
  ///
  /// In en, this message translates to:
  /// **'Win Rate'**
  String get winRate;

  /// Current streak statistic label
  ///
  /// In en, this message translates to:
  /// **'Current Streak'**
  String get currentStreak;

  /// Best streak statistic label
  ///
  /// In en, this message translates to:
  /// **'Best Streak'**
  String get bestStreak;

  /// Overview section title
  ///
  /// In en, this message translates to:
  /// **'Overview'**
  String get overview;

  /// Performance section title
  ///
  /// In en, this message translates to:
  /// **'Performance'**
  String get performance;

  /// Message when no games have been played
  ///
  /// In en, this message translates to:
  /// **'No games played yet'**
  String get noGamesYet;

  /// Encouragement to start playing
  ///
  /// In en, this message translates to:
  /// **'Start playing to see your statistics!'**
  String get startPlaying;

  /// Total games played label
  ///
  /// In en, this message translates to:
  /// **'Total games: {count}'**
  String totalGames(int count);

  /// Player title/subtitle
  ///
  /// In en, this message translates to:
  /// **'Tic Tac Toe Champion'**
  String get champion;

  /// Difficulty dialog title
  ///
  /// In en, this message translates to:
  /// **'Select Difficulty'**
  String get selectDifficulty;

  /// Change name dialog title
  ///
  /// In en, this message translates to:
  /// **'Change Name'**
  String get changeName;

  /// Name input label
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// Save button
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// Theme dialog title
  ///
  /// In en, this message translates to:
  /// **'Select Theme'**
  String get selectTheme;

  /// Statistics reset confirmation message
  ///
  /// In en, this message translates to:
  /// **'Statistics reset'**
  String get statisticsReset;

  /// Easy difficulty description
  ///
  /// In en, this message translates to:
  /// **'Random moves, perfect for beginners'**
  String get easyDescription;

  /// Medium difficulty description
  ///
  /// In en, this message translates to:
  /// **'Mix of strategy and random moves'**
  String get mediumDescription;

  /// Hard difficulty description
  ///
  /// In en, this message translates to:
  /// **'Optimal strategy, nearly unbeatable'**
  String get hardDescription;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'fr':
      return AppLocalizationsFr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
