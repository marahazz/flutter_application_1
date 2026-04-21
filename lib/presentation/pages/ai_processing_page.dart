// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class AIProcessingPage extends StatefulWidget {
  const AIProcessingPage({super.key});

  @override
  State<AIProcessingPage> createState() => _AIProcessingPageState();
}

class _AIProcessingPageState extends State<AIProcessingPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  int _step = 0;
  final List<String> _steps = [
    'Uploading image...',
    'AI analyzing damage...',
    'Detecting affected parts...',
    'Calculating repair cost...'
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 6),
    )..addListener(() {
        final progress = _controller.value;
        final newStep = (progress * _steps.length).clamp(0, _steps.length - 1).toInt();
        if (newStep != _step) setState(() => _step = newStep);
      });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF181A20),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 40),
            SizedBox(
              width: 120,
              height: 120,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CircularProgressIndicator(
                    value: _controller.value,
                    strokeWidth: 8,
                    backgroundColor: Colors.white12,
                    valueColor: const AlwaysStoppedAnimation<Color>(Colors.cyanAccent),
                  ),
                  Icon(Icons.car_repair, size: 60, color: Colors.cyanAccent.withOpacity(0.7)),
                ],
              ),
            ),
            const SizedBox(height: 32),
            ...List.generate(_steps.length, (i) => _buildStep(i)),
            const SizedBox(height: 40),
            AnimatedOpacity(
              opacity: _controller.isCompleted ? 1 : 0,
              duration: const Duration(milliseconds: 400),
              child: _controller.isCompleted
                  ? ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.cyanAccent,
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                      onPressed: () => Navigator.pop(context),
                      child: const Text('View Result'),
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStep(int i) {
    final isActive = i == _step;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            isActive ? Icons.radio_button_checked : Icons.radio_button_unchecked,
            color: isActive ? Colors.cyanAccent : Colors.white24,
            size: 22,
          ),
          const SizedBox(width: 10),
          Text(
            _steps[i],
            style: TextStyle(
              color: isActive ? Colors.cyanAccent : Colors.white54,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
