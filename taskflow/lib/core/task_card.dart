import 'package:flutter/material.dart';
import 'package:taskflow/domain/task.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({super.key, required this.task});

  final Task task;

  @override
  Widget build(BuildContext context) {
    final status = task.isCompleted ? 'Concluída' : 'Pendente';
    final statusColor = task.isCompleted ? Colors.green : Colors.orange;
    final statusIcon = task.isCompleted ? Icons.check_circle : Icons.pending;

    return Card(
      child: ListTile(
        leading: Icon(statusIcon, color: statusColor),
        title: Text(task.title),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(task.description),
            const SizedBox(height: 4),
            Text(
              status,
              style: TextStyle(color: statusColor, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
