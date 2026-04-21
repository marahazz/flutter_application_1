import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _darkMode = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('الإعدادات'), backgroundColor: Colors.black),
      backgroundColor: _darkMode ? const Color(0xFF181A20) : Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SwitchListTile(
              value: _darkMode,
              onChanged: (v) => setState(() => _darkMode = v),
              title: const Text('الوضع الليلي', style: TextStyle(fontWeight: FontWeight.bold)),
              secondary: const Icon(Icons.dark_mode),
            ),
            const SizedBox(height: 18),
            const Text('ملاحظة: الوضع الليلي تجريبي حالياً.'),
          ],
        ),
      ),
    );
  }
}
