// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class SeverityBadge extends StatelessWidget {
  final String severity;
  const SeverityBadge({super.key, required this.severity});

  Color get color {
    switch (severity) {
      case 'Minor':
        return Colors.greenAccent;
      case 'Moderate':
        return Colors.orangeAccent;
      case 'Severe':
        return Colors.redAccent;
      default:
        return Colors.grey;
    }
  }

  String get explanation {
    switch (severity) {
      case 'Minor':
        return 'Minor damage, safe to drive.';
      case 'Moderate':
        return 'Moderate damage, repair recommended soon.';
      case 'Severe':
        return 'Severe damage, immediate repair required!';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: const Duration(milliseconds: 600),
      builder: (context, value, child) => Opacity(
        opacity: value,
        child: child,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: color.withOpacity(0.18),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: color.withOpacity(0.5)),
            ),
            child: Text(
              severity,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
                fontSize: 13,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Text(
            explanation,
            style: TextStyle(color: color, fontSize: 13, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
