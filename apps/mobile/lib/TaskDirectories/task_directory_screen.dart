import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:mobile/TaskDirectories/task_directory.dart';

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
            TextButton(onPressed: () {}, child: Text('Settings')),
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
                  child: TextButton(
                    onPressed: () async {
                      final confirmed = await showDialog<bool>(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Add a List'),
                            content: TextField(
                              controller: controller,

                              decoration: const InputDecoration(
                                hintText: "Enter a List title...",
                                border: OutlineInputBorder(),
                              ),

                              textInputAction: TextInputAction.done,

                              onSubmitted: (value) {
                                if (value.isEmpty) return;

                                setState(() {
                                  // **TODO: Add a new list here**
                                  // directory.taskList.add(TaskItem(title: value));

                                  // directory.save();

                                  controller.clear();
                                });
                              },
                            ),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(
                                    context,
                                    false,
                                  ); // User canceled
                                },
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context, true);
                                  controller.clear();
                                },
                                child: const Text('Add'),
                              ),
                            ],
                          );
                        },
                      );

                      if (confirmed == true) {
                        // deleteTask(index);
                      }
                    },
                    child: Text('+ List'),
                  ),
                ),
                Expanded(
                  child: TextButton(
                    onPressed: () {},
                    child: Text('+ List Directory'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
