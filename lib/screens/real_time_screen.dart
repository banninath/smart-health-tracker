import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_state.dart';

class RealTimeScreen extends StatelessWidget {
  const RealTimeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final app = Provider.of<AppState>(context);
    final samples = app.heartSamples.take(10).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Real-Time Monitoring')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: samples
            .map((s) => ListTile(
                  leading: const Icon(Icons.favorite, color: Colors.redAccent),
                  title: Text('BPM: ${s.bpm}'),
                  subtitle: Text(s.timestamp.toLocal().toString()),

                ))
            .toList(),
      ),
    );
  }
}
