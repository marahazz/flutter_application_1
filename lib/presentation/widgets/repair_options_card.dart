// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class RepairOptionsCard extends StatelessWidget {
  const RepairOptionsCard({super.key});

  @override
  Widget build(BuildContext context) {
    final options = [
      _RepairOption(
        title: 'Original Parts',
        priceJOD: 420,
        priceUSD: 590,
        description: 'Highest quality and warranty',
        recommended: false,
      ),
      _RepairOption(
        title: 'Commercial Parts',
        priceJOD: 280,
        priceUSD: 395,
        description: 'Balanced cost and reliability (Recommended)',
        recommended: true,
      ),
      _RepairOption(
        title: 'Used Parts',
        priceJOD: 190,
        priceUSD: 268,
        description: 'Lowest cost with limited lifespan',
        recommended: false,
      ),
    ];
    return _GlassCard(
      title: 'Repair Options',
      child: Column(
        children: options.map((o) => _OptionRow(option: o)).toList(),
      ),
    );
  }
}

class _OptionRow extends StatelessWidget {
  final _RepairOption option;
  const _OptionRow({required this.option});

  @override
  Widget build(BuildContext context) {
    final glow = option.recommended
        ? [
            BoxShadow(
              color: Colors.cyanAccent.withOpacity(0.35),
              blurRadius: 16,
              spreadRadius: 1,
            ),
          ]
        : [];
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(
          color: option.recommended ? Colors.cyanAccent : Colors.white.withOpacity(0.10),
          width: option.recommended ? 2 : 1,
        ),
        boxShadow: glow.cast<BoxShadow>(),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(option.title,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        )),
                    if (option.recommended)
                      Container(
                        margin: const EdgeInsets.only(left: 8),
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.cyanAccent.withOpacity(0.18),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text('Recommended', style: TextStyle(color: Colors.cyanAccent, fontSize: 12, fontWeight: FontWeight.bold)),
                      ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(option.description, style: const TextStyle(color: Colors.white70, fontSize: 13)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text('${option.priceJOD} JOD', style: const TextStyle(color: Colors.cyanAccent, fontWeight: FontWeight.bold, fontSize: 16)),
              Text('~4${option.priceUSD}', style: const TextStyle(color: Colors.white38, fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }
}

class _RepairOption {
  final String title;
  final int priceJOD;
  final int priceUSD;
  final String description;
  final bool recommended;
  _RepairOption({required this.title, required this.priceJOD, required this.priceUSD, required this.description, required this.recommended});
}

class _GlassCard extends StatelessWidget {
  final String title;
  final Widget child;
  const _GlassCard({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.10),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.white.withOpacity(0.13)),
        boxShadow: [
          BoxShadow(
            color: Colors.cyanAccent.withOpacity(0.08),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: const TextStyle(color: Colors.cyanAccent, fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 10),
          child,
        ],
      ),
    );
  }
}
