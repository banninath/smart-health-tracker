// lib/screens/appointments_screen.dart
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/appointment.dart';
import 'package:intl/intl.dart';

class AppointmentsScreen extends StatefulWidget {
  const AppointmentsScreen({super.key});

  @override
  State<AppointmentsScreen> createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  DateTime? _selectedDate;
  final List<Appointment> _appointments = [];
  final Uuid _uuid = const Uuid();

  @override
  void dispose() {
    _titleController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  Future<void> _pickDateTime() async {
    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (date == null) return;

    final TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay(hour: 9, minute: 0),
    );
    if (time == null) return;

    setState(() {
      _selectedDate = DateTime(date.year, date.month, date.day, time.hour, time.minute);
    });
  }

  void _addAppointment() {
    final title = _titleController.text.trim();
    final location = _locationController.text.trim().isEmpty ? 'Not specified' : _locationController.text.trim();

    if (title.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Enter a title')));
      return;
    }
    if (_selectedDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Pick a date and time')));
      return;
    }

    setState(() {
      _appointments.add(
        Appointment(
          id: _uuid.v4(),               // <-- required id
          title: title,                // <-- required title
          dateTime: _selectedDate!,    // <-- required dateTime
          location: location,          // <-- required location
        ),
      );
      // Clear inputs
      _titleController.clear();
      _locationController.clear();
      _selectedDate = null;
    });
  }

  void _removeAppointmentAt(int index) {
    setState(() {
      _appointments.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Appointments')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Appointment title'),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _locationController,
              decoration: const InputDecoration(labelText: 'Location (optional)'),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                ElevatedButton.icon(
                  onPressed: _pickDateTime,
                  icon: const Icon(Icons.calendar_today),
                  label: const Text('Pick date & time'),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    _selectedDate == null ? 'No date chosen' : DateFormat('d MMM, yyyy • h:mm a').format(_selectedDate!),
                    style: const TextStyle(fontSize: 14),
                  ),
                )
              ],
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: _addAppointment,
              icon: const Icon(Icons.add),
              label: const Text('Add Appointment'),
              style: ElevatedButton.styleFrom(minimumSize: const Size.fromHeight(44)),
            ),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 8),
            Expanded(
              child: _appointments.isEmpty
                  ? const Center(child: Text('No appointments yet'))
                  : ListView.builder(
                      itemCount: _appointments.length,
                      itemBuilder: (context, index) {
                        final a = _appointments[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 6),
                          child: ListTile(
                            title: Text(a.title),
                            subtitle: Text('${DateFormat('d MMM, yyyy • h:mm a').format(a.dateTime)}\n${a.location}'),
                            isThreeLine: true,
                            trailing: IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () => _removeAppointmentAt(index),
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
