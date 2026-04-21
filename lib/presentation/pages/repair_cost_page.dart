// ignore_for_file: deprecated_member_use, unnecessary_import

import 'dart:ui';
import 'package:flutter/material.dart';

class RepairCostPage extends StatelessWidget {
  const RepairCostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF111417),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Repair Cost Estimate', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Center(
        child: Container(
          width: 400,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: const Color(0xFF00FFE0).withOpacity(0.3)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Estimated Repair Cost',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                '\$2,500 - \$3,200',
                style: TextStyle(
                  color: Color(0xFF00FFE0),
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Breakdown:',
                style: TextStyle(color: Colors.white70),
              ),
              const SizedBox(height: 10),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Parts', style: TextStyle(color: Colors.white)),
                  Text('\$1,800', style: TextStyle(color: Colors.white)),
                ],
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Labor', style: TextStyle(color: Colors.white)),
                  Text('\$700', style: TextStyle(color: Colors.white)),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'Confidence: 85%',
                style: TextStyle(color: Colors.white70),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Implement booking or something
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00FFE0),
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
                child: const Text('Get Quote', style: TextStyle(color: Colors.black)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}