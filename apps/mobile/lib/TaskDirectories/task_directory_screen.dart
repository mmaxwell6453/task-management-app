import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:mobile/TaskDirectories/task_directory.dart';
import 'package:mobile/Tasks/task_list_view.dart';

class TaskDirectoryScreen extends StatefulWidget {
  const TaskDirectoryScreen({super.key});

  @override
  State<TaskDirectoryScreen> createState() => _TaskDirectoryScreenState();
}

class _TaskDirectoryScreenState extends State<TaskDirectoryScreen> {
  final TextEditingController controller = TextEditingController();
  bool isEditing = false;

  late Box<TaskDirectory> box;

  @override
  void initState() {
    super.initState();
    box = Hive.box<TaskDirectory>('taskDirectories');
  }

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
        TaskListView(
          type: "ListBtn",
          isEditing: isEditing,
          box: box,
          directory: "root",
        ),
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
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context, false),
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pop(context, true),
                                child: const Text('Add'),
                              ),
                            ],
                          );
                        },
                      );

                      if (!mounted) return;

                      if (confirmed == true && controller.text.isNotEmpty) {
                        final directory = box.get("root")!;

                        directory.lists.add(
                          TaskList(listTitle: controller.text),
                        );

                        await directory.save();

                        controller.clear();
                        setState(() {});
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
