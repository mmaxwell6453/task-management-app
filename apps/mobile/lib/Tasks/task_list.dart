import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mobile/Tasks/task_delete_btn.dart';

import 'package:mobile/TaskDirectories/task_directory.dart';

class TaskList extends StatefulWidget {
  final bool isEditing;

  const TaskList({super.key, required this.isEditing});

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  late Box<TaskDirectory> box;
  late TaskDirectory directory;

  @override
  void initState() {
    super.initState();

    box = Hive.box<TaskDirectory>('taskDirectories');

    directory = box.getAt(0)!;
  }

  void deleteTask(int taskIndex) {
    directory.taskList.removeAt(taskIndex);

    directory.save();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ReorderableListView.builder(
        itemCount: directory.taskList.length,

        onReorder: (oldIndex, newIndex) async {
          if (newIndex > oldIndex) {
            newIndex--;
          }

          final item = directory.taskList.removeAt(oldIndex);

          directory.taskList.insert(newIndex, item);

          await directory.save();

          setState(() {});
        },

        itemBuilder: (context, index) {
          final task = directory.taskList[index];

          return Card(
            key: ValueKey(index),

            elevation: 3,

            margin: const EdgeInsets.symmetric(vertical: 8),

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),

            child: ListTile(
              contentPadding: const EdgeInsets.all(16),

              leading: widget.isEditing
                  ? ReorderableDragStartListener(
                      index: index,
                      child: const Icon(Icons.drag_indicator),
                    )
                  : Checkbox(
                      value: task.isCompleted,
                      onChanged: (bool? value) {
                        setState(() {
                          task.isCompleted = value!;
                        });

                        directory.save();
                      },
                    ),

              title: Text(
                task.title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),

              trailing: widget.isEditing
                  ? TaskDeleteBtn(
                      task: task,
                      index: index,
                      deleteTask: deleteTask,
                    )
                  : null,
            ),
          );
        },
      ),
    );
  }
}
