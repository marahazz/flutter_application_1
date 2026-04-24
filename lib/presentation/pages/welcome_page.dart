// ignore_for_file: unused_element, deprecated_member_use

import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:autonexa/l10n/app_localizations.dart';

import 'package:autonexa/core/constants/app_constants.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> with TickerProviderStateMixin {
  late final AnimationController _intro;
  late final AnimationController _bg;

  late final Animation<double> _fade;
  late final Animation<Offset> _slide;

  bool _hovered = false;
  bool _pressed = false;

  @override
  void initState() {
    super.initState();
    _intro = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 850),
    );
    _bg = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();

    _fade = CurvedAnimation(parent: _intro, curve: Curves.easeOutCubic);
    _slide = Tween<Offset>(
      begin: const Offset(0, 0.06),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _intro, curve: Curves.easeOutCubic));

    _intro.forward();
  }

  @override
  void dispose() {
    _intro.dispose();
    _bg.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final contentMaxW = size.width >= 980 ? 720.0 : 560.0;

    final glowT = _hovered ? 1.0 : 0.65;
    final scale = _pressed ? 0.992 : (_hovered ? 1.015 : 1.0);
    final pressYOffset = _pressed ? 1.5 : 0.0;

    return Scaffold(
      body: Stack(
        children: [
          // Modern Jordan-flag layout (bands + red triangle), with subtle motion.
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _bg,
              builder: (context, _) {
                return CustomPaint(
                  painter: _JordanModernBackgroundPainter(t: _bg.value),
                  child: const SizedBox.expand(),
                );
              },
            ),
          ),

          // Content
          SafeArea(
            child: FadeTransition(
              opacity: _fade,
              child: SlideTransition(
                position: _slide,
                child: Stack(
                  children: [
                    // Center content anchored to middle (white band)
                    Center(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: contentMaxW),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: _GlassPanel(
                            tint: const Color(0xFF111827).withValues(alpha: 0.06),
                            borderColor:
                                const Color(0xFFCE1126).withValues(alpha: 0.14),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 22,
                                vertical: 20,
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    AppLocalizations.of(context)!.appName,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: const Color(0xFF0B0B0C)
                                          .withValues(alpha: 0.92),
                                      fontSize: 52,
                                      height: 1.02,
                                      fontWeight: FontWeight.w900,
                                      letterSpacing: 2.4,
                                      shadows: [
                                        Shadow(
                                          color: const Color(0xFF000000)
                                              .withValues(alpha: 0.14),
                                          blurRadius: 22,
                                          offset: const Offset(0, 10),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  AnimatedBuilder(
                                    animation: _bg,
                                    builder: (context, _) {
                                      final pulse =
                                          0.65 + 0.35 * sin(_bg.value * pi * 2);
                                      return Opacity(
                                        opacity: 0.78 + 0.18 * pulse,
                                        child: Text(
                                          AppLocalizations.of(context)!.tagline,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color: const Color(0xFF111827)
                                                .withValues(alpha: 0.74),
                                            fontSize: 14.5,
                                            height: 1.3,
                                            fontWeight: FontWeight.w700,
                                            letterSpacing: 0.25,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Bottom-center Start button
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 20, 20, 28),
                        child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          onEnter: (_) => setState(() => _hovered = true),
                          onExit: (_) => setState(() => _hovered = false),
                          child: GestureDetector(
                            onTapDown: (_) => setState(() => _pressed = true),
                            onTapCancel: () => setState(() => _pressed = false),
                            onTapUp: (_) => setState(() => _pressed = false),
                            onTap: () => context.go(AppRoutes.customerHome),
                            child: AnimatedScale(
                              duration: const Duration(milliseconds: 200),
                              curve: Curves.easeInOut,
                              scale: scale,
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 200),
                                curve: Curves.easeInOut,
                                transform:
                                    Matrix4.translationValues(0, pressYOffset, 0),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 38,
                                  vertical: 16,
                                ),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(999),
                                  gradient: const LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.centerRight,
                                    colors: [
                                      Color(0xFFCE1126), // red
                                      Color(0xFF007A3D), // green
                                    ],
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: const Color(0xFFCE1126)
                                          .withValues(alpha: 0.30 * glowT),
                                      blurRadius: _hovered ? 44 : 28,
                                      offset: const Offset(0, 16),
                                    ),
                                    BoxShadow(
                                      color: const Color(0xFF007A3D)
                                          .withValues(alpha: 0.22 * glowT),
                                      blurRadius: _hovered ? 54 : 32,
                                      offset: const Offset(0, 18),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(
                                      Icons.play_arrow_rounded,
                                      size: 20,
                                      color: Colors.white.withValues(alpha: 0.96),
                                    ),
                                    const SizedBox(width: 10),
                                    Text(
                                      AppLocalizations.of(context)!.start,
                                      style: TextStyle(
                                        color: Colors.white.withValues(alpha: 0.98),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w900,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _GlassPanel extends StatelessWidget {
  const _GlassPanel({
    required this.child,
    this.tint,
    this.borderColor,
  });

  final Widget child;
  final Color? tint;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(26),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: (tint ?? const Color(0xFFFFFFFF).withValues(alpha: 0.055)),
            borderRadius: BorderRadius.circular(26),
            border: Border.all(
              color: (borderColor ??
                  const Color(0xFF93C5FD).withValues(alpha: 0.10)),
              width: 1,
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}

class _JordanClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final p = Path();
    p.moveTo(0, 0);
    p.lineTo(size.width * .9, size.height * .2);
    p.lineTo(size.width * .7, size.height * .7);
    p.lineTo(0, size.height);
    p.close();
    return p;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class _JordanModernBackgroundPainter extends CustomPainter {
  _JordanModernBackgroundPainter({required this.t});
  final double t;

  @override
  void paint(Canvas canvas, Size size) {
    final topH = size.height / 3;
    final midH = size.height / 3;
    final botH = size.height - topH - midH;

    // Band gradients (clean, premium—still clearly black/white/green)
    final topRect = Rect.fromLTWH(0, 0, size.width, topH);
    final midRect = Rect.fromLTWH(0, topH, size.width, midH);
    final botRect = Rect.fromLTWH(0, topH + midH, size.width, botH);

    final topPaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFF05060B), Color(0xFF0A0D16)],
      ).createShader(topRect);
    canvas.drawRect(topRect, topPaint);

    final midPaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Color(0xFFF8FAFC), Color(0xFFEFF3F7)],
      ).createShader(midRect);
    canvas.drawRect(midRect, midPaint);

    final botPaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [Color(0xFF0B5F3A), Color(0xFF007A3D)],
      ).createShader(botRect);
    canvas.drawRect(botRect, botPaint);

    // Red triangle (left)
    final triW = min(size.width * 0.42, 420.0);
    final triPath = Path()
      ..moveTo(0, 0)
      ..lineTo(triW, size.height / 2)
      ..lineTo(0, size.height)
      ..close();

    // subtle animated sheen across triangle
    final shift = (sin(t * pi * 2) * 0.5 + 0.5);
    final triRect = Rect.fromLTWH(0, 0, triW, size.height);
    final triPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomLeft,
        colors: const [
          Color(0xFFCE1126),
          Color(0xFFB80F22),
          Color(0xFFCE1126),
        ],
        stops: [0.0, 0.55 + 0.10 * shift, 1.0],
      ).createShader(triRect);
    canvas.drawPath(triPath, triPaint);

    // soft glow edge for depth
    final glow = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..color = const Color(0xFFFFFFFF).withValues(alpha: 0.08);
    canvas.drawPath(triPath, glow);

    // 7-point star inside triangle (subtle)
    final starCenter = Offset(triW * 0.33, size.height * 0.50);
    final starOuter = min(28.0, min(size.width, size.height) * 0.05);
    final starInner = starOuter * 0.46;
    final starPath = _sevenPointStarPath(
      center: starCenter,
      outerRadius: starOuter,
      innerRadius: starInner,
      rotation: -pi / 2,
    );

    // star glow
    final starGlow = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6
      ..color = const Color(0xFFFFFFFF).withValues(alpha: 0.08);
    canvas.drawPath(starPath, starGlow);

    final starFill = Paint()
      ..style = PaintingStyle.fill
      ..color = const Color(0xFFFFFFFF).withValues(alpha: 0.22);
    canvas.drawPath(starPath, starFill);

    // Optional particles (very light)
    final rnd = Random(9);
    for (var i = 0; i < 22; i++) {
      final x = rnd.nextDouble() * size.width;
      final y = rnd.nextDouble() * size.height;
      final speed = 0.12 + rnd.nextDouble() * 0.30;
      final phase = rnd.nextDouble() * pi * 2;
      final dx = sin((t * pi * 2 * speed) + phase) * 8;
      final dy = cos((t * pi * 2 * speed) + phase) * 6;
      final r = 0.8 + rnd.nextDouble() * 1.6;

      final cPick = rnd.nextDouble();
      final c = cPick < 0.5
          ? const Color(0xFFFFFFFF)
          : (cPick < 0.75 ? const Color(0xFFCE1126) : const Color(0xFF007A3D));

      final p = Paint()..color = c.withValues(alpha: 0.04);
      canvas.drawCircle(Offset(x + dx, y + dy), r, p);
    }
  }

  Path _sevenPointStarPath({
    required Offset center,
    required double outerRadius,
    required double innerRadius,
    required double rotation,
  }) {
    const points = 7;
    final path = Path();
    for (var i = 0; i < points * 2; i++) {
      final isOuter = i.isEven;
      final r = isOuter ? outerRadius : innerRadius;
      final ang = rotation + (i * pi) / points;
      final p = Offset(center.dx + cos(ang) * r, center.dy + sin(ang) * r);
      if (i == 0) {
        path.moveTo(p.dx, p.dy);
      } else {
        path.lineTo(p.dx, p.dy);
      }
    }
    path.close();
    return path;
  }

  @override
  bool shouldRepaint(covariant _JordanModernBackgroundPainter oldDelegate) =>
      oldDelegate.t != t;
}
