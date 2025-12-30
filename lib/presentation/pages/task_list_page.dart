import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/task/task_bloc.dart';
import '../bloc/task/task_event.dart';
import '../bloc/task/task_state.dart';
import '../widgets/task_tile.dart';
import 'task_form_page.dart';
import 'task_detail_page.dart';

class TaskListPage extends StatelessWidget {
  const TaskListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Tracker'),
        centerTitle: true,
        elevation: 0,
      ),
      body: BlocBuilder<TaskBloc, TaskState>(
        builder: (context, state) {
          if (state is TaskInitial) {
            context.read<TaskBloc>().add(LoadTasks());
            return const Center(child: CircularProgressIndicator());
          } else if (state is TaskLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TaskLoaded) {
            if (state.tasks.isEmpty) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.task_alt, size: 100, color: Colors.grey),
                    SizedBox(height: 16),
                    Text(
                      'No tasks yet! Add some.',
                      style: TextStyle(color: Colors.grey, fontSize: 18),
                    ),
                  ],
                ),
              );
            }
            return ListView.separated(
              itemCount: state.tasks.length,
              separatorBuilder: (context, index) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final task = state.tasks[index];
                return TaskTile(
                  task: task,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => TaskDetailPage(task: task),
                    ),
                  ),
                  onChecked: (value) {
                    context.read<TaskBloc>().add(
                      UpdateTaskEvent(
                        task.copyWith(isCompleted: value ?? false),
                      ),
                    );
                  },
                  onDelete: () {
                    context.read<TaskBloc>().add(DeleteTaskEvent(task.id));
                  },
                );
              },
            );
          } else if (state is TaskError) {
            return Center(child: Text('Error: ${state.message}'));
          }
          return const SizedBox.shrink();
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => const TaskFormPage()),
        ),
        label: const Text('Add Task'),
        icon: const Icon(Icons.add),
      ),
    );
  }
}
