import 'package:flutter/material.dart';
import '../../domain/entities/task.dart';

class TaskTile extends StatelessWidget {
  final Task task;
  final VoidCallback onTap;
  final ValueChanged<bool?> onChecked;
  final VoidCallback onDelete;

  const TaskTile({
    super.key,
    required this.task,
    required this.onTap,
    required this.onChecked,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(task.id),
      direction: DismissDirection.endToStart,
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (_) => onDelete(),
      child: ListTile(
        title: Text(
          task.title,
          style: TextStyle(
            decoration: task.isCompleted ? TextDecoration.lineThrough : null,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          task.description,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        leading: Checkbox(
          value: task.isCompleted,
          onChanged: onChecked,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        ),
        trailing: const Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
