import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_state.dart';
import '../screens/activity_log_screen.dart';

class ActivityLogPreview extends StatelessWidget {
  const ActivityLogPreview({super.key});

  @override
  Widget build(BuildContext context) {
    final app = Provider.of<AppState>(context);
    final recent = app.activityLog.take(2).toList();

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Text('Recent Activities', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const Spacer(),
                TextButton(
                  onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ActivityLogScreen())),
                  child: const Text('View All'),
                ),
              ],
            ),
            const SizedBox(height: 8),
            if (recent.isEmpty)
              const Text('No activities yet!')
            else
              ...recent.map((a) => ListTile(title: Text(a.title), subtitle: Text(a.notes))),
          ],
        ),
      ),
    );
  }
}
