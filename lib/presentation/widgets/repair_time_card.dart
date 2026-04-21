// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class RepairTimeCard extends StatelessWidget {
  final String duration;
  final String availability; // High, Medium, Low
  const RepairTimeCard({super.key, required this.duration, required this.availability});

  Color get color {
    switch (availability) {
      case 'High':
        return Colors.greenAccent;
      case 'Medium':
        return Colors.orangeAccent;
      case 'Low':
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
          const Text('Estimated Repair Time', style: TextStyle(color: Colors.cyanAccent, fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 10),
          Row(
            children: [
              const Icon(Icons.schedule, color: Colors.cyanAccent, size: 22),
              const SizedBox(width: 8),
              Text(duration, style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w600)),
              const SizedBox(width: 18),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.18),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: color.withOpacity(0.5)),
                ),
                child: Row(
                  children: [
                    Icon(Icons.inventory, color: color, size: 16),
                    const SizedBox(width: 4),
                    Text('Parts: $availability', style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 13)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
