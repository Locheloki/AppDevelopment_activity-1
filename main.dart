import 'package:flutter/material.dart';import 'package:flutter/material.dart';
import 'widgets/task_card.dart';
import 'widgets/icon_label.dart';

void main() => runApp(const TaskApp());

class TaskApp extends StatefulWidget {
  const TaskApp({super.key});

  @override
  State<TaskApp> createState() => _TaskAppState();
}

class _TaskAppState extends State<TaskApp> {
  bool _darkMode = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Demo',
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.teal,
          brightness: Brightness.dark,
        ),
      ),
      themeMode: _darkMode ? ThemeMode.dark : ThemeMode.light,
      home: TaskListPage(
        darkMode: _darkMode,
        toggleDarkMode: () => setState(() => _darkMode = !_darkMode),
      ),
    );
  }
}

class TaskListPage extends StatefulWidget {
  final bool darkMode;
  final VoidCallback toggleDarkMode;

  const TaskListPage({
    super.key,
    required this.darkMode,
    required this.toggleDarkMode,
  });

  @override
  State<TaskListPage> createState() => _TaskListPageState();
}

class _TaskListPageState extends State<TaskListPage> {
  final List<Map<String, String>> _tasks = [
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
        title: const Text('Tasks'),
        actions: [
          IconButton(
            onPressed: widget.toggleDarkMode,
            icon: Icon(widget.darkMode ? Icons.dark_mode : Icons.light_mode),
          ),
        ],
      ),
      body: ReorderableListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: _tasks.length,
        itemBuilder: (context, i) {
          final t = _tasks[i];
          return Dismissible(
            key: ValueKey(t['title']! + i.toString()),
            direction: DismissDirection.endToStart,
            background: Container(
              decoration: BoxDecoration(
                color: Colors.red.withOpacity(0.3),
                borderRadius: BorderRadius.circular(16),
              ),
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: const Icon(Icons.delete, color: Colors.white),
            ),
            onDismissed: (_) {
              setState(() => _tasks.removeAt(i));
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Task removed")),
              );
            },
            child: Container(
              key: ValueKey("task_$i"),
              margin: const EdgeInsets.symmetric(vertical: 6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.surface.withOpacity(0.7),
                    Theme.of(context).colorScheme.surface.withOpacity(0.4),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 6,
                    offset: const Offset(2, 4),
                  ),
                ],
              ),
              child: TaskCard(
                title: t['title']!,
                description: t['description']!,
                priority: t['priority']!,
                dueDate: t['dueDate'],
                assignee: t['assignee'],
              ),
            ),
          );
        },
        onReorder: (oldIndex, newIndex) {
          setState(() {
            if (newIndex > oldIndex) newIndex--;
            final task = _tasks.removeAt(oldIndex);
            _tasks.insert(newIndex, task);
          });
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openAddModal(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _openAddModal(BuildContext context) {
    String title = "";
    String description = "";
    String selectedPriority = "Medium";

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
                  TextField(
                    decoration: const InputDecoration(labelText: 'Title'),
                    onChanged: (val) => title = val,
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    maxLines: 2,
                    decoration:
                        const InputDecoration(labelText: 'Description'),
                    onChanged: (val) => description = val,
                  ),
                  const SizedBox(height: 12),
                  DropdownButton<String>(
                    value: selectedPriority,
                    items: ['High', 'Medium', 'Low']
                        .map((p) =>
                            DropdownMenuItem(value: p, child: Text(p)))
                        .toList(),
                    onChanged: (v) =>
                        setState(() => selectedPriority = v!),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () {
                      if (title.isNotEmpty && description.isNotEmpty) {
                        setState(() {
                          _tasks.add({
                            'title': title,
                            'description': description,
                            'priority': selectedPriority,
                            'dueDate': 'Soon',
                            'assignee': 'Me',
                          });
                        });
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text("Task added")),
                        );
                      }
                    },
                    child: const Text('Create'),
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            );
          },
        );
      },
    );
  }
}


