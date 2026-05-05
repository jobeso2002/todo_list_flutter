import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/providers/task_provider.dart';
import 'package:todo_list/widgets/elevation_button.dart';
import 'package:todo_list/widgets/task_item.dart';

class TaskListScreen extends StatelessWidget {
  const TaskListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Lista de Tareas')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                const SizedBox(width: 10),
                FilterButton(
                  label: 'todas',
                  isSelected: taskProvider.filter == TaskFilter.all,
                  onPressed: () => taskProvider.setFilter(TaskFilter.all),
                ),
                const SizedBox(width: 10),
                FilterButton(
                  label: 'completadas',
                  isSelected: taskProvider.filter == TaskFilter.completed,
                  onPressed: () => taskProvider.setFilter(TaskFilter.completed),
                ),
                const SizedBox(width: 10),
                FilterButton(
                  label: 'pendientes',
                  isSelected: taskProvider.filter == TaskFilter.pending,
                  onPressed: () => taskProvider.setFilter(TaskFilter.pending),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: taskProvider.tasks.length,
              itemBuilder: (context, index) {
                final task = taskProvider.tasks[index];
                return TaskItem(task: task);
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add-task');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
