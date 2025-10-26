// lib/screens/dashboard.dart
import 'package:flutter/material.dart';
import '../widgets/app_drawer.dart';
import '../widgets/welcome_card.dart';
import '../widgets/realtime_card.dart';
import '../widgets/goals_card.dart';
import '../widgets/activity_log_preview.dart';
import '../widgets/appointments_preview.dart';
import 'package:provider/provider.dart';
import '../providers/app_state.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final app = Provider.of<AppState>(context);

    // start sensor and add mock data if empty (optional)
    app.startSensor();
    if (app.goals.isEmpty && app.activityLog.isEmpty && app.appointments.isEmpty) {
      app.addMockData();
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        actions: [
          if (app.syncing)
            const Padding(
              padding: EdgeInsets.all(8),
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          IconButton(icon: const Icon(Icons.sync), onPressed: () => app.syncNow()),
        ],
      ),
      drawer: const AppDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const WelcomeCard(),
            const SizedBox(height: 12),
            const RealtimeCard(),
            const SizedBox(height: 12),

            // >>> Dynamic Goals section (maps app.goals to GoalsCard widgets)
            if (app.goals.isEmpty)
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      const Icon(Icons.flag, color: Colors.teal),
                      const SizedBox(width: 12),
                      Expanded(
                          child:
                              Text('No goals yet. Tap Goals in the drawer to add one.')),
                    ],
                  ),
                ),
              )
            else
              Column(
                children: app.goals.asMap().entries.map((entry) {
                  final index = entry.key;
                  final goal = entry.value;
                  return GoalsCard(
                    goal: goal,
                    onDelete: () => app.deleteGoal(index),
                  );
                }).toList(),
              ),

            const SizedBox(height: 12),
            const ActivityLogPreview(),
            const SizedBox(height: 12),

            // >>> Dynamic Appointments section
            Column(
              children: app.appointments.asMap().entries.map((entry) {
                final index = entry.key;
                final appointment = entry.value;
                return AppointmentsPreview(
                  appointment: appointment,
                  onDelete: () => app.deleteAppointment(index),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
