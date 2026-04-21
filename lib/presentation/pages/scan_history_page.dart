// ignore_for_file: prefer_interpolation_to_compose_strings, deprecated_member_use

import 'package:flutter/material.dart';
import '../widgets/severity_badge.dart';
import '../widgets/ai_recommendation_card.dart';
import '../widgets/confidence_indicator.dart';
import '../widgets/repair_shop_card.dart';

class ScanHistoryItem {
  final String carBrand;
  final String carModel;
  final String damageSeverity;
  final String costRange;
  final DateTime scanDate;
  final String thumbnailUrl;

  ScanHistoryItem({
    required this.carBrand,
    required this.carModel,
    required this.damageSeverity,
    required this.costRange,
    required this.scanDate,
    required this.thumbnailUrl,
  });
}

class ScanHistoryPage extends StatelessWidget {
  final List<ScanHistoryItem> historyItems;

  const ScanHistoryPage({super.key, this.historyItems = const []});

  @override
  Widget build(BuildContext context) {
    final items = historyItems.isNotEmpty ? historyItems : _mockHistory();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan History'),
        backgroundColor: Colors.black,
      ),
      backgroundColor: const Color(0xFF181A20),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: items.length,
        itemBuilder: (context, i) => _GlassHistoryCard(item: items[i]),
      ),
    );
  }

  List<ScanHistoryItem> _mockHistory() => [
    ScanHistoryItem(
      carBrand: 'Toyota',
      carModel: 'Corolla',
      damageSeverity: 'Minor',
      costRange: 'JOD 100 - 250',
      scanDate: DateTime.now().subtract(const Duration(days: 1)),
      thumbnailUrl: 'https://i.imgur.com/auto1.jpg',
    ),
    ScanHistoryItem(
      carBrand: 'Hyundai',
      carModel: 'Elantra',
      damageSeverity: 'Severe',
      costRange: 'JOD 1200 - 1800',
      scanDate: DateTime.now().subtract(const Duration(days: 3)),
      thumbnailUrl: 'https://i.imgur.com/auto2.jpg',
    ),
    ScanHistoryItem(
      carBrand: 'Kia',
      carModel: 'Sportage',
      damageSeverity: 'Moderate',
      costRange: 'JOD 400 - 700',
      scanDate: DateTime.now().subtract(const Duration(days: 7)),
      thumbnailUrl: 'https://i.imgur.com/auto3.jpg',
    ),
  ];
}

class _GlassHistoryCard extends StatelessWidget {
  final ScanHistoryItem item;
  const _GlassHistoryCard({required this.item});

  @override
  Widget build(BuildContext context) {
    // Mock confidence and recommendation for demo
    final double confidence = item.damageSeverity == 'Severe'
        ? 0.92
        : item.damageSeverity == 'Moderate'
        ? 0.68
        : 0.85;
    final String recommendation = item.damageSeverity == 'Severe'
        ? 'Immediate repair required.'
        : item.damageSeverity == 'Moderate'
        ? 'Repair recommended within 7 days.'
        : 'Safe to drive short distance.';

    return Container(
      margin: const EdgeInsets.only(bottom: 18),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          colors: [
            Colors.white.withOpacity(0.10),
            Colors.white.withOpacity(0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.18),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
        border: Border.all(color: Colors.white.withOpacity(0.08)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  item.thumbnailUrl,
                  width: 56,
                  height: 56,
                  fit: BoxFit.cover,
                  errorBuilder: (c, e, s) => Container(
                    width: 56,
                    height: 56,
                    color: Colors.grey[800],
                    child: const Icon(
                      Icons.directions_car,
                      color: Colors.white54,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${item.carBrand} ${item.carModel}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        SeverityBadge(severity: item.damageSeverity),
                        const SizedBox(width: 8),
                        Text(
                          item.costRange,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              ConfidenceIndicator(confidence: confidence),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Scanned: ${_formatDate(item.scanDate)}',
            style: const TextStyle(color: Colors.white38, fontSize: 12),
          ),
          const SizedBox(height: 8),
          AIRecommendationCard(recommendation: recommendation),
          const SizedBox(height: 8),
          // Mock repair shops
          const Text(
            'Nearby Repair Shops',
            style: TextStyle(
              color: Colors.cyanAccent,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          RepairShopCard(
            name: 'AutoFix Center',
            city: 'Amman',
            rating: 4.7,
            distance: 2.1,
            avgPrice: 'JOD 350',
          ),
          RepairShopCard(
            name: 'Jordan Car Repair',
            city: 'Irbid',
            rating: 4.3,
            distance: 5.4,
            avgPrice: 'JOD 420',
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButton.icon(
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    '/repair-tracking',
                    arguments: {
                      'car': item.carBrand + ' ' + item.carModel,
                      // Add more mock data as needed
                    },
                  );
                },
                icon: const Icon(Icons.track_changes, color: Colors.cyanAccent),
                label: const Text(
                  'Track Repair',
                  style: TextStyle(color: Colors.cyanAccent),
                ),
              ),
              const SizedBox(width: 8),
              TextButton.icon(
                onPressed: () {
                  Navigator.of(context).pushNamed('/export-report');
                },
                icon: const Icon(
                  Icons.picture_as_pdf,
                  color: Colors.cyanAccent,
                ),
                label: const Text(
                  'Download Report',
                  style: TextStyle(color: Colors.cyanAccent),
                ),
              ),
              const SizedBox(width: 8),
              TextButton.icon(
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    '/quote-request',
                    arguments: {
                      'damageSummary': '${item.carBrand} ${item.carModel} - ${item.damageSeverity} damage',
                    },
                  );
                },
                icon: const Icon(Icons.request_quote, color: Colors.cyanAccent),
                label: const Text(
                  'Get Quote',
                  style: TextStyle(color: Colors.cyanAccent),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.year}/${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')}';
  }
}
