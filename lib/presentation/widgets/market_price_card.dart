// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class MarketPriceCard extends StatelessWidget {
  final int minJOD;
  final int maxJOD;
  final String status; // Within normal range, Above average, Below average
  const MarketPriceCard({super.key, required this.minJOD, required this.maxJOD, required this.status});

  Color get color {
    switch (status) {
      case 'Within normal range':
        return Colors.greenAccent;
      case 'Above average':
        return Colors.orangeAccent;
      case 'Below average':
        return Colors.cyanAccent;
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
            color: color.withOpacity(0.08),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Market Average Price', style: TextStyle(color: Colors.cyanAccent, fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 10),
          Text('Market Range: $minJOD – $maxJOD JOD', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15)),
          const SizedBox(height: 4),
          Row(
            children: [
              Icon(
                status == 'Above average'
                    ? Icons.warning
                    : status == 'Below average'
                        ? Icons.check_circle
                        : Icons.info,
                color: color,
                size: 18,
              ),
              const SizedBox(width: 8),
              Text(status, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 14)),
            ],
          ),
          const SizedBox(height: 4),
          const Text('This estimate is based on real repair trends in Jordan.', style: TextStyle(color: Colors.white38, fontSize: 12)),
        ],
      ),
    );
  }
}
