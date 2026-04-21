// ignore_for_file: deprecated_member_use, unnecessary_import

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({super.key});

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> with TickerProviderStateMixin {
  late final AnimationController _pulseController;
  late final Animation<double> _pulse;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    _pulse = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF111417),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Vehicle Scan', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.pop(),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: _pulse,
              builder: (context, child) {
                return Transform.scale(
                  scale: _pulse.value,
                  child: Container(
                    width: 200,
                    height: 200,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          const Color(0xFF00FFE0).withOpacity(0.3),
                          Colors.transparent,
                        ],
                      ),
                    ),
                    child: const Icon(
                      Icons.camera_alt,
                      size: 80,
                      color: Color(0xFF00FFE0),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 40),
            const Text(
              'Upload or Capture Vehicle Image',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Implement image upload/capture
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF00FFE0),
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              child: const Text('Choose Image', style: TextStyle(color: Colors.black)),
            ),
          ],
        ),
      ),
    );
  }
}