import 'package:flutter/material.dart';

class AiDamagePage extends StatelessWidget {
  const AiDamagePage({super.key});

  Widget featureCard({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return SizedBox(
      width: 520,
      child: Card(
        color: const Color(0xFFF8FAFC),
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 26),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 52,
                height: 52,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: const Color(0xFF3B82F6)),
                ),
                child: Icon(icon, color: const Color(0xFF3B82F6), size: 28),
              ),
              const SizedBox(height: 24),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF0F172A),
                ),
              ),
              const SizedBox(height: 14),
              const Divider(color: Color(0xFFCBD5E1), thickness: 1),
              const SizedBox(height: 14),
              Text(
                description,
                style: const TextStyle(
                  fontSize: 15,
                  color: Color(0xFF64748B),
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1200),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'AUTONEXA Command Center',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Quick access to your most important tools',
                  style: TextStyle(color: Color(0xFF94A3B8), fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 24,
                  runSpacing: 24,
                  children: [
                    featureCard(
                      icon: Icons.history_edu_outlined,
                      title: 'View Scan History',
                      description: 'Review past assessments and reports',
                    ),
                    featureCard(
                      icon: Icons.chat_bubble_outline,
                      title: 'AI Chat Assistant',
                      description: 'Ask questions and get intelligent guidance',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
