// ignore_for_file: deprecated_member_use, unused_field

import 'package:flutter/material.dart';

class QuoteRequestPage extends StatefulWidget {
  final String damageSummary;
  const QuoteRequestPage({super.key, required this.damageSummary});

  @override
  State<QuoteRequestPage> createState() => _QuoteRequestPageState();
}

class _QuoteRequestPageState extends State<QuoteRequestPage> {
  final _formKey = GlobalKey<FormState>();
  String _notes = '';
  bool _submitted = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Request Quote'), backgroundColor: Colors.black),
      backgroundColor: const Color(0xFF181A20),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          transitionBuilder: (child, anim) => FadeTransition(
            opacity: anim,
            child: SlideTransition(
              position: Tween<Offset>(begin: const Offset(0, 0.08), end: Offset.zero).animate(anim),
              child: child,
            ),
          ),
          child: _submitted
              ? Center(
                  key: const ValueKey('submitted'),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(Icons.check_circle, color: Colors.cyanAccent, size: 60),
                      SizedBox(height: 18),
                      Text('Quote request submitted!', style: TextStyle(color: Colors.white, fontSize: 18)),
                    ],
                  ),
                )
              : SingleChildScrollView(
                  key: const ValueKey('form'),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Damage Summary:', style: TextStyle(color: Colors.white70, fontSize: 15)),
                      const SizedBox(height: 8),
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(widget.damageSummary, style: const TextStyle(color: Colors.white, fontSize: 15)),
                      ),
                      const SizedBox(height: 24),
                      Form(
                        key: _formKey,
                        child: TextFormField(
                          decoration: InputDecoration(
                            labelText: 'Additional Notes (optional)',
                            labelStyle: const TextStyle(color: Colors.white54),
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.04),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.white.withOpacity(0.10)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: const BorderSide(color: Colors.cyanAccent),
                            ),
                          ),
                          style: const TextStyle(color: Colors.white),
                          onSaved: (v) => _notes = v ?? '',
                          maxLines: 3,
                        ),
                      ),
                      const SizedBox(height: 32),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.cyanAccent,
                            foregroundColor: Colors.black,
                            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                          ),
                          onPressed: () {
                            _formKey.currentState?.save();
                            setState(() => _submitted = true);
                          },
                          child: const Text('Submit Quote Request'),
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
