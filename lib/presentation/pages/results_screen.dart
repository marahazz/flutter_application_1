// 📊 Step 4: Results Screen
// Shows AI damage analysis results

// ignore_for_file: unused_field, deprecated_member_use

import 'dart:math';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ResultsScreen extends StatefulWidget {
  const ResultsScreen({super.key});

  @override
  State<ResultsScreen> createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;

  // Simulated AI results
  late _DamageResult _result;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.6, curve: Curves.easeOut),
      ),
    );

    _slideAnimation = Tween<double>(begin: 50.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.2, 1.0, curve: Curves.easeOutCubic),
      ),
    );

    // Generate random AI result
    _result = _generateRandomResult();

    _controller.forward();
  }

  _DamageResult _generateRandomResult() {
    final random = Random();

    // Damage types
    final damageTypes = [
      _DamageType(
        name: 'Scratch',
        icon: Icons.auto_fix_high,
        description: 'Surface paint damage',
      ),
      _DamageType(
        name: 'Dent',
        icon: Icons.bubble_chart,
        description: 'Body panel deformation',
      ),
      _DamageType(
        name: 'Crack',
        icon: Icons.error_outline,
        description: 'Structural damage',
      ),
      _DamageType(
        name: 'Paint Peeling',
        icon: Icons.layers,
        description: 'Paint layer separation',
      ),
    ];

    // Severity levels
    final severities = [
      _SeverityLevel(
        name: 'Low',
        color: const Color(0xFF4CAF50),
        description: 'Minor damage, quick repair',
      ),
      _SeverityLevel(
        name: 'Medium',
        color: const Color(0xFFFF9800),
        description: 'Moderate damage, standard repair',
      ),
      _SeverityLevel(
        name: 'High',
        color: const Color(0xFFF44336),
        description: 'Severe damage, extensive repair',
      ),
    ];

    // Repair suggestions
    final repairSuggestions = [
      'Buff and polish the affected area',
      'Replace the damaged panel',
      'Full repaint required',
      'Structural reinforcement needed',
      'Dent removal and paint touch-up',
    ];

    // Estimated costs
    final costs = [
      '\$150 - \$300',
      '\$300 - \$600',
      '\$600 - \$1,200',
      '\$1,200 - \$2,500',
      '\$2,500 - \$5,000',
    ];

    return _DamageResult(
      damageType: damageTypes[random.nextInt(damageTypes.length)],
      severity: severities[random.nextInt(severities.length)],
      repairSuggestion: repairSuggestions[random.nextInt(repairSuggestions.length)],
      estimatedCost: costs[random.nextInt(costs.length)],
      confidenceScore: 85 + random.nextInt(15),
      affectedParts: _getAffectedParts(random),
    );
  }

  List<String> _getAffectedParts(Random random) {
    final allParts = [
      'Front bumper',
      'Rear bumper',
      'Left door',
      'Right door',
      'Hood',
      'Trunk',
      'Side mirror',
      'Fender',
    ];

    final partCount = random.nextInt(3) + 1;
    final selectedParts = <String>[];

    for (int i = 0; i < partCount; i++) {
      final index = random.nextInt(allParts.length);
      if (!selectedParts.contains(allParts[index])) {
        selectedParts.add(allParts[index]);
      }
    }

    return selectedParts;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0A0A),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => context.go('/damage-capture'),
        ),
        title: const Text(
          'Analysis Complete',
          style: TextStyle(
            color: Colors.white70,
            fontSize: 14,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ✅ Success Icon
                _buildSuccessHeader(),

                const SizedBox(height: 32),

                // 🎯 Damage Type Card
                _buildDamageTypeCard(),

                const SizedBox(height: 16),

                // ⚠️ Severity Card
                _buildSeverityCard(),

                const SizedBox(height: 16),

                // 🔧 Repair Suggestion Card
                _buildRepairSuggestionCard(),

                const SizedBox(height: 16),

                // 💰 Estimated Cost Card
                _buildCostCard(),

                const SizedBox(height: 16),

                // 🔩 Affected Parts
                _buildAffectedPartsCard(),

                const SizedBox(height: 16),

                // 📊 Confidence Score
                _buildConfidenceCard(),

                const SizedBox(height: 32),

                // 🔘 Action Buttons
                _buildActionButtons(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSuccessHeader() {
    return Center(
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFF00E676).withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.check_circle,
              color: Color(0xFF00E676),
              size: 48,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Analysis Complete',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'AI has analyzed the damage',
            style: TextStyle(
              color: Colors.white54,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDamageTypeCard() {
    return _buildInfoCard(
      icon: _result.damageType.icon,
      title: 'Damage Type',
      value: _result.damageType.name,
      subtitle: _result.damageType.description,
      accentColor: const Color(0xFF00E676),
    );
  }

  Widget _buildSeverityCard() {
    return _buildInfoCard(
      icon: Icons.warning_amber,
      title: 'Severity Level',
      value: _result.severity.name,
      subtitle: _result.severity.description,
      accentColor: _result.severity.color,
    );
  }

  Widget _buildRepairSuggestionCard() {
    return _buildInfoCard(
      icon: Icons.build,
      title: 'Repair Suggestion',
      value: _result.repairSuggestion,
      subtitle: 'Recommended action based on AI analysis',
      accentColor: const Color(0xFF2196F3),
    );
  }

  Widget _buildCostCard() {
    return _buildInfoCard(
      icon: Icons.attach_money,
      title: 'Estimated Cost',
      value: _result.estimatedCost,
      subtitle: 'Range based on damage severity',
      accentColor: const Color(0xFFFF9800),
    );
  }

  Widget _buildAffectedPartsCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A2E),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.car_repair, color: Colors.white70, size: 20),
              const SizedBox(width: 12),
              const Text(
                'Affected Parts',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _result.affectedParts.map((part) {
              return Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  part,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildConfidenceCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A2E),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.psychology, color: Colors.white70, size: 20),
              const SizedBox(width: 12),
              const Text(
                'AI Confidence',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: _result.confidenceScore / 100,
                    backgroundColor: Colors.white.withOpacity(0.1),
                    valueColor: const AlwaysStoppedAnimation<Color>(
                      Color(0xFF00E676),
                    ),
                    minHeight: 8,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                '${_result.confidenceScore}%',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String value,
    required String subtitle,
    required Color accentColor,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A2E),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: accentColor.withOpacity(0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: accentColor, size: 20),
              const SizedBox(width: 12),
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: TextStyle(
              color: accentColor,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: const TextStyle(
              color: Colors.white54,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons() {
    return Column(
      children: [
        // View Workshops Button
        SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            onPressed: () {
              // Navigate to workshops
              context.go('/enterprise-dashboard');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF00E676),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.store, color: Colors.black),
                SizedBox(width: 8),
                Text(
                  'View Workshops',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),

        // Back to Home Button
        SizedBox(
          width: double.infinity,
          height: 56,
          child: OutlinedButton(
            onPressed: () => context.go('/'),
            style: OutlinedButton.styleFrom(
              foregroundColor: Colors.white,
              side: const BorderSide(color: Colors.white30),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.home, color: Colors.white),
                SizedBox(width: 8),
                Text(
                  'Back to Home',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// Data Models
class _DamageType {
  final String name;
  final IconData icon;
  final String description;

  _DamageType({
    required this.name,
    required this.icon,
    required this.description,
  });
}

class _SeverityLevel {
  final String name;
  final Color color;
  final String description;

  _SeverityLevel({
    required this.name,
    required this.color,
    required this.description,
  });
}

class _DamageResult {
  final _DamageType damageType;
  final _SeverityLevel severity;
  final String repairSuggestion;
  final String estimatedCost;
  final int confidenceScore;
  final List<String> affectedParts;

  _DamageResult({
    required this.damageType,
    required this.severity,
    required this.repairSuggestion,
    required this.estimatedCost,
    required this.confidenceScore,
    required this.affectedParts,
  });
}