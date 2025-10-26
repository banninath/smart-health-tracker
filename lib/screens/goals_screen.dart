import 'package:flutter/material.dart';
import '../models/goal.dart';
import '../widgets/goals_card.dart';
import 'package:uuid/uuid.dart';

class GoalsScreen extends StatefulWidget {
  const GoalsScreen({super.key});

  @override
  State<GoalsScreen> createState() => _GoalsScreenState();
}

final uuid = const Uuid();

class _GoalsScreenState extends State<GoalsScreen> {
  final TextEditingController _goalController = TextEditingController();
  final List<Goal> _goals = [];

  void _addGoal() {
    if (_goalController.text.isNotEmpty) {
      setState(() {
        _goals.add(
          Goal(
            id: uuid.v4(),
            title: _goalController.text,
            target: 100,
            progress: 0,
          ),
        );
        _goalController.clear();
      });
    }
  }

  void _removeGoal(int index) {
    setState(() => _goals.removeAt(index));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Goals")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _goalController,
              decoration: InputDecoration(
                labelText: "Enter new goal",
                suffixIcon: IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: _addGoal,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _goals.length,
                itemBuilder: (context, index) {
                  final goal = _goals[index];
                  return GoalsCard(
                    goal: goal,
                    onDelete: () => _removeGoal(index),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
