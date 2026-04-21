// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class WorkshopComparisonPage extends StatelessWidget {
  final List<WorkshopInfo> workshops;
  const WorkshopComparisonPage({super.key, required this.workshops});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('مقارنة الورش'), backgroundColor: Colors.black),
      backgroundColor: const Color(0xFF181A20),
      body: Padding(
        padding: const EdgeInsets.all(18),
        child: DataTable(
          headingRowColor: MaterialStateProperty.all(Colors.white10),
          columns: const [
            DataColumn(label: Text('الورشة', style: TextStyle(color: Colors.cyanAccent))),
            DataColumn(label: Text('السعر', style: TextStyle(color: Colors.cyanAccent))),
            DataColumn(label: Text('التقييم', style: TextStyle(color: Colors.cyanAccent))),
            DataColumn(label: Text('المسافة', style: TextStyle(color: Colors.cyanAccent))),
            DataColumn(label: Text('المدة', style: TextStyle(color: Colors.cyanAccent))),
          ],
          rows: workshops.map((w) => DataRow(cells: [
            DataCell(Text(w.name, style: const TextStyle(color: Colors.white))),
            DataCell(Text('${w.price} JOD', style: const TextStyle(color: Colors.white))),
            DataCell(Row(children: [
              ...List.generate(5, (i) => Icon(i < w.rating ? Icons.star : Icons.star_border, color: Colors.amber, size: 16)),
              const SizedBox(width: 4),
              Text(w.rating.toStringAsFixed(1), style: const TextStyle(color: Colors.white70, fontSize: 12)),
            ])),
            DataCell(Text('${w.distance} كم', style: const TextStyle(color: Colors.white))),
            DataCell(Text(w.duration, style: const TextStyle(color: Colors.white))),
          ])).toList(),
        ),
      ),
    );
  }
}

class WorkshopInfo {
  final String name;
  final int price;
  final double rating;
  final double distance;
  final String duration;
  WorkshopInfo({required this.name, required this.price, required this.rating, required this.distance, required this.duration});
}
