import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:uuid/uuid.dart';

import 'package:mobile/TaskDirectories/task_directory.dart';
// import 'package:mobile/Tasks/task_list.dart';

class SelectedTaskList extends StatefulWidget {
  final Box<TaskDirectory> box;
  final String directoryKey;
  final String listId;

  const SelectedTaskList({
    super.key,
    required this.box,
    required this.directoryKey,
    required this.listId,
  });

  @override
  State<SelectedTaskList> createState() => _SelectedTaskListState();
}

class _SelectedTaskListState extends State<SelectedTaskList> {
  final TextEditingController controller = TextEditingController();
  bool isEditing = false;

  late TaskDirectory directory;
  late TaskList taskList;

  @override
  void initState() {
    super.initState();

    directory = widget.box.get(widget.directoryKey)!;

    taskList = directory.lists.firstWhere(
          (list) => list.id == widget.listId,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 100,
        leading: Column(
          children: [
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () => Navigator.pop(context),
                ),
                GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: Text("Lists"),
                ),
              ],
            ),
          ],
        ),
        title: Text('TManager'),
        centerTitle: true,
      ),
      resizeToAvoidBottomInset: true,
      body: Column(
        children: [
          Text('**Advertisements**'),
          Row(
            children: [
              const Spacer(),

              TextButton(
                onPressed: () {
                  setState(() {
                    isEditing = !isEditing;
                  });
                },

                child: Text(!isEditing ? 'Edit' : 'Done'),
              ),
            ],
          ),
          Expanded(
            child: directory.lists.isEmpty
                ? const Center(child: Text('No tasks yet...'))
                : ReorderableListView.builder(
                    itemCount: taskList.taskList.length,

                    onReorder: (oldIndex, newIndex) async {
                      if (newIndex > oldIndex) {
                        newIndex--;
                      }

                      final item = taskList.taskList.removeAt(oldIndex);

                      taskList.taskList.insert(newIndex, item);

                      await directory.save();

                      setState(() {});
                    },

                    itemBuilder: (context, index) {
                      final task = taskList.taskList[index];

                      return Card(
                        key: ValueKey(task.id),

                        elevation: 3,

                        margin: const EdgeInsets.symmetric(vertical: 2),

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),

                        child: Container(
                          margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                          decoration: BoxDecoration(
                            color: Theme.of(
                              context,
                            ).colorScheme.surfaceContainerHighest,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(blurRadius: 4, color: Colors.black12),
                            ],
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.fromLTRB(
                              10,
                              1,
                              10,
                              1,
                            ),

                            leading: isEditing
                                ? ReorderableDragStartListener(
                                    index: index,
                                    child: const Icon(Icons.drag_indicator),
                                  )
                                : null,
                            title: Text(
                              task.title,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),

                            trailing: isEditing
                                ? IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () async {

                                setState(() {
                                  taskList.taskList.removeAt(index);
                                });

                                await directory.save();

                              },
                            )
                                : null,
                          ),
                        ),
                      );
                    },
                  ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8),

              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller,

                      decoration: const InputDecoration(
                        hintText: "Add a Task...",
                        border: OutlineInputBorder(),
                      ),

                      textInputAction: TextInputAction.done,

                      onSubmitted: (value) async {
                        if (value.isEmpty) return;

                        setState(() {

                          taskList.taskList.add(
                            TaskItem(
                              id: const Uuid().v4(),
                              title: value,
                            ),
                          );

                        });

                        await directory.save();

                        controller.clear();
                      },
                    ),
                  ),

                  const SizedBox(width: 8),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// class SelectedTaskList extends StatefulWidget {
//   const SelectedTaskList({super.key});

//   @override
//   State<SelectedTaskList> createState() => _SelectedTaskListState();
// }

// class _SelectedTaskListState extends State<SelectedTaskList> {
//   final TextEditingController controller = TextEditingController();

//   bool isEditing = false;

//   late Box<TaskDirectory> box;
//   late TaskDirectory directory;

//   @override
//   void initState() {
//     super.initState();

//     box = Hive.box<TaskDirectory>('taskDirectories');

//     directory = box.getAt(0)!;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Row(
//           children: [
//             const Spacer(),

//             TextButton(
//               onPressed: () {
//                 setState(() {
//                   isEditing = !isEditing;
//                 });
//               },

//               child: Text(!isEditing ? 'Edit' : 'Done'),
//             ),
//           ],
//         ),

//         TaskList(isEditing: isEditing),

//         SafeArea(
//           child: Padding(
//             padding: const EdgeInsets.all(8),

//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: controller,

//                     decoration: const InputDecoration(
//                       hintText: "Add a Task...",
//                       border: OutlineInputBorder(),
//                     ),

//                     textInputAction: TextInputAction.done,

//                     onSubmitted: (value) {
//                       if (value.isEmpty) return;

//                       setState(() {
//                         directory.taskList.add(TaskItem(title: value));

//                         directory.save();

//                         controller.clear();
//                       });
//                     },
//                   ),
//                 ),

//                 const SizedBox(width: 8),

//                 IconButton(
//                   icon: const Icon(Icons.add),

//                   onPressed: () {
//                     if (controller.text.isEmpty) return;

//                     setState(() {
//                       directory.taskList.add(TaskItem(title: controller.text));

//                       directory.save();

//                       controller.clear();
//                     });
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
