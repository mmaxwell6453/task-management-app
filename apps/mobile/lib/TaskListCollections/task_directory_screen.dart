import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:mobile/TaskListCollections/task_directory.dart';

class TaskDirectoryScreen extends StatefulWidget {
  const TaskDirectoryScreen({super.key});

  @override
  State<TaskDirectoryScreen> createState() => _TaskDirectoryScreenState();
}

class _TaskDirectoryScreenState extends State<TaskDirectoryScreen> {
  final TextEditingController controller = TextEditingController();
  final List<String> tasks = [];
  bool isEditing = false;

  final box = Hive.box<TaskDirectory>('taskDirectories');

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Spacer(),
            TextButton(
              onPressed: () {
                setState(() {
                  isEditing = !isEditing;
                });
              },
              child: Text(
                !isEditing ? 'Edit' : 'Done',
                textAlign: TextAlign.right,
              ),
            ),
          ],
        ),
        Spacer(),
        // TaskList(isEditing: isEditing),
        SafeArea(
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      hintText: "Add a New List...",
                      border: OutlineInputBorder(),
                    ),
                    textInputAction: TextInputAction.done,
                    onSubmitted: (value) {
                      if (value.isEmpty) return;
                      setState(() {
                        // box.add(TaskItem(title: value));
                        controller.clear();
                      });
                    },
                  ),
                ),
                SizedBox(width: 8),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    if (controller.text.isEmpty) return;
                    setState(() {
                      // box.add(TaskItem(title: controller.text));
                      controller.clear();
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
