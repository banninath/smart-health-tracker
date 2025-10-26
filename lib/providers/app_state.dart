import 'dart:async';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import '../models/activity_entry.dart';
import '../models/goal.dart';
import '../models/appointment.dart';
import '../models/heart_rate_sample.dart';
import '../services/sensor_service.dart';

class AppState extends ChangeNotifier {
  final SensorService _sensorService = SensorService();
  final Uuid _uuid = const Uuid();

  // ------------------ APP STATE ------------------
  bool syncing = false;
  bool _isDarkMode = false;
  bool get isDarkMode => _isDarkMode;

  // ------------------ DATA ------------------
  List<Goal> goals = [];
  List<ActivityEntry> activityLog = [];
  List<Appointment> appointments = [];
  List<HeartRateSample> _heartSamples = [];

  List<HeartRateSample> get heartSamples => _heartSamples;
void deleteGoal(int index) {
  if (index >= 0 && index < goals.length) {
    goals.removeAt(index);
    notifyListeners();
  }
}
void deleteAppointment(int index) {
  if (index >= 0 && index < appointments.length) {
    appointments.removeAt(index);
    notifyListeners();
  }
}


  // ------------------ SENSOR ------------------
  void startSensor() {
    _sensorService.start();
    // Generate fake heart rate samples every 3 seconds
    Timer.periodic(const Duration(seconds: 3), (timer) {
      if (!_sensorService.isRunning) timer.cancel();
      addHeartSample(_sensorService.heartRate);
    });
  }

  void stopSensor() {
    _sensorService.stop();
  }

  void addHeartSample(double bpm) {
    _heartSamples.insert(
      0,
      HeartRateSample(bpm: bpm, timestamp: DateTime.now()),
    );
    if (_heartSamples.length > 50) _heartSamples.removeLast();
    notifyListeners();
  }

  // ------------------ GOALS ------------------
  void addGoal(String title, double target, double progress) {
    goals.insert(0, Goal(id: _uuid.v4(), title: title, target: target, progress: progress));
    notifyListeners();
  }

  // ------------------ APPOINTMENTS ------------------
  void addAppointment(String title, DateTime dateTime, String location) {
    appointments.insert(
      0,
      Appointment(id: _uuid.v4(), title: title, dateTime: dateTime, location: location),
    );
    notifyListeners();
  }

  // ------------------ ACTIVITIES ------------------
  void addActivity(String title, String notes) {
    activityLog.insert(
      0,
      ActivityEntry(id: _uuid.v4(), title: title, notes: notes, date: DateTime.now()),
    );
    notifyListeners();
  }

  // ------------------ MOCK DATA ------------------
  void addMockData() {
    goals = [
      Goal(id: _uuid.v4(), title: "Run 5km", target: 5, progress: 2.5),
      Goal(id: _uuid.v4(), title: "Drink 2L Water", target: 2, progress: 1.5),
    ];

    activityLog = [
      ActivityEntry(id: _uuid.v4(), title: "Morning Jog", notes: "Ran around park", date: DateTime.now()),
      ActivityEntry(id: _uuid.v4(), title: "Yoga", notes: "30 min relaxation", date: DateTime.now()),
    ];

    appointments = [
      Appointment(id: _uuid.v4(), title: "Doctor Visit", dateTime: DateTime.now().add(const Duration(days: 2)), location: "City Clinic"),
    ];

    notifyListeners();
  }

  // ------------------ SYNCING ------------------
  Future<void> syncNow() async {
    syncing = true;
    notifyListeners();
    await Future.delayed(const Duration(seconds: 2));
    syncing = false;
    notifyListeners();
  }

  // ------------------ THEME ------------------
  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
}
