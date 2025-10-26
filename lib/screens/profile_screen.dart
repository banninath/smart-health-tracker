import 'package:flutter/material.dart';
import '../models/user_profile.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final profile = UserProfile(
      id: '1',
      name: 'Alex Johnson',
      age: 27,
      gender: 'Male',
      heightCm: 175,
      weightKg: 68,
      email: 'alex@example.com',
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(profile.name, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('Age: ${profile.age} | Gender: ${profile.gender}'),
            Text('Height: ${profile.heightCm} cm | Weight: ${profile.weightKg} kg'),
            Text('Email: ${profile.email}'),
          ],
        ),
      ),
    );
  }
}
