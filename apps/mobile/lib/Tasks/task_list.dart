import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:mobile/Tasks/task_delete_btn.dart';

import 'package:mobile/Tasks/task_item.dart';

class TaskList extends StatefulWidget {
  final bool isEditing;
  const TaskList({super.key, required this.isEditing});

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  final box = Hive.box<TaskItem>('todoBox');

  void onDeletePressed(TaskItem task) {
    task.delete();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ReorderableListView.builder(
        itemCount: box.length,
        onReorder: (oldIndex, newIndex) async {
          if (newIndex > oldIndex) {
            newIndex -= 1;
          }

          final taskList = box.values.toList();
          final item = taskList.removeAt(oldIndex);
          taskList.insert(newIndex, item);

          // Clear and rewrite Hive box in new order
          await box.clear();
          await box.addAll(taskList);

          setState(() {});
        },
        itemBuilder: (context, index) {
          final task = box.getAt(index);
          return Card(
            key: ValueKey(task!.key), // VERY IMPORTANT
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
                        task.save();
                      },
                    ),
              title: Text(
                task.title,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              trailing: widget.isEditing
                  ? TaskDeleteBtn(task: task, onDeletePressed: onDeletePressed)
                  : null,
            ),
          );
        },
      ),
    );
  }
}
