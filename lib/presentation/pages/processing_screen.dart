// ⚙️ Step 3: Processing Screen
// Shows AI analysis loading animation

// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProcessingScreen extends StatefulWidget {
  const ProcessingScreen({super.key});

  @override
  State<ProcessingScreen> createState() => _ProcessingScreenState();
}

class _ProcessingScreenState extends State<ProcessingScreen>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _rotateController;
  late AnimationController _progressController;

  late Animation<double> _pulseAnimation;
  late Animation<double> _progressAnimation;

  int _dotsCount = 0;
  Timer? _dotsTimer;

  @override
  void initState() {
    super.initState();

    // Pulse animation for the icon
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    // Rotate animation for the ring
    _rotateController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();

    // Progress animation
    _progressController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..forward();

    _progressAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _progressController, curve: Curves.easeOut),
    );

    // Animated dots timer
    _dotsTimer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      setState(() {
        _dotsCount = (_dotsCount + 1) % 4;
      });
    });

    // Navigate to results after delay
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        context.go('/results');
      }
    });
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _rotateController.dispose();
    _progressController.dispose();
    _dotsTimer?.cancel();
    super.dispose();
  }

  String get _loadingText {
    switch (_dotsCount) {
      case 0:
        return 'Analyzing damage';
      case 1:
        return 'Analyzing damage.';
      case 2:
        return 'Analyzing damage..';
      case 3:
        return 'Analyzing damage...';
      default:
        return 'Analyzing damage';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A2E),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.go('/damage-capture'),
        ),
        title: const Text(
          'Analyzing',
          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              // Navigate to Dashboard using GoRouter
              context.go('/enterprise-dashboard');
            },
            child: const Text(
              'Skip',
              style: TextStyle(
                color: Color(0xFF00E676),
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const Spacer(),

              // 🔄 Animated Icon
              _buildAnimatedIcon(),

              const SizedBox(height: 48),

              // 📝 Loading Text
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 200),
                child: Text(
                  _loadingText,
                  key: ValueKey(_dotsCount),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // 📊 Progress Bar
              _buildProgressBar(),

              const SizedBox(height: 24),

              // 📋 Status Messages
              _buildStatusMessages(),

              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedIcon() {
    return SizedBox(
      width: 120,
      height: 120,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Outer rotating ring
          AnimatedBuilder(
            animation: _rotateController,
            builder: (context, child) {
              return Transform.rotate(
                angle: _rotateController.value * 2 * 3.14159,
                child: CustomPaint(
                  size: const Size(120, 120),
                  painter: _RingPainter(
                    color: const Color(0xFF00E676).withOpacity(0.3),
                  ),
                ),
              );
            },
          ),

          // Inner pulsing icon
          ScaleTransition(
            scale: _pulseAnimation,
            child: Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: const Color(0xFF00E676).withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.analytics,
                color: Color(0xFF00E676),
                size: 48,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressBar() {
    return Column(
      children: [
        // Progress bar background
        Container(
          height: 6,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(3),
          ),
        ),
        const SizedBox(height: 8),

        // Progress percentage
        AnimatedBuilder(
          animation: _progressAnimation,
          builder: (context, child) {
            return Text(
              '${(_progressAnimation.value * 100).toInt()}%',
              style: const TextStyle(
                color: Colors.white54,
                fontSize: 14,
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildStatusMessages() {
    final List<_StatusItem> statuses = [
      _StatusItem(
        icon: Icons.image,
        text: 'Processing image',
        isComplete: _progressAnimation.value > 0.2,
      ),
      _StatusItem(
        icon: Icons.search,
        text: 'Detecting damage',
        isComplete: _progressAnimation.value > 0.5,
      ),
      _StatusItem(
        icon: Icons.assessment,
        text: 'Analyzing severity',
        isComplete: _progressAnimation.value > 0.7,
      ),
      _StatusItem(
        icon: Icons.recommend,
        text: 'Generating report',
        isComplete: _progressAnimation.value > 0.9,
      ),
    ];

    return Column(
      children: statuses.map((status) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                child: Icon(
                  status.isComplete ? Icons.check_circle : Icons.circle,
                  color: status.isComplete
                      ? const Color(0xFF00E676)
                      : Colors.white30,
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                status.text,
                style: TextStyle(
                  color: status.isComplete ? Colors.white : Colors.white38,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}

class _StatusItem {
  final IconData icon;
  final String text;
  final bool isComplete;

  _StatusItem({
    required this.icon,
    required this.text,
    required this.isComplete,
  });
}

// 🎨 Custom Ring Painter
class _RingPainter extends CustomPainter {
  final Color color;

  _RingPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 10;

    // Draw dashed circle
    const dashCount = 30;
    const dashAngle = (2 * 3.14159) / dashCount;

    for (int i = 0; i < dashCount; i++) {
      final startAngle = i * dashAngle;
      final sweepAngle = dashAngle * 0.6;

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(_RingPainter oldDelegate) {
    return color != oldDelegate.color;
  }
}