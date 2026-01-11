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
  late Animation<double> _scanAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _updateAnimation();

    if (widget.isAiThinking && widget.player == Player.none) {
      _controller.repeat();
    }
  }

  void _updateAnimation() {
    // Calculate when this cell should be highlighted in the scan sequence
    final totalCells = widget.totalEmptyCells.clamp(1, 9);
    final cellDuration = 1.0 / totalCells;
    final startTime = widget.scanIndex * cellDuration;
    final endTime = (startTime + cellDuration).clamp(0.0, 1.0);

    // Build tween sequence with proper weights (must be > 0)
    final List<TweenSequenceItem<double>> items = [];

    // Pre-highlight delay
    if (startTime > 0.001) {
      items.add(TweenSequenceItem(
        tween: Tween<double>(begin: 0.0, end: 0.0),
        weight: startTime * 100,
      ));
    }

    // Fade in
    items.add(TweenSequenceItem(
      tween: Tween<double>(begin: 0.0, end: 1.0)
          .chain(CurveTween(curve: Curves.easeOut)),
      weight: (cellDuration / 2) * 100,
    ));

    // Fade out
    items.add(TweenSequenceItem(
      tween: Tween<double>(begin: 1.0, end: 0.0)
          .chain(CurveTween(curve: Curves.easeIn)),
      weight: (cellDuration / 2) * 100,
    ));

    // Post-highlight delay
    final remaining = 1.0 - endTime;
    if (remaining > 0.001) {
      items.add(TweenSequenceItem(
        tween: Tween<double>(begin: 0.0, end: 0.0),
        weight: remaining * 100,
      ));
    }

    _scanAnimation = TweenSequence<double>(items).animate(_controller);
  }

  @override
  void didUpdateWidget(GameCell oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.scanIndex != oldWidget.scanIndex ||
        widget.totalEmptyCells != oldWidget.totalEmptyCells) {
      _updateAnimation();
    }

    if (widget.isAiThinking && widget.player == Player.none) {
      if (!_controller.isAnimating) {
        _controller.repeat();
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
    final bool showScanAnimation =
        widget.isAiThinking && widget.player == Player.none;

    return GestureDetector(
      onTap: widget.isEnabled ? widget.onTap : null,
      child: AnimatedBuilder(
        animation: _scanAnimation,
        builder: (context, child) {
          final scanValue = showScanAnimation ? _scanAnimation.value : 0.0;

          return AnimatedContainer(
            duration: const Duration(
              milliseconds: AppConstants.defaultAnimationDuration,
            ),
            decoration: BoxDecoration(
              color: widget.isWinningCell
                  ? colorScheme.primaryContainer
                  : Color.lerp(
                      colorScheme.surface,
                      colorScheme.primary.withValues(alpha: 0.3),
                      scanValue,
                    ),
              borderRadius: BorderRadius.circular(AppConstants.cellBorderRadius),
              border: Border.all(
                color: Color.lerp(
                  colorScheme.outline.withValues(alpha: 0.3),
                  colorScheme.primary,
                  scanValue,
                )!,
                width: AppConstants.cellBorderWidth + (scanValue * 1.5),
              ),
              boxShadow: scanValue > 0
                  ? [
                      BoxShadow(
                        color: colorScheme.primary.withValues(alpha: scanValue * 0.4),
                        blurRadius: 12 * scanValue,
                        spreadRadius: 2 * scanValue,
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
