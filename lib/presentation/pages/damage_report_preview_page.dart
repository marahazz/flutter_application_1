// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class DamageReportPreviewPage extends StatelessWidget {
  final String carInfo;
  final String severity;
  final String costEstimate;
  final String confidence;
  final String scanDate;
  const DamageReportPreviewPage({
    super.key,
    required this.carInfo,
    required this.severity,
    required this.costEstimate,
    required this.confidence,
    required this.scanDate,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Damage Report'), backgroundColor: Colors.black),
      backgroundColor: const Color(0xFF181A20),
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(24),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.06),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: Colors.white.withOpacity(0.10)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.10),
                blurRadius: 18,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          constraints: const BoxConstraints(maxWidth: 420),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('AUTONEXA Damage Report', style: TextStyle(color: Colors.cyanAccent, fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 18),
              _row('Car Info:', carInfo),
              _row('Severity:', severity),
              _row('Cost Estimate:', costEstimate),
              _row('Confidence:', confidence),
              _row('Scan Date:', scanDate),
              const SizedBox(height: 32),
              Center(
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.cyanAccent,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  icon: const Icon(Icons.download),
                  label: const Text('Download PDF'),
                  onPressed: () {
                    // Mock download
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('PDF downloaded (mock)')));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _row(String label, String value) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          children: [
            SizedBox(width: 110, child: Text(label, style: const TextStyle(color: Colors.white70, fontSize: 15))),
            Expanded(child: Text(value, style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.w600))),
          ],
        ),
      );
}
