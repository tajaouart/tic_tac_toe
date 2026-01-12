import 'package:flutter/material.dart';
import 'package:tic_tac_toe/core/constants/app_constants.dart';
import 'package:tic_tac_toe/domain/entities/player.dart';

/// Widget representing a single cell in the game board.
class GameCell extends StatefulWidget {
  final Player player;
  final VoidCallback onTap;
  final bool isWinningCell;
  final bool isEnabled;
  final bool isAiThinking;
  final int scanIndex;
  final int totalEmptyCells;

  const GameCell({
    super.key,
    required this.player,
    required this.onTap,
    this.isWinningCell = false,
    this.isEnabled = true,
    this.isAiThinking = false,
    this.scanIndex = 0,
    this.totalEmptyCells = 1,
  });

  @override
  State<GameCell> createState() => _GameCellState();
}

class _GameCellState extends State<GameCell> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    // Simple pulse animation - all cells together
    _pulseAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    if (widget.isAiThinking && widget.player == Player.none) {
      _controller.repeat(reverse: true);
    }
  }

  @override
  void didUpdateWidget(GameCell oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.isAiThinking && widget.player == Player.none) {
      if (!_controller.isAnimating) {
        _controller.repeat(reverse: true);
      }
    } else {
      _controller.stop();
      _controller.reset();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final bool showPulseAnimation =
        widget.isAiThinking && widget.player == Player.none;

    return GestureDetector(
      onTap: widget.isEnabled ? widget.onTap : null,
      child: AnimatedBuilder(
        animation: _pulseAnimation,
        builder: (context, child) {
          final pulseValue = showPulseAnimation ? _pulseAnimation.value : 0.0;

          return AnimatedContainer(
            duration: const Duration(
              milliseconds: AppConstants.defaultAnimationDuration,
            ),
            decoration: BoxDecoration(
              color: widget.isWinningCell
                  ? colorScheme.primaryContainer
                  : Color.lerp(
                      colorScheme.surface,
                      colorScheme.primary.withValues(alpha: 0.15),
                      pulseValue,
                    ),
              borderRadius: BorderRadius.circular(AppConstants.cellBorderRadius),
              border: Border.all(
                color: Color.lerp(
                  colorScheme.outline.withValues(alpha: 0.3),
                  colorScheme.primary.withValues(alpha: 0.6),
                  pulseValue,
                )!,
                width: AppConstants.cellBorderWidth + (pulseValue * 1.0),
              ),
              boxShadow: pulseValue > 0
                  ? [
                      BoxShadow(
                        color: colorScheme.primary.withValues(alpha: pulseValue * 0.2),
                        blurRadius: 8 * pulseValue,
                        spreadRadius: 1 * pulseValue,
                      ),
                    ]
                  : null,
            ),
            child: child,
          );
        },
        child: Center(
          child: AnimatedSwitcher(
            duration: const Duration(
              milliseconds: AppConstants.defaultAnimationDuration,
            ),
            child: widget.player != Player.none
                ? _PlayerSymbol(player: widget.player)
                : const SizedBox.shrink(),
          ),
        ),
      ),
    );
  }
}

class _PlayerSymbol extends StatelessWidget {
  final Player player;

  const _PlayerSymbol({required this.player});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return LayoutBuilder(
      builder: (context, constraints) {
        final size = constraints.maxWidth * 0.6;
        return SizedBox(
          width: size,
          height: size,
          child: CustomPaint(
            key: ValueKey(player),
            painter: player == Player.x
                ? _XPainter(color: colorScheme.primary)
                : _OPainter(color: colorScheme.secondary),
          ),
        );
      },
    );
  }
}

/// Custom painter for beautiful X symbol
class _XPainter extends CustomPainter {
  final Color color;

  _XPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = size.width * 0.15
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    // Add shadow
    final shadowPaint = Paint()
      ..color = color.withValues(alpha: 0.3)
      ..strokeWidth = size.width * 0.15
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);

    final padding = size.width * 0.1;

    // Draw shadow first
    canvas.drawLine(
      Offset(padding + 2, padding + 2),
      Offset(size.width - padding + 2, size.height - padding + 2),
      shadowPaint,
    );
    canvas.drawLine(
      Offset(size.width - padding + 2, padding + 2),
      Offset(padding + 2, size.height - padding + 2),
      shadowPaint,
    );

    // Draw X lines
    canvas.drawLine(
      Offset(padding, padding),
      Offset(size.width - padding, size.height - padding),
      paint,
    );
    canvas.drawLine(
      Offset(size.width - padding, padding),
      Offset(padding, size.height - padding),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant _XPainter oldDelegate) {
    return oldDelegate.color != color;
  }
}

/// Custom painter for beautiful O symbol
class _OPainter extends CustomPainter {
  final Color color;

  _OPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width / 2) * 0.85;
    final strokeWidth = size.width * 0.15;

    // Add shadow
    final shadowPaint = Paint()
      ..color = color.withValues(alpha: 0.3)
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);

    canvas.drawCircle(
      Offset(center.dx + 2, center.dy + 2),
      radius - strokeWidth / 2,
      shadowPaint,
    );

    // Draw circle
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius - strokeWidth / 2, paint);
  }

  @override
  bool shouldRepaint(covariant _OPainter oldDelegate) {
    return oldDelegate.color != color;
  }
}
