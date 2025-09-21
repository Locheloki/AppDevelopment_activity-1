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
