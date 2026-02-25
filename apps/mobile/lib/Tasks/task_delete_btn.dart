import 'package:flutter/material.dart';

import 'package:mobile/TaskDirectories/task_directory.dart';

class TaskDeleteBtn extends StatelessWidget {
  final TaskItem task;
  final int index;
  final void Function(int index) deleteTask;
  const TaskDeleteBtn({
    super.key,
    required this.task,
    required this.index,
    required this.deleteTask,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.delete),
      color: Colors.red,
      onPressed: () async {
        final confirmed = await showDialog<bool>(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Delete Item'),
              content: const Text('Are you sure you want to delete this item?'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, false); // User canceled
                  },
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                  child: const Text('Delete'),
                ),
              ],
            );
          },
        );

        if (confirmed == true) {
          deleteTask(index);
        }
      },
    );
  }
}
