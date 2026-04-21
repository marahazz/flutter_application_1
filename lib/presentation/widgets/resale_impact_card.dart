// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class ResaleImpactCard extends StatelessWidget {
  final String impactLevel; // LOW, MEDIUM, HIGH
  final String explanation;
  const ResaleImpactCard({super.key, required this.impactLevel, required this.explanation});

  Color get badgeColor {
    switch (impactLevel) {
      case 'LOW':
        return Colors.greenAccent;
      case 'MEDIUM':
        return Colors.orangeAccent;
      case 'HIGH':
        return Colors.redAccent;
      default:
        return Colors.grey;
    }
  }

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
          const Text('Resale Value Impact', style: TextStyle(color: Colors.cyanAccent, fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 10),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: badgeColor.withOpacity(0.18),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: badgeColor.withOpacity(0.5)),
                ),
                child: Text(
                  impactLevel,
                  style: TextStyle(color: badgeColor, fontWeight: FontWeight.bold, fontSize: 13),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  explanation,
                  style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
