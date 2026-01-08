import 'package:go_router/go_router.dart';
import 'package:tic_tac_toe/presentation/pages/game_page.dart';
import 'package:tic_tac_toe/presentation/pages/settings_page.dart';
import 'package:tic_tac_toe/presentation/pages/statistics_page.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const GamePage(),
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsPage(),
    ),
    GoRoute(
      path: '/statistics',
      builder: (context, state) => const StatisticsPage(),
    ),
  ],
);
