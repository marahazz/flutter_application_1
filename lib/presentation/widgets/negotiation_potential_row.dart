import 'package:flutter/material.dart';

class NegotiationPotentialRow extends StatelessWidget {
  final String potential; // HIGH, MEDIUM, LOW
  final String helperText;
  const NegotiationPotentialRow({super.key, required this.potential, required this.helperText});

  Color get color {
    switch (potential) {
      case 'HIGH':
        return Colors.greenAccent;
      case 'MEDIUM':
        return Colors.orangeAccent;
      case 'LOW':
        return Colors.redAccent;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 2),
      child: Row(
        children: [
          const Icon(Icons.handshake, color: Colors.cyanAccent, size: 18),
          const SizedBox(width: 8),
          Text('Negotiation Potential: ', style: TextStyle(color: Colors.white70, fontSize: 13)),
          Text(potential, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 13)),
          const SizedBox(width: 10),
          Expanded(child: Text(helperText, style: const TextStyle(color: Colors.white38, fontSize: 12))),
        ],
      ),
    );
  }
}
