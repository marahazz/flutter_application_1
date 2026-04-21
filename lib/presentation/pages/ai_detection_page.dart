// ignore_for_file: unnecessary_import

import 'dart:ui';
import 'package:flutter/material.dart';

class AiDetectionPage extends StatefulWidget {
  const AiDetectionPage({super.key});

  @override
  State<AiDetectionPage> createState() => _AiDetectionPageState();
}

class _AiDetectionPageState extends State<AiDetectionPage> with TickerProviderStateMixin {
  late final AnimationController _progressController;
  late final Animation<double> _progress;

  @override
  void initState() {
    super.initState();
    _progressController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    _progress = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _progressController, curve: Curves.easeInOut),
    );
    _progressController.forward();
  }

  @override
  void dispose() {
    _progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF111417),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('AI Damage Detection', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFF00FFE0), width: 2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Center(
                child: Text(
                  'Vehicle Image Preview',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 40),
            AnimatedBuilder(
              animation: _progress,
              builder: (context, child) {
                return Column(
                  children: [
                    Text(
                      'Analyzing... ${( _progress.value * 100).toInt()}%',
                      style: const TextStyle(
                        color: Color(0xFF00FFE0),
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 20),
                    LinearProgressIndicator(
                      value: _progress.value,
                      backgroundColor: Colors.grey,
                      valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF00FFE0)),
                    ),
                  ],
                );
              },
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: _progress.value >= 1 ? () {
                // Navigate to results
              } : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF00FFE0),
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              child: const Text('View Results', style: TextStyle(color: Colors.black)),
            ),
          ],
        ),
      ),
    );
  }
}