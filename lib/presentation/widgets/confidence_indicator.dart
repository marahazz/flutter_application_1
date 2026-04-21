import 'package:flutter/material.dart';

class ConfidenceIndicator extends StatelessWidget {
  final double confidence; // 0.0 - 1.0
  const ConfidenceIndicator({super.key, required this.confidence});

  String get label {
    if (confidence >= 0.8) return 'High';
    if (confidence >= 0.5) return 'Medium';
    return 'Low';
  }

  Color get color {
    if (confidence >= 0.8) return Colors.greenAccent;
    if (confidence >= 0.5) return Colors.orangeAccent;
    return Colors.redAccent;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 64,
              height: 64,
              child: CircularProgressIndicator(
                value: confidence,
                strokeWidth: 7,
                backgroundColor: Colors.white12,
                valueColor: AlwaysStoppedAnimation<Color>(color),
              ),
            ),
            Text(
              '${(confidence * 100).toStringAsFixed(0)}%',
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          '$label confidence',
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
