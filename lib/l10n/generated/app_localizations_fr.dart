// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'Tic Tac Toe';

  @override
  String get player => 'Joueur';

  @override
  String get cpu => 'CPU';

  @override
  String get vs => 'VS';

  @override
  String wins(int count) {
    return '$count victoires';
  }

  @override
  String get yourTurn => 'Votre tour';

  @override
  String get cpuThinking => 'CPU en reflexion...';

  @override
  String get youWin => 'Vous avez gagne !';

  @override
  String get cpuWins => 'CPU a gagne';

  @override
  String get draw => 'Match nul';

  @override
  String get playAgain => 'Rejouer';

  @override
  String get newGame => 'Nouvelle partie';

  @override
  String get settings => 'Parametres';

  @override
  String get statistics => 'Statistiques';

  @override
  String get profile => 'Profil';

  @override
  String get playerName => 'Nom du joueur';

  @override
  String get enterYourName => 'Entrez votre nom';

  @override
  String get gameSettings => 'Parametres du jeu';

  @override
  String get difficulty => 'Difficulte';

  @override
  String get easy => 'Facile';

  @override
  String get medium => 'Moyen';

  @override
  String get hard => 'Difficile';

  @override
  String get appearance => 'Apparence';

  @override
  String get theme => 'Theme';

  @override
  String get system => 'Systeme';

  @override
  String get light => 'Clair';

  @override
  String get dark => 'Sombre';

  @override
  String get language => 'Langue';

  @override
  String get english => 'Anglais';

  @override
  String get french => 'Francais';

  @override
  String get sound => 'Son';

  @override
  String get soundEffects => 'Effets sonores';

  @override
  String get dangerZone => 'Zone de danger';

  @override
  String get resetStatistics => 'Reinitialiser les statistiques';

  @override
  String get resetStatisticsDescription =>
      'Effacer tout votre historique de jeu';

  @override
  String get confirmReset => 'Confirmer la reinitialisation';

  @override
  String get resetConfirmationMessage =>
      'Etes-vous sur de vouloir reinitialiser toutes les statistiques ? Cette action est irreversible.';

  @override
  String get cancel => 'Annuler';

  @override
  String get reset => 'Reinitialiser';

  @override
  String get gamesPlayed => 'Parties jouees';

  @override
  String get winsLabel => 'Victoires';

  @override
  String get lossesLabel => 'Defaites';

  @override
  String get drawsLabel => 'Nuls';

  @override
  String get winRate => 'Taux de victoire';

  @override
  String get currentStreak => 'Serie actuelle';

  @override
  String get bestStreak => 'Meilleure serie';

  @override
  String get overview => 'Apercu';

  @override
  String get performance => 'Performance';

  @override
  String get noGamesYet => 'Aucune partie jouee';

  @override
  String get startPlaying => 'Commencez a jouer pour voir vos statistiques !';

  @override
  String totalGames(int count) {
    return 'Total parties : $count';
  }

  @override
  String get champion => 'Champion de Tic Tac Toe';

  @override
  String get selectDifficulty => 'Choisir la difficulte';

  @override
  String get changeName => 'Changer le nom';

  @override
  String get name => 'Nom';

  @override
  String get save => 'Enregistrer';

  @override
  String get selectTheme => 'Choisir le theme';

  @override
  String get statisticsReset => 'Statistiques reinitialisees';

  @override
  String get easyDescription => 'Coups aleatoires, parfait pour debuter';

  @override
  String get mediumDescription => 'Melange de strategie et de coups aleatoires';

  @override
  String get hardDescription => 'Strategie optimale, quasi imbattable';
}
