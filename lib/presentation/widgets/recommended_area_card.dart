// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class RecommendedAreaCard extends StatelessWidget {
  final String area;
  final String reason;
  const RecommendedAreaCard({super.key, required this.area, required this.reason});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.10),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white.withOpacity(0.13)),
        boxShadow: [
          BoxShadow(
            color: Colors.cyanAccent.withOpacity(0.08),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Recommended Repair Area', style: TextStyle(color: Colors.cyanAccent, fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 10),
          Text(area, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
          const SizedBox(height: 4),
          Text(reason, style: const TextStyle(color: Colors.white70, fontSize: 13)),
        ],
      ),
    );
  }
}
