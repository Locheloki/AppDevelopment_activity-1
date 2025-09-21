import 'package:flutter/material.dart';
import 'widgets/task_card.dart';
import 'widgets/icon_label.dart';

void main() => runApp(const TaskApp());

class TaskApp extends StatelessWidget {
  const TaskApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Poppy Task Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.purple,
          brightness: Brightness.light,
        ),
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
      ),
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
      appBar: AppBar(
        title: const Text("✨ Poppy Tasks ✨"),
        centerTitle: true,
        backgroundColor: Colors.purpleAccent,
        foregroundColor: Colors.white,
        elevation: 4,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: _demoTasks.length,
        separatorBuilder: (_, __) => const SizedBox(height: 12),
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _openAddModal(context),
        label: const Text("Add Task"),
        icon: const Icon(Icons.add),
        backgroundColor: Colors.pinkAccent,
      ),
    );
  }

  void _openAddModal(BuildContext context) {
    String? selectedPriority = 'High';
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                top: 20,
                left: 20,
                right: 20,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text("🌈 Create a Poppy Task",
                      style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 16),
                  const TextField(
                    decoration: InputDecoration(
                      labelText: 'Title',
                      hintText: 'e.g. Weekly sync notes',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 12),
                  const TextField(
                    maxLines: 2,
                    decoration: InputDecoration(
                      labelText: 'Description',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    value: selectedPriority,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Priority",
                    ),
                    items: ['High', 'Medium', 'Low']
                        .map((p) => DropdownMenuItem(
                              value: p,
                              child: Text(p),
                            ))
                        .toList(),
                    onChanged: (v) => setState(() => selectedPriority = v!),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.purpleAccent,
                      minimumSize: const Size.fromHeight(50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('🎉 (UI-only) Task created!'),
                          backgroundColor: Colors.pinkAccent,
                        ),
                      );
                    },
                    child: const Text("Add Task",
                        style: TextStyle(color: Colors.white)),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
