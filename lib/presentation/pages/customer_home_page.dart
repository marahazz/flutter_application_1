// ignore_for_file: unnecessary_import, deprecated_member_use

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomerHomePage extends StatefulWidget {
  const CustomerHomePage({super.key});

  @override
  State<CustomerHomePage> createState() => _CustomerHomePageState();
}

class _CustomerHomePageState extends State<CustomerHomePage>
    with TickerProviderStateMixin {
  String _activeAction = '';
  late final AnimationController _introController;
  late final AnimationController _scanLineController;
  late final List<Animation<double>> _fadeAnims;
  late final List<Animation<Offset>> _slideAnims;
  late final Animation<double> _scanLine;

  final List<_FeatureAction> _featureActions = [
    _FeatureAction(
      icon: Icons.qr_code_scanner,
      title: 'Scan Vehicle',
      description: 'Upload or capture a damage image',
      route: '/scan',
    ),
    _FeatureAction(
      icon: Icons.analytics,
      title: 'AI Damage Detection',
      description: 'Analyze vehicle damage instantly',
      route: '/ai-damage',
    ),
    _FeatureAction(
      icon: Icons.build_circle,
      title: 'Repair Cost Estimate',
      description: 'Get smart repair pricing',
      route: '/cost-estimate',
    ),
  ];

  @override
  void initState() {
    super.initState();

    _introController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _scanLineController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat(reverse: false);

    _scanLine = Tween<double>(begin: -0.2, end: 1.2).animate(
      CurvedAnimation(parent: _scanLineController, curve: Curves.easeInOut),
    );

    _fadeAnims = List.generate(_featureActions.length, (index) {
      final start = 0.15 + index * 0.12;
      final end = start + 0.45;
      return CurvedAnimation(
        parent: _introController,
        curve: Interval(start, end, curve: Curves.easeOut),
      );
    });

    _slideAnims = List.generate(_featureActions.length, (index) {
      final start = 0.15 + index * 0.12;
      final end = start + 0.45;
      return Tween<Offset>(
        begin: const Offset(0, 0.16),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(
          parent: _introController,
          curve: Interval(start, end, curve: Curves.easeOut),
        ),
      );
    });

    _introController.forward();
  }

  @override
  void dispose() {
    _introController.dispose();
    _scanLineController.dispose();
    super.dispose();
  }

  Widget _buildFeatureCard(int index, _FeatureAction action) {
    final bool isActive = _activeAction == action.title;
    final Color cardColor = Colors.white.withOpacity(isActive ? 0.22 : 0.11);
    final double scale = isActive ? 0.98 : 1.0;
    final BoxShadow fwdShadow = BoxShadow(
      color: isActive
          ? Colors.cyanAccent.withOpacity(0.28)
          : Colors.black.withOpacity(0.22),
      blurRadius: isActive ? 22 : 14,
      offset: const Offset(0, 8),
    );

    return FadeTransition(
      opacity: _fadeAnims[index],
      child: SlideTransition(
        position: _slideAnims[index],
        child: GestureDetector(
          onTapDown: (_) => setState(() => _activeAction = action.title),
          onTapUp: (_) => setState(() => _activeAction = ''),
          onTapCancel: () => setState(() => _activeAction = ''),
          onTap: () => context.go(action.route),
          child: AnimatedScale(
            duration: const Duration(milliseconds: 180),
            scale: scale,
            curve: Curves.easeOut,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              margin: const EdgeInsets.symmetric(vertical: 8),
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(21),
                border: Border.all(
                  color: Colors.white.withOpacity(0.14),
                  width: 0.4,
                ),
                boxShadow: [fwdShadow],
                backgroundBlendMode: BlendMode.overlay,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 52,
                    width: 52,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.19),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Icon(
                      action.icon,
                      color: Colors.cyanAccent.shade100,
                      size: 32,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          action.title,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.95),
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          action.description,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.70),
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios,
                    size: 16,
                    color: Colors.white70,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          // Cinematic dark charcoal gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFF111214),
                  Color(0xFF191B1D),
                  Color(0xFF232628),
                  Color(0xFF1B1D20),
                ],
              ),
            ),
          ),

          // depth blur accents
          Positioned(
            left: -80,
            top: -90,
            child: Container(
              height: 220,
              width: 220,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    Color(0xFF3E4C57).withOpacity(0.20),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            right: -70,
            bottom: -90,
            child: Container(
              height: 200,
              width: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    Color(0xFF2A2F33).withOpacity(0.24),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          // Tech grid overlay
          Positioned.fill(
            child: IgnorePointer(
              child: CustomPaint(
                painter: _TechGridPainter(),
                child: const SizedBox.expand(),
              ),
            ),
          ),

          // Wireframe car silhouette
          Positioned(
            top: size.height * 0.12,
            left: size.width * 0.05,
            right: size.width * 0.05,
            child: Opacity(
              opacity: 0.08,
              child: CustomPaint(
                size: Size(size.width * 0.9, 160),
                painter: _WireframeCarPainter(),
              ),
            ),
          ),

          // scanning pulse line
          AnimatedBuilder(
            animation: _scanLine,
            builder: (context, child) {
              final topOffset =
                  size.height * 0.24 + _scanLine.value * (size.height * 0.32);
              return Positioned(
                top: topOffset,
                left: 16,
                right: 16,
                child: Container(
                  height: 2,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xFF8FC7D6).withOpacity(0.0),
                        const Color(0xFF8FC7D6).withOpacity(0.30),
                        const Color(0xFF8FC7D6).withOpacity(0.0),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),

          // Content
          Positioned.fill(
            child: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 24),
                child: Center(
                  child: Container(
                    constraints: const BoxConstraints(maxWidth: 520),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 24,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(height: 42),
                        const Text(
                          'Welcome Back',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 34,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.8,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Smart Vehicle Analysis',
                          style: TextStyle(
                            color: Colors.cyanAccent.withOpacity(0.9),
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Choose your next action',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.68),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.2,
                          ),
                        ),
                        const SizedBox(height: 26),
                        ...List.generate(
                          _featureActions.length,
                          (index) =>
                              _buildFeatureCard(index, _featureActions[index]),
                        ),
                        const SizedBox(height: 18),
                        // Scan History Button
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white.withOpacity(0.10),
                              foregroundColor: Colors.cyanAccent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              elevation: 0,
                            ),
                            icon: const Icon(
                              Icons.history,
                              color: Colors.cyanAccent,
                            ),
                            label: const Text(
                              'View Scan History',
                              style: TextStyle(
                                color: Colors.cyanAccent,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            onPressed: () => context.go('/customer/history'),
                          ),
                        ),
                        const SizedBox(height: 18),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white.withOpacity(0.10),
                              foregroundColor: Colors.cyanAccent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              elevation: 0,
                            ),
                            icon: const Icon(
                              Icons.chat,
                              color: Colors.cyanAccent,
                            ),
                            label: const Text(
                              'AI Chat Assistant',
                              style: TextStyle(
                                color: Colors.cyanAccent,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            onPressed: () => context.go('/ai-chat'),
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white.withOpacity(0.10),
                              foregroundColor: Colors.cyanAccent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              elevation: 0,
                            ),
                            icon: const Icon(
                              Icons.compare_arrows,
                              color: Colors.cyanAccent,
                            ),
                            label: const Text(
                              'Compare Workshops',
                              style: TextStyle(
                                color: Colors.cyanAccent,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            onPressed: () => context.go('/workshop-comparison'),
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white.withOpacity(0.10),
                              foregroundColor: Colors.cyanAccent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              elevation: 0,
                            ),
                            icon: const Icon(
                              Icons.reviews,
                              color: Colors.cyanAccent,
                            ),
                            label: const Text(
                              'Workshop Reviews',
                              style: TextStyle(
                                color: Colors.cyanAccent,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            onPressed: () => context.go('/workshop-reviews'),
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white.withOpacity(0.10),
                              foregroundColor: Colors.cyanAccent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              elevation: 0,
                            ),
                            icon: const Icon(
                              Icons.calendar_month,
                              color: Colors.cyanAccent,
                            ),
                            label: const Text(
                              'Book Appointment',
                              style: TextStyle(
                                color: Colors.cyanAccent,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            onPressed: () => context.go('/book-appointment'),
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white.withOpacity(0.10),
                              foregroundColor: Colors.cyanAccent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              elevation: 0,
                            ),
                            icon: const Icon(
                              Icons.picture_as_pdf,
                              color: Colors.cyanAccent,
                            ),
                            label: const Text(
                              'Export/Share Report',
                              style: TextStyle(
                                color: Colors.cyanAccent,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            onPressed: () => context.go('/export-report'),
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white.withOpacity(0.10),
                              foregroundColor: Colors.cyanAccent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              elevation: 0,
                            ),
                            icon: const Icon(
                              Icons.settings,
                              color: Colors.cyanAccent,
                            ),
                            label: const Text(
                              'Settings',
                              style: TextStyle(
                                color: Colors.cyanAccent,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            onPressed: () => context.go('/settings'),
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white.withOpacity(0.10),
                              foregroundColor: Colors.cyanAccent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              elevation: 0,
                            ),
                            icon: const Icon(
                              Icons.dashboard,
                              color: Colors.cyanAccent,
                            ),
                            label: const Text(
                              'Workshop Dashboard',
                              style: TextStyle(
                                color: Colors.cyanAccent,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            onPressed: () => context.go('/workshop-dashboard'),
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white.withOpacity(0.10),
                              foregroundColor: Colors.cyanAccent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              elevation: 0,
                            ),
                            icon: const Icon(
                              Icons.analytics,
                              color: Colors.cyanAccent,
                            ),
                            label: const Text(
                              'Predictive Intelligence',
                              style: TextStyle(
                                color: Colors.cyanAccent,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            onPressed: () =>
                                context.go('/predictive-intelligence'),
                          ),
                        ),
                        const SizedBox(height: 28),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _FeatureAction {
  final IconData icon;
  final String title;
  final String description;
  final String route;

  _FeatureAction({
    required this.icon,
    required this.title,
    required this.description,
    required this.route,
  });
}

class _TechGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.35
      ..color = Colors.white.withOpacity(0.05);

    const step = 24.0;
    for (var x = 0.0; x <= size.width; x += step) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (var y = 0.0; y <= size.height; y += step) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }

    final diagPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.5
      ..color = const Color(0xFF9CA7B0).withOpacity(0.05);
    canvas.drawLine(
      const Offset(0, 0),
      Offset(size.width, size.height),
      diagPaint,
    );
    canvas.drawLine(Offset(size.width, 0), Offset(0, size.height), diagPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _WireframeCarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0
      ..color = Colors.white.withOpacity(0.14);

    final path = Path()
      ..moveTo(size.width * 0.08, size.height * 0.65)
      ..quadraticBezierTo(
        size.width * 0.2,
        size.height * 0.35,
        size.width * 0.38,
        size.height * 0.34,
      )
      ..quadraticBezierTo(
        size.width * 0.58,
        size.height * 0.33,
        size.width * 0.72,
        size.height * 0.48,
      )
      ..quadraticBezierTo(
        size.width * 0.86,
        size.height * 0.65,
        size.width * 0.92,
        size.height * 0.68,
      )
      ..lineTo(size.width * 0.78, size.height * 0.7)
      ..lineTo(size.width * 0.72, size.height * 0.57)
      ..quadraticBezierTo(
        size.width * 0.62,
        size.height * 0.47,
        size.width * 0.38,
        size.height * 0.48,
      )
      ..lineTo(size.width * 0.22, size.height * 0.62)
      ..close();

    canvas.drawPath(path, paint);

    final markerPaint = Paint()
      ..style = PaintingStyle.fill
      ..color = Colors.cyanAccent.withOpacity(0.12);

    canvas.drawCircle(
      Offset(size.width * 0.26, size.height * 0.52),
      3.25,
      markerPaint,
    );
    canvas.drawCircle(
      Offset(size.width * 0.65, size.height * 0.54),
      3.1,
      markerPaint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
