import 'dart:math';
import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';

class AmbientBackground extends StatefulWidget {
  const AmbientBackground({super.key});

  @override
  State<AmbientBackground> createState() => _AmbientBackgroundState();
}

class _AmbientBackgroundState extends State<AmbientBackground> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return CustomPaint(
          painter: _AmbientPainter(_controller.value),
          size: Size.infinite,
        );
      },
    );
  }
}

class _AmbientPainter extends CustomPainter {
  final double progress;

  _AmbientPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    if (size.width == 0 || size.height == 0) return;

    final paint = Paint()
      ..color = AppColors.cyan.withOpacity(0.05)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    final paint2 = Paint()
      ..color = AppColors.jade.withOpacity(0.03)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3.0;

    _drawFlowingPath(canvas, size, paint, progress, 1.0);
    _drawFlowingPath(canvas, size, paint2, 1 - progress, 1.5);
  }

  void _drawFlowingPath(Canvas canvas, Size size, Paint paint, double progress, double amplitudeMultiplier) {
    final path = Path();
    final yOffset = size.height * 0.5;
    
    path.moveTo(0, yOffset);

    for (double i = 0; i < size.width; i += 10) {
      final double xProgress = i / size.width;
      // Combine multiple sine waves for a flowing "energy" feel (Cultivation/Donghua vibe)
      final sine1 = sin(xProgress * pi * 4 + progress * pi * 2);
      final sine2 = cos(xProgress * pi * 2 - progress * pi * 4);
      final y = yOffset + (sine1 + sine2) * 50 * amplitudeMultiplier;
      path.lineTo(i, y);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _AmbientPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
