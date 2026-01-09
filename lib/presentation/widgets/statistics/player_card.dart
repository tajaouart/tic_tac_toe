import 'package:flutter/material.dart';

/// Card widget displaying player profile information.
class PlayerCard extends StatelessWidget {
  final String playerName;

  const PlayerCard({
    super.key,
    required this.playerName,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            _PlayerAvatar(playerName: playerName),
            const SizedBox(width: 16),
            Expanded(
              child: _PlayerInfo(playerName: playerName),
            ),
          ],
        ),
      ),
    );
  }
}

class _PlayerAvatar extends StatelessWidget {
  final String playerName;

  const _PlayerAvatar({required this.playerName});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 32,
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      child: Text(
        playerName.isNotEmpty ? playerName[0].toUpperCase() : 'P',
        style: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }
}

class _PlayerInfo extends StatelessWidget {
  final String playerName;

  const _PlayerInfo({required this.playerName});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          playerName,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        Text(
          'Tic Tac Toe Champion',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).colorScheme.outline,
              ),
        ),
      ],
    );
  }
}
