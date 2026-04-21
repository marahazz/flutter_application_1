// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class TravelSafetyCard extends StatelessWidget {
  final String status; // Safe for city driving, Long highway trips not recommended, Not safe to drive
  const TravelSafetyCard({super.key, required this.status});

  Color get color {
    switch (status) {
      case 'Safe for city driving':
        return Colors.greenAccent;
      case 'Long highway trips not recommended':
        return Colors.orangeAccent;
      case 'Not safe to drive':
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
        color: color.withOpacity(0.13),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: color.withOpacity(0.18)),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.08),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(Icons.shield, color: color, size: 28),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              status,
              style: TextStyle(color: color, fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
