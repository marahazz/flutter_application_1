// ignore: unnecessary_import
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EstimatePage extends StatelessWidget {
  const EstimatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Repair Cost Estimate'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(Icons.build_circle, size: 80, color: Colors.white70),
            SizedBox(height: 16),
            Text(
              'Repair Cost Estimate',
              style: TextStyle(fontSize: 22, color: Colors.white70),
            ),
            SizedBox(height: 8),
            Text(
              'See instant estimation to plan your repair budget.',
              style: TextStyle(color: Colors.white54),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
