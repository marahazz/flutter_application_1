// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class InspectionRiskCard extends StatelessWidget {
  final String text;
  const InspectionRiskCard({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.redAccent.withOpacity(0.13),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.redAccent.withOpacity(0.18)),
        boxShadow: [
          BoxShadow(
            color: Colors.redAccent.withOpacity(0.08),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.warning_amber_rounded, color: Colors.redAccent, size: 28),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
