// ignore_for_file: unnecessary_import, deprecated_member_use

import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import '../widgets/repair_options_card.dart';
import '../widgets/resale_impact_card.dart';
import '../widgets/repair_time_card.dart';
import '../widgets/travel_safety_card.dart';
import '../widgets/recommended_area_card.dart';
import '../widgets/market_price_card.dart';
import '../widgets/negotiation_potential_row.dart';
import '../widgets/inspection_risk_card.dart';

enum DamageLevel { low, medium, high }

class AiDamageDetectionPage extends StatefulWidget {
  const AiDamageDetectionPage({super.key});

  @override
  State<AiDamageDetectionPage> createState() => _AiDamageDetectionPageState();
}

class _AiDamageDetectionPageState extends State<AiDamageDetectionPage>
    with TickerProviderStateMixin {
  bool _hasImage = false;
  bool _isProcessing = false;
  DamageLevel? _resultLevel;
  double _confidence = 0;
  late final AnimationController _scanController;

  @override
  void initState() {
    super.initState();
    _scanController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _scanController.dispose();
    super.dispose();
  }

  Future<void> _startAnalysis() async {
    if (!_hasImage || _isProcessing) return;
    setState(() {
      _isProcessing = true;
      _resultLevel = null;
      _confidence = 0;
    });

    // Simulate AI analysis delay
    await Future.delayed(const Duration(seconds: 3));

    setState(() {
      _isProcessing = false;
      _resultLevel = DamageLevel.values[DateTime.now().second % 3];
      _confidence = 70 + (DateTime.now().millisecond % 30) / 1.0;
    });
  }

  String get _damageLabel {
    switch (_resultLevel) {
      case DamageLevel.low:
        return 'Low';
      case DamageLevel.medium:
        return 'Medium';
      case DamageLevel.high:
        return 'High';
      default:
        return 'Unknown';
    }
  }

  Color get _severityColor {
    switch (_resultLevel) {
      case DamageLevel.low:
        return Colors.greenAccent;
      case DamageLevel.medium:
        return Colors.amberAccent;
      case DamageLevel.high:
        return Colors.redAccent;
      default:
        return Colors.white70;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1116),
      body: SafeArea(
        child: Stack(
          children: [
            // Subtle background grid
            Positioned.fill(
              child: CustomPaint(
                painter: _GridPainter(),
              ),
            ),
            // Center glow
            Positioned.fill(
              child: Center(
                child: Container(
                  width: 900,
                  height: 900,
                  decoration: BoxDecoration(
                    gradient: RadialGradient(
                      colors: [
                        const Color(0xFF00FFE0).withOpacity(0.04),
                        Colors.transparent,
                      ],
                      radius: 0.7,
                    ),
                  ),
                ),
              ),
            ),
            // Top bar with title
            Positioned(
              top: 20,
              left: 24,
              right: 24,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text(
                        'AI Damage Detection',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Upload an image and let the AI analyze the damage.',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Center card
            Center(
              child: Container(
                width: 520,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(
                    color: Colors.white.withOpacity(0.1),
                    width: 1.2,
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _hasImage
                        ? _buildImagePreview(context)
                        : _buildUploadPrompt(context),
                    const SizedBox(height: 22),
                    _buildActionRow(context),
                    const SizedBox(height: 22),
                    _buildAnalysisSection(context),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUploadPrompt(BuildContext context) {
    return Column(
      children: [
        const Icon(
          Icons.cloud_upload,
          size: 60,
          color: Colors.white24,
        ),
        const SizedBox(height: 12),
        const Text(
          'Upload a vehicle image to begin analysis',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white70, fontSize: 16),
        ),
      ],
    );
  }

  Widget _buildImagePreview(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 220,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            color: Colors.white.withOpacity(0.08),
            border: Border.all(color: Colors.white10),
          ),
          child: const Center(
            child: Icon(
              Icons.image,
              size: 72,
              color: Colors.white24,
            ),
          ),
        ),
        if (_isProcessing)
          Positioned.fill(
            child: AnimatedBuilder(
              animation: _scanController,
              builder: (context, child) {
                final scanPosition = _scanController.value;
                return Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withOpacity(0.3),
                            Colors.black.withOpacity(0.6),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      left: scanPosition * 220 - 60,
                      top: 0,
                      bottom: 0,
                      child: Container(
                        width: 120,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              const Color(0xFF00FFE0).withOpacity(0.25),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: 160,
                            child: LinearProgressIndicator(
                              valueColor: const AlwaysStoppedAnimation(
                                  Color(0xFF00FFE0)),
                              backgroundColor: Colors.white12,
                              value: null,
                            ),
                          ),
                          const SizedBox(height: 16),
                          const Text(
                            'Analyzing...',
                            style: TextStyle(color: Colors.white70),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
      ],
    );
  }

  Widget _buildActionRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () {
              setState(() {
                _hasImage = true;
                _resultLevel = null;
              });
            },
            icon: const Icon(Icons.upload_file, color: Colors.black),
            label: const Text('Upload Image', style: TextStyle(color: Colors.black)),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () {
              setState(() {
                _hasImage = true;
                _resultLevel = null;
              });
            },
            icon: const Icon(Icons.camera_alt, color: Colors.black),
            label: const Text('Capture', style: TextStyle(color: Colors.black)),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAnalysisSection(BuildContext context) {
    if (!_hasImage) {
      return const SizedBox();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ElevatedButton(
          onPressed: _isProcessing ? null : _startAnalysis,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF00FFE0),
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
          child: Text(
            _isProcessing ? 'Analyzing...' : 'Analyze Damage',
            style: const TextStyle(color: Colors.black, fontSize: 16),
          ),
        ),
        const SizedBox(height: 18),
        if (_resultLevel != null)
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 600),
            transitionBuilder: (child, anim) => FadeTransition(
              opacity: anim,
              child: SlideTransition(
                position: Tween<Offset>(begin: const Offset(0, 0.08), end: Offset.zero).animate(anim),
                child: child,
              ),
            ),
            child: Column(
              key: ValueKey(_resultLevel),
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _buildResultCard(context),
                // --- Jordan Assistant Sections ---
                const SizedBox(height: 18),
                const RepairOptionsCard(),
                const SizedBox(height: 8),
                ResaleImpactCard(
                  impactLevel: _resultLevel == DamageLevel.high
                      ? 'HIGH'
                      : _resultLevel == DamageLevel.medium
                          ? 'MEDIUM'
                          : 'LOW',
                  explanation: _resultLevel == DamageLevel.high
                      ? 'Structural damage may reduce vehicle resale value by 10–18%.'
                      : _resultLevel == DamageLevel.medium
                          ? 'Some visible damage may slightly affect resale.'
                          : 'This damage is cosmetic and will not significantly affect resale value.',
                ),
                const SizedBox(height: 8),
                RepairTimeCard(
                  duration: _resultLevel == DamageLevel.high
                      ? '4–7 days'
                      : _resultLevel == DamageLevel.medium
                          ? '2–4 days'
                          : '1–2 days',
                  availability: _resultLevel == DamageLevel.high
                      ? 'Medium'
                      : _resultLevel == DamageLevel.medium
                          ? 'High'
                          : 'High',
                ),
                const SizedBox(height: 8),
                TravelSafetyCard(
                  status: _resultLevel == DamageLevel.high
                      ? 'Not safe to drive'
                      : _resultLevel == DamageLevel.medium
                          ? 'Long highway trips not recommended'
                          : 'Safe for city driving',
                ),
                const SizedBox(height: 8),
                RecommendedAreaCard(
                  area: _resultLevel == DamageLevel.high
                      ? 'Sahab Industrial Zone'
                      : _resultLevel == DamageLevel.medium
                          ? 'Marka Workshops'
                          : 'Irbid Industrial Area',
                  reason: _resultLevel == DamageLevel.high
                      ? 'Best availability of spare parts for this vehicle type.'
                      : _resultLevel == DamageLevel.medium
                          ? 'Many workshops specialize in moderate repairs.'
                          : 'Quick service and good prices for minor fixes.',
                ),
                const SizedBox(height: 8),
                MarketPriceCard(
                  minJOD: _resultLevel == DamageLevel.high ? 1200 : _resultLevel == DamageLevel.medium ? 400 : 100,
                  maxJOD: _resultLevel == DamageLevel.high ? 1800 : _resultLevel == DamageLevel.medium ? 700 : 250,
                  status: _resultLevel == DamageLevel.high
                      ? 'Within normal range'
                      : _resultLevel == DamageLevel.medium
                          ? 'Below average'
                          : 'Within normal range',
                ),
                const SizedBox(height: 8),
                NegotiationPotentialRow(
                  potential: _resultLevel == DamageLevel.high ? 'HIGH' : 'MEDIUM',
                  helperText: 'Typical repair shops may allow 10–15% negotiation.',
                ),
                if (_resultLevel == DamageLevel.high)
                  InspectionRiskCard(
                    text: 'Vehicle may fail annual licensing inspection if not repaired.',
                  ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildResultCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.06),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Damage Level: ',
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
              Text(
                _damageLabel,
                style: TextStyle(
                  color: _severityColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Text(
                'Confidence: ',
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
              Text(
                '${_confidence.toStringAsFixed(0)}%',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          const Text(
            'Suggested action:',
            style: TextStyle(color: Colors.white70, fontSize: 14),
          ),
          const SizedBox(height: 8),
          Text(
            _resultLevel == DamageLevel.high
                ? 'Schedule a full repair estimate and prioritize structural components.'
                : _resultLevel == DamageLevel.medium
                    ? 'Inspect panels and consider partial repair with replacement parts.'
                    : 'Minor cosmetic fixes recommended; full structural likely fine.',
            style: const TextStyle(color: Colors.white, fontSize: 14),
          ),
        ],
      ),
    );
  }
}

class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.025)
      ..strokeWidth = 0.5;
    const spacing = 40.0;
    for (double x = 0; x < size.width; x += spacing) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = 0; y < size.height; y += spacing) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
