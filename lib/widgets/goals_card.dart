// lib/widgets/goals_card.dart
import 'package:flutter/material.dart';
import '../models/goal.dart';

class GoalsCard extends StatelessWidget {
  final Goal goal;
  final VoidCallback onDelete;

  const GoalsCard({super.key, required this.goal, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text(goal.title),
        subtitle: LinearProgressIndicator(value: (goal.progress / (goal.target == 0 ? 1 : goal.target)).clamp(0.0, 1.0)),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: onDelete,
        ),
      ),
    );
  }
}
