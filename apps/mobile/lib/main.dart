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

  final box = Hive.box<TaskItem>('todoBox');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(title: Text('TManager')),
        resizeToAvoidBottomInset: true, // ensures body resizes
        body: Column(
          children: [
            // Task list takes remaining space
            Expanded(
              child: ListView(
                children: box.values
                    .map(
                      (task) => ListTile(
                        title: Text(task.title),
                        leading: Checkbox(
                          value: task.isCompleted,
                          onChanged: (bool? value) {
                            setState(() {
                              task.isCompleted = value!;
                            });

                            task.save(); // 🔥 THIS writes the change to Hive
                          },
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
            // Input field at the bottom
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
                            print('it Worked!');
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
