// ignore_for_file: deprecated_member_use

import 'dart:ui';
import 'package:flutter/material.dart';

class AiDamagePage extends StatelessWidget {
  const AiDamagePage({super.key});

  Widget card(IconData icon, String title, String sub) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(.06),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: const Color(0xFF00FFE0).withOpacity(.3),
            ),
          ),
          child: Row(
            children: [
              Icon(icon, color: const Color(0xFF00FFE0)),
              const SizedBox(width: 14),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18)),
                  Text(sub,
                      style:
                          const TextStyle(color: Colors.white70, fontSize: 13)),
                ],
              ),
              const Spacer(),
              const Icon(Icons.arrow_forward_ios,
                  color: Colors.white70, size: 14),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF111417),
      body: Center(
        child: SizedBox(
          width: 420,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [

              const Text(
                "Welcome Back",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 46,
                    fontWeight: FontWeight.w900),
              ),

              const SizedBox(height: 10),

              const Text(
                "Smart Vehicle Analysis",
                style: TextStyle(
                    color: Color(0xFF70FFE8),
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 6),

              const Text(
                "Choose your next action",
                style: TextStyle(color: Colors.white54),
              ),

              const SizedBox(height: 40),

              card(Icons.qr_code_scanner,
                  "Scan Vehicle", "Upload or capture damage image"),

              card(Icons.analytics,
                  "AI Damage Detection", "Run instant smart analysis"),

              card(Icons.build_circle,
                  "Repair Cost Estimate", "Get repair pricing"),
            ],
          ),
        ),
      ),
    );
  }
}
