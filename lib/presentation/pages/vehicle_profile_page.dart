import 'package:flutter/material.dart';
import '../../data/models/vehicle_profile.dart';

class VehicleProfilePage extends StatefulWidget {
  final void Function(VehicleProfile)? onSave;
  const VehicleProfilePage({super.key, this.onSave});

  @override
  State<VehicleProfilePage> createState() => _VehicleProfilePageState();
}

class _VehicleProfilePageState extends State<VehicleProfilePage> {
  final _formKey = GlobalKey<FormState>();
  String _brand = '';
  String _model = '';
  int _year = DateTime.now().year;
  int _mileage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Vehicle Profile'), backgroundColor: Colors.black),
      backgroundColor: const Color(0xFF181A20),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Car Brand'),
                onSaved: (v) => _brand = v ?? '',
                validator: (v) => v == null || v.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Model'),
                onSaved: (v) => _model = v ?? '',
                validator: (v) => v == null || v.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Year'),
                keyboardType: TextInputType.number,
                initialValue: _year.toString(),
                onSaved: (v) => _year = int.tryParse(v ?? '') ?? _year,
                validator: (v) => v == null || v.isEmpty ? 'Required' : null,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Mileage'),
                keyboardType: TextInputType.number,
                onSaved: (v) => _mileage = int.tryParse(v ?? '') ?? 0,
                validator: (v) => v == null || v.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.cyanAccent,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    _formKey.currentState?.save();
                    final profile = VehicleProfile(
                      brand: _brand,
                      model: _model,
                      year: _year,
                      mileage: _mileage,
                    );
                    widget.onSave?.call(profile);
                    Navigator.pop(context, profile);
                  }
                },
                child: const Text('Save Profile'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
