import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:mobile/TaskDirectories/task_directory.dart';
import 'package:mobile/Tasks/task_list.dart';

class SelectedTaskList extends StatefulWidget {
  const SelectedTaskList({super.key});

  @override
  State<SelectedTaskList> createState() => _SelectedTaskListState();
}

class _SelectedTaskListState extends State<SelectedTaskList> {
  final TextEditingController controller = TextEditingController();

  bool isEditing = false;

  late Box<TaskDirectory> box;
  late TaskDirectory directory;

  @override
  void initState() {
    super.initState();

    box = Hive.box<TaskDirectory>('taskDirectories');

    directory = box.getAt(0)!;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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

        TaskList(isEditing: isEditing),

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

                    onSubmitted: (value) {
                      if (value.isEmpty) return;

                      setState(() {
                        directory.taskList.add(TaskItem(title: value));

                        directory.save();

                        controller.clear();
                      });
                    },
                  ),
                ),

                const SizedBox(width: 8),

                IconButton(
                  icon: const Icon(Icons.add),

                  onPressed: () {
                    if (controller.text.isEmpty) return;

                    setState(() {
                      directory.taskList.add(TaskItem(title: controller.text));

                      directory.save();

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

// class SelectedTaskList extends StatefulWidget {
//   const SelectedTaskList({super.key});

//   @override
//   State<SelectedTaskList> createState() => _SelectedTaskListState();
// }

// class _SelectedTaskListState extends State<SelectedTaskList> {
//   final TextEditingController controller = TextEditingController();
//   final List<String> tasks = [];
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
//             Spacer(),
//             TextButton(
//               onPressed: () {
//                 setState(() {
//                   isEditing = !isEditing;
//                 });
//               },
//               child: Text(
//                 !isEditing ? 'Edit' : 'Done',
//                 textAlign: TextAlign.right,
//               ),
//             ),
//           ],
//         ),
//         TaskList(isEditing: isEditing),
//         SafeArea(
//           child: Padding(
//             padding: EdgeInsets.all(8),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     controller: controller,
//                     decoration: InputDecoration(
//                       hintText: "Add a Task...",
//                       border: OutlineInputBorder(),
//                     ),
//                     textInputAction: TextInputAction.done,
//                     onSubmitted: (value) {
//                       if (value.isEmpty) return;
//                       setState(() {
//                         box.add(TaskItem(title: value));
//                         controller.clear();
//                       });
//                     },
//                   ),
//                 ),
//                 SizedBox(width: 8),
//                 IconButton(
//                   icon: Icon(Icons.add),
//                   onPressed: () {
//                     if (controller.text.isEmpty) return;
//                     setState(() {
//                       box.add(TaskItem(title: controller.text));
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
