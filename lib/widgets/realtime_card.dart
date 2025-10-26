import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_state.dart';

class RealtimeCard extends StatelessWidget {
  const RealtimeCard({super.key});

  @override
  Widget build(BuildContext context) {
    final app = Provider.of<AppState>(context);
    final latest = app.heartSamples.isNotEmpty ? app.heartSamples.first.bpm : 0;

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            const Icon(Icons.favorite, color: Colors.redAccent, size: 36),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Current Heart Rate', style: TextStyle(fontSize: 16)),
                Text('$latest BPM',
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.redAccent)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
