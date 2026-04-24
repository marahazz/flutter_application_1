// 🚗 Step 1: Car Information Screen
// Allows users to select car brand and model

// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CarInfoScreen extends StatefulWidget {
  const CarInfoScreen({super.key});

  @override
  State<CarInfoScreen> createState() => _CarInfoScreenState();
}

class _CarInfoScreenState extends State<CarInfoScreen> {
  // Car brands list
  final List<String> _carBrands = [
    'Toyota',
    'BMW',
    'Mercedes',
    'Hyundai',
    'Honda',
    'Ford',
    'Chevrolet',
    'Nissan',
    'Audi',
    'Volkswagen',
  ];

  // Models for each brand
  final Map<String, List<String>> _carModels = {
    'Toyota': ['Camry', 'Corolla', 'RAV4', 'Land Cruiser', 'Prius'],
    'BMW': ['3 Series', '5 Series', 'X3', 'X5', '7 Series'],
    'Mercedes': ['C-Class', 'E-Class', 'GLC', 'GLE', 'S-Class'],
    'Hyundai': ['Elantra', 'Sonata', 'Tucson', 'Santa Fe', 'Genesis'],
    'Honda': ['Civic', 'Accord', 'CR-V', 'Pilot', 'HR-V'],
    'Ford': ['F-150', 'Mustang', 'Explorer', 'Escape', 'Bronco'],
    'Chevrolet': ['Malibu', 'Equinox', 'Tahoe', 'Silverado', 'Camaro'],
    'Nissan': ['Altima', 'Rogue', 'Sentra', 'Maxima', 'Pathfinder'],
    'Audi': ['A3', 'A4', 'Q3', 'Q5', 'A6'],
    'Volkswagen': ['Jetta', 'Passat', 'Tiguan', 'Atlas', 'Golf'],
  };

  String? _selectedBrand;
  String? _selectedModel;
  final TextEditingController _modelController = TextEditingController();

  bool get _isValid => _selectedBrand != null && _selectedModel != null;

  @override
  void dispose() {
    _modelController.dispose();
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
          onPressed: () => context.go('/'),
        ),
        title: const Text(
          'Step 1 of 4',
          style: TextStyle(
            color: Colors.white70,
            fontSize: 14,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 📌 Title
              const Text(
                'Car Information',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'Select your vehicle details',
                style: TextStyle(
                  color: Colors.white60,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 40),

              // 🚗 Car Brand Dropdown
              _buildLabel('Car Brand'),
              const SizedBox(height: 12),
              _buildDropdown(
                value: _selectedBrand,
                hint: 'Select brand',
                items: _carBrands,
                icon: Icons.directions_car,
                onChanged: (value) {
                  setState(() {
                    _selectedBrand = value;
                    _selectedModel = null;
                    _modelController.clear();
                  });
                },
              ),
              const SizedBox(height: 24),

              // 🔧 Car Model
              _buildLabel('Car Model'),
              const SizedBox(height: 12),
              _buildModelSelector(),
              const SizedBox(height: 40),

              // Spacer
              const Spacer(),

              // ➡️ Next Button
              _buildNextButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.white70,
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildDropdown({
    required String? value,
    required String hint,
    required List<String> items,
    required IconData icon,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A2E),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
        ),
      ),
      child: DropdownButtonFormField<String>(
        value: value,
        hint: Row(
          children: [
            Icon(icon, color: Colors.white54, size: 22),
            const SizedBox(width: 12),
            Text(
              hint,
              style: const TextStyle(color: Colors.white54),
            ),
          ],
        ),
        dropdownColor: const Color(0xFF1A1A2E),
        icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white54),
        decoration: const InputDecoration(
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        ),
        style: const TextStyle(color: Colors.white, fontSize: 16),
        items: items.map((brand) {
          return DropdownMenuItem(
            value: brand,
            child: Row(
              children: [
                Icon(Icons.directions_car, color: Colors.white54, size: 20),
                const SizedBox(width: 12),
                Text(brand),
              ],
            ),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildModelSelector() {
    final hasPredefinedModels = _selectedBrand != null &&
        _carModels.containsKey(_selectedBrand!) &&
        _carModels[_selectedBrand!]!.isNotEmpty;

    if (hasPredefinedModels) {
      return Container(
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A2E),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Colors.white.withOpacity(0.1),
          ),
        ),
        child: DropdownButtonFormField<String>(
          value: _selectedModel,
          hint: Row(
            children: [
              const Icon(Icons.settings, color: Colors.white54, size: 22),
              const SizedBox(width: 12),
              const Text(
                'Select model',
                style: TextStyle(color: Colors.white54),
              ),
            ],
          ),
          dropdownColor: const Color(0xFF1A1A2E),
          icon: const Icon(Icons.keyboard_arrow_down, color: Colors.white54),
          decoration: const InputDecoration(
            border: InputBorder.none,
            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          ),
          style: const TextStyle(color: Colors.white, fontSize: 16),
          items: _carModels[_selectedBrand]!.map((model) {
            return DropdownMenuItem(
              value: model,
              child: Row(
                children: [
                  const Icon(Icons.settings, color: Colors.white54, size: 20),
                  const SizedBox(width: 12),
                  Text(model),
                ],
              ),
            );
          }).toList(),
          onChanged: (value) {
            setState(() {
              _selectedModel = value;
            });
          },
        ),
      );
    }

    // Custom text input if no predefined models
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF1A1A2E),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.white.withOpacity(0.1),
        ),
      ),
      child: TextField(
        controller: _modelController,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: 'Enter model',
          hintStyle: const TextStyle(color: Colors.white54),
          prefixIcon: const Icon(Icons.settings, color: Colors.white54),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        ),
        onChanged: (value) {
          setState(() {
            _selectedModel = value.isNotEmpty ? value : null;
          });
        },
      ),
    );
  }

  Widget _buildNextButton() {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: _isValid
            ? () {
                // Store car info and navigate to next step
                context.go('/damage-capture');
              }
            : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: _isValid
              ? const Color(0xFF00E676)
              : Colors.white.withOpacity(0.1),
          disabledBackgroundColor: Colors.white.withOpacity(0.05),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Next',
              style: TextStyle(
                color: _isValid ? Colors.black : Colors.white30,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 8),
            Icon(
              Icons.arrow_forward,
              color: _isValid ? Colors.black : Colors.white30,
            ),
          ],
        ),
      ),
    );
  }
}