import 'package:flutter/material.dart';
import 'widgets/task_card.dart';
import 'widgets/icon_label.dart';

void main() => runApp(const TaskApp());

class TaskApp extends StatelessWidget {
  const TaskApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Demo',
      theme: ThemeData(useMaterial3: true),
      home: const TaskListPage(),
    );
  }
}

class TaskListPage extends StatelessWidget {
  const TaskListPage({super.key});

  static final _demoTasks = [
    {
      'title': 'Finish Flutter Assignment',
      'description': 'Complete Week 2 widget fundamentals exercise.',
      'priority': 'High',
      'dueDate': 'Today',
      'assignee': 'Jimz Pogi',
    },
    {
      'title': 'Update Portfolio',
      'description': 'Add new PHP projects to personal website.',
      'priority': 'Medium',
      'dueDate': 'Tomorrow',
      'assignee': 'Reddrick Wow',
    },
    {
      'title': 'Read Research Paper',
      'description': 'Review paper on UI/UX best practices.',
      'priority': 'Low',
      'dueDate': 'Friday',
      'assignee': 'Jasper Jelly Bean',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tasks')),
      body: ListView.separated(
        padding: const EdgeInsets.all(12),
        itemCount: _demoTasks.length,
        separatorBuilder: (_, __) => const SizedBox(height: 8),
        itemBuilder: (context, i) {
          final t = _demoTasks[i];
          return TaskCard(
            title: t['title']!,
            description: t['description']!,
            priority: t['priority']!,
            dueDate: t['dueDate'],
            assignee: t['assignee'],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openAddModal(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _openAddModal(BuildContext context) {
    String? selectedPriority = 'High';
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                top: 16,
                left: 16,
                right: 16,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Add Task',
                      style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 12),
                  const TextField(
                    decoration: InputDecoration(
                      labelText: 'Title',
                      hintText: 'Weekly sync notes',
                    ),
                  ),
                  const SizedBox(height: 8),
                  const TextField(
                    maxLines: 2,
                    decoration: InputDecoration(labelText: 'Description'),
                  ),
                  const SizedBox(height: 12),
                  DropdownButton<String>(
                    value: selectedPriority,
                    items: ['High', 'Medium', 'Low']
                        .map((p) => DropdownMenuItem(
                              value: p,
                              child: Text(p),
                            ))
                        .toList(),
                    onChanged: (v) =>
                        setState(() => selectedPriority = v!),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('(UI-only) Task created'),
                        ),
                      );
                    },
                    child: const Text('Create'),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
