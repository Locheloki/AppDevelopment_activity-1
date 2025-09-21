import 'package:flutter/material.dart';
import 'icon_label.dart';

class TaskCard extends StatelessWidget {
  final String title;
  final String description;
  final String priority;
  final String? dueDate;
  final String? assignee;

  const TaskCard({
    super.key,
    required this.title,
    required this.description,
    required this.priority,
    this.dueDate,
    this.assignee,
  });

  @override
  Widget build(BuildContext context) {
    final color = priority.toLowerCase() == 'high'
        ? Colors.redAccent
        : priority.toLowerCase() == 'medium'
            ? Colors.orangeAccent
            : Colors.green;

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          )),
                ),
                IconLabel(icon: Icons.flag, label: priority, color: color),
              ],
            ),
            const SizedBox(height: 6),
            Text(description,
                maxLines: 2, overflow: TextOverflow.ellipsis),
            const SizedBox(height: 8),
            Row(
              children: [
                IconLabel(
                    icon: Icons.access_time,
                    label: dueDate ?? "No date",
                    color: color),
                const SizedBox(width: 12),
                IconLabel(
                    icon: Icons.person,
                    label: assignee ?? "Unassigned",
                    color: color),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
