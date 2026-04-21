// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class WorkshopDashboardPage extends StatelessWidget {
  const WorkshopDashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('لوحة تحكم الورشة'), backgroundColor: Colors.black),
      backgroundColor: const Color(0xFF181A20),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('طلبات الإصلاح', style: TextStyle(color: Colors.cyanAccent, fontWeight: FontWeight.bold, fontSize: 18)),
            const SizedBox(height: 18),
            Expanded(
              child: ListView(
                children: [
                  _RequestTile(
                    customer: 'محمد أحمد',
                    car: 'Toyota Corolla 2020',
                    status: 'قيد التنفيذ',
                    onTap: () {},
                  ),
                  _RequestTile(
                    customer: 'سارة علي',
                    car: 'Hyundai Elantra 2018',
                    status: 'بانتظار قطع الغيار',
                    onTap: () {},
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            ElevatedButton.icon(
              icon: const Icon(Icons.settings),
              label: const Text('إدارة الأسعار'),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class _RequestTile extends StatelessWidget {
  final String customer;
  final String car;
  final String status;
  final VoidCallback onTap;
  const _RequestTile({required this.customer, required this.car, required this.status, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      tileColor: Colors.white.withOpacity(0.08),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      title: Text('$customer - $car', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
      subtitle: Text(status, style: const TextStyle(color: Colors.white70)),
      trailing: const Icon(Icons.arrow_forward_ios, color: Colors.cyanAccent),
      onTap: onTap,
    );
  }
}
