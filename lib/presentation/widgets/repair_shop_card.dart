// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class RepairShopCard extends StatelessWidget {
  final String name;
  final String city;
  final double rating;
  final double distance;
  final String avgPrice;
  const RepairShopCard({
    super.key,
    required this.name,
    required this.city,
    required this.rating,
    required this.distance,
    required this.avgPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white.withOpacity(0.10)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.10),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.build, color: Colors.cyanAccent, size: 36),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  '$city • ${distance.toStringAsFixed(1)} km',
                  style: const TextStyle(color: Colors.white70, fontSize: 13),
                ),
                Row(
                  children: [
                    ...List.generate(5, (i) => Icon(
                          i < rating.round()
                              ? Icons.star
                              : Icons.star_border,
                          color: Colors.amber,
                          size: 16,
                        )),
                    const SizedBox(width: 6),
                    Text(
                      rating.toStringAsFixed(1),
                      style: const TextStyle(color: Colors.white60, fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Column(
            children: [
              const Text('Avg. Price', style: TextStyle(color: Colors.white38, fontSize: 11)),
              Text(
                avgPrice,
                style: const TextStyle(color: Colors.cyanAccent, fontWeight: FontWeight.bold, fontSize: 14),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
