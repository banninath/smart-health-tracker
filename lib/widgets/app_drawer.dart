import 'package:flutter/material.dart';
import '../screens/activity_log_screen.dart';
import '../screens/real_time_screen.dart';
import '../screens/goals_screen.dart';
import '../screens/appointments_screen.dart';
import '../screens/profile_screen.dart';
import '../screens/notifications_screen.dart';
import '../screens/settings_screen.dart';
import '../screens/dashboard.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.teal),
            child: Center(
              child: Text('Smart Wearable Tracker',
                  style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
            ),
          ),
          _tile(context, Icons.dashboard, 'Dashboard', const DashboardScreen()),
          _tile(context, Icons.favorite, 'Real-Time', const RealTimeScreen()),
          _tile(context, Icons.flag, 'Goals', const GoalsScreen()),
          _tile(context, Icons.fitness_center, 'Activity Log', const ActivityLogScreen()),
          _tile(context, Icons.calendar_month, 'Appointments', const AppointmentsScreen()),
          _tile(context, Icons.person, 'Profile', const ProfileScreen()),
          _tile(context, Icons.notifications, 'Notifications', const NotificationsScreen()),
          _tile(context, Icons.settings, 'Settings', const SettingsScreen()),
        ],
      ),
    );
  }

  ListTile _tile(BuildContext ctx, IconData icon, String title, Widget page) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {
        Navigator.pop(ctx);
        Navigator.push(ctx, MaterialPageRoute(builder: (_) => page));
      },
    );
  }
}
