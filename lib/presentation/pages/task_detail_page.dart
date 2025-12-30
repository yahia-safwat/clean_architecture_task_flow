import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/task.dart';
import '../bloc/task/task_bloc.dart';
import '../bloc/task/task_event.dart';
import 'task_form_page.dart';

class TaskDetailPage extends StatelessWidget {
  final Task task;
  const TaskDetailPage({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => TaskFormPage(task: task)),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              context.read<TaskBloc>().add(DeleteTaskEvent(task.id));
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  task.isCompleted
                      ? Icons.check_circle
                      : Icons.radio_button_unchecked,
                  color: task.isCompleted ? Colors.green : Colors.grey,
                  size: 32,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    task.title,
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      decoration: task.isCompleted
                          ? TextDecoration.lineThrough
                          : null,
                    ),
                  ),
                ),
              ],
            ),
            const Divider(height: 48),
            Text(
              'Description',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              task.description,
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}
