// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../../data/models/workshop_review.dart';

class WorkshopReviewPage extends StatelessWidget {
  final List<WorkshopReview> reviews;
  const WorkshopReviewPage({super.key, required this.reviews});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('تقييمات الورش'), backgroundColor: Colors.black),
      backgroundColor: const Color(0xFF181A20),
      body: ListView.builder(
        padding: const EdgeInsets.all(18),
        itemCount: reviews.length,
        itemBuilder: (context, i) => _ReviewTile(review: reviews[i]),
      ),
    );
  }
}

class _ReviewTile extends StatelessWidget {
  final WorkshopReview review;
  const _ReviewTile({required this.review});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.white.withOpacity(0.10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              ...List.generate(5, (i) => Icon(i < review.rating ? Icons.star : Icons.star_border, color: Colors.amber, size: 16)),
              const SizedBox(width: 8),
              Text(review.workshopName, style: const TextStyle(color: Colors.cyanAccent, fontWeight: FontWeight.bold)),
              const Spacer(),
              Text(_formatDate(review.date), style: const TextStyle(color: Colors.white38, fontSize: 12)),
            ],
          ),
          const SizedBox(height: 6),
          Text(review.review, style: const TextStyle(color: Colors.white, fontSize: 14)),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.year}/${date.month.toString().padLeft(2, '0')}/${date.day.toString().padLeft(2, '0')}';
  }
}
