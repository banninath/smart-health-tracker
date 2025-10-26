import 'dart:async';
import 'dart:math';

/// A mock sensor service that simulates real-time data like
/// heart rate and steps. You can replace it later with actual
/// sensor integrations (e.g., Google Fit, Wear OS, etc.)
class SensorService {
  Timer? _timer;
  bool _isRunning = false;
  final Random _random = Random();

  // Simulated data
  double _heartRate = 72.0;
  int _steps = 0;

  // Getters
  bool get isRunning => _isRunning;
  double get heartRate => _heartRate;
  int get steps => _steps;

  /// Starts generating simulated sensor data
  void start() {
    if (_isRunning) return; // Prevent multiple timers
    _isRunning = true;

    // Update every 2 seconds
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      // Simulate heart rate between 60–100 bpm
      _heartRate = 60 + _random.nextInt(40).toDouble();

      // Random step increments between 5–15
      _steps += 5 + _random.nextInt(10);

      // Debug print (you can remove this later)
      print('💓 Heart rate: $_heartRate bpm | 🦶 Steps: $_steps');
    });
  }

  /// Stops the simulated data stream
  void stop() {
    _timer?.cancel();
    _timer = null;
    _isRunning = false;
    print('⏹ Sensor service stopped');
  }

  /// Resets step count (optional)
  void resetSteps() {
    _steps = 0;
    print('🔁 Steps reset to zero');
  }
}
