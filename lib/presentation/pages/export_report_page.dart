// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class ExportReportPage extends StatelessWidget {
  final String reportText;
  const ExportReportPage({super.key, required this.reportText});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('تصدير التقرير'), backgroundColor: Colors.black),
      backgroundColor: const Color(0xFF181A20),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('معاينة التقرير', style: TextStyle(color: Colors.cyanAccent, fontWeight: FontWeight.bold, fontSize: 18)),
            const SizedBox(height: 18),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: Colors.white.withOpacity(0.10)),
                ),
                child: SingleChildScrollView(
                  child: Text(reportText, style: const TextStyle(color: Colors.white, fontSize: 15)),
                ),
              ),
            ),
            const SizedBox(height: 18),
            Row(
              children: [
                ElevatedButton.icon(
                  icon: const Icon(Icons.picture_as_pdf),
                  label: const Text('تحميل PDF'),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('تم تحميل التقرير (تجريبي)')));
                  },
                ),
                const SizedBox(width: 12),
                ElevatedButton.icon(
                  icon: const Icon(Icons.share),
                  label: const Text('مشاركة'),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('تمت مشاركة التقرير (تجريبي)')));
                  },
                ),
                const SizedBox(width: 12),
                ElevatedButton.icon(
                  icon: const Icon(Icons.print),
                  label: const Text('طباعة'),
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('تم إرسال التقرير للطابعة (تجريبي)')));
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
