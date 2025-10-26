import 'package:flutter/material.dart';
import '../models/appointment.dart';
import 'package:intl/intl.dart';

class AppointmentsPreview extends StatelessWidget {
  final Appointment appointment;
  final VoidCallback onDelete;

  const AppointmentsPreview({
    super.key,
    required this.appointment,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text(appointment.title),
        subtitle: Text(
          '${DateFormat.yMMMd().format(appointment.dateTime)} at ${appointment.location}',
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: onDelete,
        ),
      ),
    );
  }
}
