import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/providers/task_provider.dart';
import 'package:todo_list/screens/task_form_screen.dart';
import 'package:todo_list/widgets/elevation_button.dart';
import 'package:todo_list/widgets/task_item.dart';

class TaskListScreen extends StatelessWidget {
  const TaskListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Lista de Tareas'),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const SizedBox(width: 10),
                  FilterButton(
                    label: 'Todas',
                    isSelected: taskProvider.filter == TaskFilter.all,
                    onPressed: () => taskProvider.setFilter(TaskFilter.all),
                  ),
                  const SizedBox(width: 10),
                  FilterButton(
                    label: 'Completadas',
                    isSelected: taskProvider.filter == TaskFilter.completed,
                    onPressed: () =>
                        taskProvider.setFilter(TaskFilter.completed),
                  ),
                  const SizedBox(width: 10),
                  FilterButton(
                    label: 'Pendientes',
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
            )
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.of(context).push(PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) =>
                  const TaskFormScreen(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                const begin = Offset(0.0, 1.0);
                const end = Offset.zero;
                const curve = Curves.ease;
                var tween = Tween(begin: begin, end: end)
                    .chain(CurveTween(curve: curve));
                var offsetAnimation = animation.drive(tween);

                return SlideTransition(
                  position: offsetAnimation,
                  child: TaskFormScreen(),
                );
              },
            ));
          },
          label: const Text(
            'Añadir tarea',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          icon: const Icon(Icons.add),
          backgroundColor: Colors.indigo,
          foregroundColor: Colors.white,
        ));
  }
}