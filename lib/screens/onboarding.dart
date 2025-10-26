import 'package:flutter/material.dart';
import 'login_signup.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.watch, size: 100, color: Colors.teal),
            const SizedBox(height: 20),
            const Text("Track your health smarter", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            const Text("Monitor heart rate, log workouts, and manage goals — all in one app.",
                textAlign: TextAlign.center, style: TextStyle(fontSize: 16)),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginSignupScreen())),
              icon: const Icon(Icons.arrow_forward),
              label: const Text("Get Started"),
              style: ElevatedButton.styleFrom(minimumSize: const Size(double.infinity, 50)),
            ),
          ],
        ),
      ),
    );
  }
}
