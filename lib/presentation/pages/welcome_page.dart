// ignore_for_file: deprecated_member_use

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:autonexa/core/constants/app_constants.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          /// 🔥 Background Jordan Gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black,
                  Color(0xFF2B2B2B),
                  Color(0xFFEDEDED),
                  Color(0xFF8D0000),
                  Color(0xFFB30000),
                ],
                stops: [0, .2, .45, .75, 1],
              ),
            ),
          ),

          /// 🔥 Heavy Fog Layer
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
              child: Container(color: Colors.white.withOpacity(.12)),
            ),
          ),

          /// 🔺 Jordan Triangle
          Positioned(
            left: 0,
            top: 0,
            bottom: 0,
            width: w * .35,
            child: ClipPath(
              clipper: _JordanClipper(),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.red.withOpacity(.4),
                      Colors.red.withOpacity(.05),
                    ],
                  ),
                ),
              ),
            ),
          ),

          /// 🚗 Ghost Car
          const Positioned(
            right: -40,
            bottom: 60,
            child: Opacity(
              opacity: .08,
              child: Icon(Icons.directions_car, size: 260, color: Colors.white),
            ),
          ),

          /// ⭐ Content
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                /// Title Gradient
                ShaderMask(
                  shaderCallback: (bounds) {
                    return const LinearGradient(
                      colors: [Colors.white, Color(0xFF7EFFCE)],
                    ).createShader(bounds);
                  },
                  child: const Text(
                    "AUTONEXA",
                    style: TextStyle(
                      fontSize: 64,
                      fontWeight: FontWeight.w900,
                      letterSpacing: 3,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          color: Colors.black87,
                          blurRadius: 30,
                          offset: Offset(0, 10),
                        ),
                        Shadow(color: Color(0x8832FFC8), blurRadius: 35),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                /// Subtitle
                const Text(
                  "AI-Powered Car Damage Assessment",
                  style: TextStyle(
                    color: Color.fromARGB(179, 19, 59, 24),
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 50),

                /// Button
                InkWell(
                  borderRadius: BorderRadius.circular(40),
                  onTap: () => context.go(AppRoutes.customerHome),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 48,
                      vertical: 16,
                    ),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFFE21B24), Color(0xFFB20710)],
                      ),
                      borderRadius: BorderRadius.circular(40),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF00E6A3).withOpacity(.5),
                          blurRadius: 40,
                          offset: const Offset(0, 20),
                        ),
                      ],
                    ),
                    child: const Text(
                      "Get Started",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _JordanClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final p = Path();
    p.moveTo(0, 0);
    p.lineTo(size.width * .9, size.height * .2);
    p.lineTo(size.width * .7, size.height * .7);
    p.lineTo(0, size.height);
    p.close();
    return p;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
