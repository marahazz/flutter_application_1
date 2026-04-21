// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class AIRecommendationCard extends StatelessWidget {
  final String recommendation;
  const AIRecommendationCard({super.key, required this.recommendation});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 12),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.cyanAccent.withOpacity(0.13),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.cyanAccent.withOpacity(0.18)),
        boxShadow: [
          BoxShadow(
            color: Colors.cyanAccent.withOpacity(0.08),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.info_outline, color: Colors.cyanAccent, size: 28),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              recommendation,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
