// lib/models/appointment.dart
class Appointment {
  final String id;
  final String title;
  final DateTime dateTime;
  final String location;

  Appointment({
    required this.id,
    required this.title,
    required this.dateTime,
    required this.location,
  });
}
