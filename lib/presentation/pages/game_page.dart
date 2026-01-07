import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tic_tac_toe/injection/injection.dart';
import 'package:tic_tac_toe/presentation/bloc/game_bloc.dart';
import 'package:tic_tac_toe/presentation/bloc/game_event.dart';
import 'package:tic_tac_toe/presentation/bloc/game_state_bloc.dart';
import 'package:tic_tac_toe/presentation/widgets/game_board.dart';
import 'package:tic_tac_toe/presentation/widgets/game_status_bar.dart';

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<GameBloc>(),
      child: const _GamePageContent(),
    );
  }
}

class _GamePageContent extends StatelessWidget {
  const _GamePageContent();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tic Tac Toe'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              context.read<GameBloc>().add(const GameReset());
            },
            tooltip: 'New Game',
          ),
        ],
      ),
      body: SafeArea(
        child: BlocBuilder<GameBloc, GameBlocState>(
          builder: (context, state) {
            if (state is! GameInProgress) {
              return const Center(child: CircularProgressIndicator());
            }

            final gameState = state.gameState;
            final isGameOver = gameState.isGameOver;

            return Column(
              children: [
                const Spacer(),
                GameStatusBar(
                  status: gameState.status,
                  isAiThinking: state.isAiThinking,
                ),
                const SizedBox(height: 32),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: GameBoard(
                    board: gameState.board,
                    winningLine: gameState.winningLine,
                    isEnabled: !isGameOver && !state.isAiThinking,
                    onCellTap: (index) {
                      context.read<GameBloc>().add(CellTapped(index));
                    },
                  ),
                ),
                const Spacer(),
                if (isGameOver)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 32),
                    child: FilledButton.icon(
                      onPressed: () {
                        context.read<GameBloc>().add(const GameReset());
                      },
                      icon: const Icon(Icons.refresh),
                      label: const Text('Play Again'),
                    ),
                  ),
                const SizedBox(height: 16),
              ],
            );
          },
        ),
      ),
    );
  }
}
