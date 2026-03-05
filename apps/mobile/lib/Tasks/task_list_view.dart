import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
// import 'package:mobile/Tasks/task_delete_btn.dart';

import 'package:mobile/TaskDirectories/task_directory.dart';
import 'package:mobile/Tasks/selected_task_list.dart';

class TaskListView extends StatefulWidget {
  final String type;
  final bool isEditing;
  final Box<TaskDirectory> box;
  final String directory;

  const TaskListView({
    super.key,
    required this.type,
    required this.isEditing,
    required this.box,
    required this.directory,
  });

  @override
  State<TaskListView> createState() => _TaskListViewState();
}

class _TaskListViewState extends State<TaskListView> {
  late Box<TaskDirectory> box;

  @override
  void initState() {
    super.initState();

    box = widget.box;
  }

  void deleteTask(int taskIndex) {
    // directory.taskList.removeAt(taskIndex);

    // directory.save();

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final directory = box.get(widget.directory)!;
    final lists = directory.lists;
    return Expanded(
      child: ReorderableListView.builder(
        itemCount: lists.length,

        onReorder: (oldIndex, newIndex) async {
          // if (newIndex > oldIndex) {
          //   newIndex--;
          // }

          // final item = directory.taskList.removeAt(oldIndex);

          // directory.taskList.insert(newIndex, item);

          // await directory.save();

          // setState(() {});
        },

        itemBuilder: (context, index) {
          final taskList = lists[index];

          return Card(
            key: ValueKey(index),

            elevation: 3,

            margin: const EdgeInsets.symmetric(vertical: 2),

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),

            child: Container(
              margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [BoxShadow(blurRadius: 4, color: Colors.black12)],
              ),
              child: ListTile(
                contentPadding: const EdgeInsets.fromLTRB(10, 1, 10, 1),

                leading: widget.isEditing
                    ? ReorderableDragStartListener(
                        index: index,
                        child: const Icon(Icons.drag_indicator),
                      )
                    : null,
                title: Text(
                  taskList.listTitle,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),

                trailing: widget.type == "ListBtn" && !widget.isEditing
                    ? Icon(Icons.arrow_forward_rounded)
                    : widget.type == "ListBtn" && widget.isEditing
                    ? IconButton(
                        onPressed: () {
                          print('Options pressed!');
                        },
                        icon: Icon(Icons.more_horiz),
                      )
                    : null,
                onTap: widget.isEditing
                    ? null
                    : () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SelectedTaskList(
                              box: box,
                              listTitle: taskList.listTitle,
                            ),
                          ),
                        );
                      },
              ),
            ),
          );
        },
      ),
    );
  }
}
