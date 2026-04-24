// ignore_for_file: unused_import, unnecessary_import, unused_field, deprecated_member_use
// 🎨 Premium Welcome Screen - Futuristic Modern UI

import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:autonexa/core/constants/app_constants.dart';

class PremiumWelcomePage extends StatefulWidget {
  const PremiumWelcomePage({super.key});

  @override
  State<PremiumWelcomePage> createState() => _PremiumWelcomePageState();
}

class _PremiumWelcomePageState extends State<PremiumWelcomePage>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late AnimationController _particleController;
  late AnimationController _pulseController;

  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();

    // 🎬 Entrance Animation Controllers
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _slideController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _particleController = AnimationController(
      duration: const Duration(seconds: 10),
      vsync: this,
    )..repeat();

    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat(reverse: true);

    // 🎭 Animations
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeOut),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeOutCubic,
    ));

    _pulseAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    // Start animations sequentially
    _fadeController.forward();
    Future.delayed(const Duration(milliseconds: 500), () {
      _slideController.forward();
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    _particleController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 🌑 Dark Background
          _buildDarkBackground(),

          // ✨ Animated Particles
          _buildParticles(),

          // 🔺 Jordan Flag Abstract Shapes
          _buildJordanShapes(),

          // 🌟 Glassmorphism Content
          _buildGlassContent(),
        ],
      ),
    );
  }

  // 🎨 Dark Background with Gradient
  Widget _buildDarkBackground() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF0A0A0A),
            const Color(0xFF1A1A2E),
            const Color(0xFF0F0F1A),
            const Color(0xFF16213E),
          ],
        ),
      ),
    );
  }

  // ✨ Floating Particles
  Widget _buildParticles() {
    return AnimatedBuilder(
      animation: _particleController,
      builder: (context, child) {
        return CustomPaint(
          painter: ParticlePainter(
            progress: _particleController.value,
          ),
          size: Size.infinite,
        );
      },
    );
  }

  // 🔺 Jordan Flag Inspired Shapes
  Widget _buildJordanShapes() {
    return Stack(
      children: [
        // Red triangle accent (top-left)
        Positioned(
          top: -50,
          left: -50,
          child: Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  Colors.red.withOpacity(0.15),
                  Colors.red.withOpacity(0.0),
                ],
              ),
            ),
          ),
        ),

        // Green accent (bottom-right)
        Positioned(
          bottom: -30,
          right: -30,
          child: Container(
            width: 180,
            height: 180,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  const Color(0xFF00A86B).withOpacity(0.12),
                  const Color(0xFF00A86B).withOpacity(0.0),
                ],
              ),
            ),
          ),
        ),

        // White glow (center)
        Positioned.fill(
          child: Center(
            child: Container(
              width: 400,
              height: 400,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    Colors.white.withOpacity(0.03),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  // 🌟 Glassmorphism Content
  Widget _buildGlassContent() {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: SlideTransition(
        position: _slideAnimation,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // 🏆 App Name with Glow
              _buildAppName(),

              const SizedBox(height: 16),

              // 📝 Animated Subtitle
              _buildSubtitle(),

              const SizedBox(height: 60),

              // 🔘 Start Button
              _buildStartButton(),
            ],
          ),
        ),
      ),
    );
  }

  // 🏆 App Name with Neon Glow Effect
  Widget _buildAppName() {
    return ShaderMask(
      shaderCallback: (bounds) {
        return LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white,
            const Color(0xFFE8F5E9),
            const Color(0xFF00E676),
            Colors.white,
          ],
        ).createShader(bounds);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Text(
          'AUTONEXA',
          style: TextStyle(
            fontSize: 72,
            fontWeight: FontWeight.w900,
            letterSpacing: 8,
            color: Colors.white,
            shadows: [
              Shadow(
                color: Colors.black.withOpacity(0.8),
                blurRadius: 30,
                offset: const Offset(0, 8),
              ),
              Shadow(
                color: const Color(0xFF00E676).withOpacity(0.5),
                blurRadius: 40,
                offset: const Offset(0, 0),
              ),
              Shadow(
                color: Colors.white.withOpacity(0.3),
                blurRadius: 60,
                offset: const Offset(0, 0),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 📝 Animated Subtitle
  Widget _buildSubtitle() {
    return AnimatedBuilder(
      animation: _pulseController,
      builder: (context, child) {
        return Opacity(
          opacity: 0.6 + (_pulseAnimation.value * 0.4),
          child: Text(
            'AI-Powered Vehicle Damage Assessment',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w300,
              color: Colors.white.withOpacity(0.8),
              letterSpacing: 2,
              shadows: [
                Shadow(
                  color: const Color(0xFF00E676).withOpacity(0.3),
                  blurRadius: 20,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // 🔘 Start Button with Neon Glow
  Widget _buildStartButton() {
    return _NeonGlowButton(
      onTap: () => context.go('/car-info'),
    );
  }
}

// 🎯 Neon Glow Button Widget
class _NeonGlowButton extends StatefulWidget {
  final VoidCallback onTap;

  const _NeonGlowButton({required this.onTap});

  @override
  State<_NeonGlowButton> createState() => _NeonGlowButtonState();
}

class _NeonGlowButtonState extends State<_NeonGlowButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _glowAnimation;

  bool _isPressed = false;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _glowAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) {
          setState(() => _isPressed = false);
          widget.onTap();
        },
        onTapCancel: () => setState(() => _isPressed = false),
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            final scale = _isHovered ? 1.05 : 1.0;
            final glowIntensity = _isHovered ? 1.0 : 0.6;

            return Transform.scale(
              scale: _isPressed ? 0.95 : scale,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 60,
                  vertical: 18,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      const Color(0xFF00E676),
                      const Color(0xFF00C853),
                      const Color(0xFF00A86B),
                    ],
                  ),
                  boxShadow: [
                    // 💚 Neon Green Glow
                    BoxShadow(
                      color: const Color(0xFF00E676)
                          .withOpacity(0.6 * glowIntensity),
                      blurRadius: _isHovered ? 40 : 25,
                      spreadRadius: _isHovered ? 5 : 2,
                      offset: const Offset(0, 10),
                    ),
                    // Inner glow
                    BoxShadow(
                      color: Colors.white.withOpacity(0.3),
                      blurRadius: 15,
                      offset: const Offset(0, -5),
                    ),
                  ],
                ),
                child: Text(
                  'START',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 4,
                    shadows: [
                      Shadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

// 🎨 Particle Painter
class ParticlePainter extends CustomPainter {
  final double progress;
  final Random _random = Random(42);

  ParticlePainter({required this.progress});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill;

    // Draw floating particles
    for (int i = 0; i < 30; i++) {
      final baseX = _random.nextDouble() * size.width;
      final baseY = _random.nextDouble() * size.height;
      final speed = _random.nextDouble() * 0.5 + 0.5;

      // Calculate position with animation
      final x = (baseX + progress * size.width * speed) % size.width;
      final y = baseY + sin(progress * 2 * pi * speed) * 30;

      // Random particle properties
      final particleSize = _random.nextDouble() * 3 + 1;
      final opacity = _random.nextDouble() * 0.3 + 0.1;

      // Color based on Jordan flag colors
      final colors = [
        Colors.white.withOpacity(opacity),
        const Color(0xFF00E676).withOpacity(opacity * 0.7),
        Colors.red.withOpacity(opacity * 0.5),
      ];

      paint.color = colors[i % colors.length];

      canvas.drawCircle(Offset(x, y), particleSize, paint);
    }
  }

  @override
  bool shouldRepaint(ParticlePainter oldDelegate) {
    return progress != oldDelegate.progress;
  }
}