import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_state.dart';
import '../widgets/add_activity_sheet.dart';

class ActivityLogScreen extends StatelessWidget {
  const ActivityLogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final app = Provider.of<AppState>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Activity Log')),
      body: ListView.builder(
        itemCount: app.activityLog.length,
        itemBuilder: (_, i) {
          final a = app.activityLog[i];
          return ListTile(
            title: Text(a.title),
            subtitle: Text('${a.notes}\n${a.date.toLocal()}'),
            isThreeLine: true,
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showModalBottomSheet(context: context, builder: (_) => const AddActivitySheet()),
        child: const Icon(Icons.add),
      ),
    );
  }
}
