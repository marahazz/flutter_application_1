// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../../data/models/repair_tracking.dart';

class RepairTrackingPage extends StatelessWidget {
  final RepairTracking tracking;
  const RepairTrackingPage({super.key, required this.tracking});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Repair Tracking'),
        backgroundColor: Colors.black,
      ),
      backgroundColor: const Color(0xFF181A20),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(tracking.car, style: const TextStyle(color: Colors.cyanAccent, fontWeight: FontWeight.bold, fontSize: 20)),
            const SizedBox(height: 18),
            Expanded(
              child: ListView(
                children: [
                  ...tracking.steps.map((step) => _StepTile(step: step, isActive: step.status == tracking.currentStatus)),
                ],
              ),
            ),
            const SizedBox(height: 18),
            _StatusLegend(),
          ],
        ),
      ),
    );
  }
}

class _StepTile extends StatelessWidget {
  final RepairStep step;
  final bool isActive;
  const _StepTile({required this.step, required this.isActive});

  Color get color {
    switch (step.status) {
      case RepairStatus.pending:
        return Colors.grey;
      case RepairStatus.awaitingParts:
        return Colors.orangeAccent;
      case RepairStatus.inProgress:
        return Colors.cyanAccent;
      case RepairStatus.qualityCheck:
        return Colors.amberAccent;
      case RepairStatus.readyForPickup:
        return Colors.greenAccent;
      case RepairStatus.delivered:
        return Colors.blueAccent;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 400),
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(isActive ? 0.18 : 0.10),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: color.withOpacity(0.25), width: isActive ? 2 : 1),
        boxShadow: isActive
            ? [BoxShadow(color: color.withOpacity(0.18), blurRadius: 16, offset: const Offset(0, 6))]
            : [],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.check_circle, color: color, size: 28),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(step.label, style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 16)),
                if (step.note != null) ...[
                  const SizedBox(height: 4),
                  Text(step.note!, style: const TextStyle(color: Colors.white70, fontSize: 13)),
                ],
                const SizedBox(height: 4),
                Text(_formatDate(step.timestamp), style: const TextStyle(color: Colors.white38, fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.year}/${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')}';
  }
}

class _StatusLegend extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _legendDot('Pending', Colors.grey),
        _legendDot('Awaiting Parts', Colors.orangeAccent),
        _legendDot('In Progress', Colors.cyanAccent),
        _legendDot('Quality Check', Colors.amberAccent),
        _legendDot('Ready', Colors.greenAccent),
        _legendDot('Delivered', Colors.blueAccent),
      ],
    );
  }

  Widget _legendDot(String label, Color color) => Row(
        children: [
          Icon(Icons.circle, color: color, size: 12),
          const SizedBox(width: 4),
          Text(label, style: const TextStyle(color: Colors.white54, fontSize: 11)),
        ],
      );
}
