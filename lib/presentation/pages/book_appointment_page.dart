import 'package:flutter/material.dart';

class BookAppointmentPage extends StatefulWidget {
  final String workshopName;
  const BookAppointmentPage({super.key, required this.workshopName});

  @override
  State<BookAppointmentPage> createState() => _BookAppointmentPageState();
}

class _BookAppointmentPageState extends State<BookAppointmentPage> {
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  bool _confirmed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('حجز موعد'), backgroundColor: Colors.black),
      backgroundColor: const Color(0xFF181A20),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: _confirmed
            ? Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.check_circle, color: Colors.cyanAccent, size: 60),
                    const SizedBox(height: 18),
                    Text('تم حجز الموعد بنجاح!', style: const TextStyle(color: Colors.white, fontSize: 18)),
                  ],
                ),
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('الورشة: ${widget.workshopName}', style: const TextStyle(color: Colors.cyanAccent, fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 18),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.date_range),
                    label: Text(_selectedDate == null ? 'اختر التاريخ' : '${_selectedDate!.year}/${_selectedDate!.month}/${_selectedDate!.day}'),
                    onPressed: () async {
                      final picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime.now().add(const Duration(days: 60)),
                      );
                      if (picked != null) setState(() => _selectedDate = picked);
                    },
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.access_time),
                    label: Text(_selectedTime == null ? 'اختر الوقت' : _selectedTime!.format(context)),
                    onPressed: () async {
                      final picked = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (picked != null) setState(() => _selectedTime = picked);
                    },
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.cyanAccent,
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                      ),
                      onPressed: _selectedDate != null && _selectedTime != null
                          ? () => setState(() => _confirmed = true)
                          : null,
                      child: const Text('تأكيد الحجز'),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
