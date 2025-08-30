import 'package:flutter/material.dart';

class Progress extends StatelessWidget {
  const Progress({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Text('Percentual concuído:'),
        LinearProgressIndicator(value: 0.0),
      ],
    );
  }
}

class Task {
  final String label;
  bool isDone;
  Task({required this.label, this.isDone = false});
}

class TaskList extends StatelessWidget {
  final List<Task> tasks;
  const TaskList({super.key, required this.tasks});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: tasks.map((t) => TaskItem(label: t.label)).toList(),
    );
  }
}

class TaskItem extends StatefulWidget {
  final String label;
  const TaskItem({super.key, required this.label});
  @override
  _TaskItemState createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  bool? _value = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: _value,
          onChanged: (newValue) => setState(() => _value = newValue),
        ),
        Text(widget.label),
      ],
    );
  }
}