import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:mobile/Tasks/task_item.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive for Flutter
  await Hive.initFlutter();
  Hive.registerAdapter(TaskItemAdapter());

  // Open a box (like a table)
  await Hive.openBox<TaskItem>('todoBox');

  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final TextEditingController controller = TextEditingController();
  final List<String> tasks = [];
  bool isEditing = false;

  final box = Hive.box<TaskItem>('todoBox');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(title: Text('TManager'), centerTitle: true),
        resizeToAvoidBottomInset: true, // ensures body resizes
        body: Column(
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
            Expanded(
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
                      leading: isEditing
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
                      trailing: isEditing
                          ? IconButton(
                              icon: const Icon(Icons.delete),
                              color: Colors.red,
                              onPressed: () async {
                                final confirmed = await showDialog<bool>(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: const Text('Delete Item'),
                                      content: const Text(
                                        'Are you sure you want to delete this item?',
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
                                          },
                                          child: const Text('Delete'),
                                        ),
                                      ],
                                    );
                                  },
                                );

                                if (confirmed == true) {
                                  task.delete();
                                  setState(() {});
                                }
                              },
                            )
                          : null,
                    ),
                  );
                },
              ),
            ),
            SafeArea(
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: controller,
                        decoration: InputDecoration(
                          hintText: "Add a Task...",
                          border: OutlineInputBorder(),
                        ),
                        textInputAction: TextInputAction.done,
                        onSubmitted: (value) {
                          if (value.isEmpty) return;
                          setState(() {
                            box.add(TaskItem(title: value));
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
                          tasks.add(controller.text);
                          controller.clear();
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
