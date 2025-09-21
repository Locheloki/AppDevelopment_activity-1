import 'dart:ui';
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
            : Colors.greenAccent;

    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor.withOpacity(0.8),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.2),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: color.withOpacity(0.15),
                    foregroundColor: color,
                    child: Text(
                      _getInitials(assignee ?? "?"),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      title,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
                  Chip(
                    label: Text(priority,
                        style: const TextStyle(color: Colors.white)),
                    backgroundColor: color,
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                description,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  IconLabel(
                      icon: Icons.access_time,
                      label: dueDate ?? "No date",
                      color: color),
                  const SizedBox(width: 16),
                  IconLabel(
                      icon: Icons.person,
                      label: assignee ?? "Unassigned",
                      color: color),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  String _getInitials(String name) {
    final parts = name.split(" ");
    if (parts.length == 1) return parts[0][0];
    return (parts[0][0] + parts[1][0]).toUpperCase();
  }
}
