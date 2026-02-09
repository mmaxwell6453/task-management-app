import 'package:flutter/material.dart';

void main() {
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
              child: ListView.builder(
                padding: EdgeInsets.all(8),
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: EdgeInsets.symmetric(vertical: 4),
                    child: TaskItem(task: tasks[index]),
                  );
                },
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
                            tasks.add(value);
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

class TaskItem extends StatefulWidget {
  final String task;
  const TaskItem({required this.task, super.key});

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Checkbox(
        value: isChecked,
        onChanged: (value) {
          setState(() {
            isChecked = value!;
          });
        },
        shape: CircleBorder(), // circular checkbox
      ),
      title: Text(
        widget.task,
        style: TextStyle(
          decoration: isChecked ? TextDecoration.lineThrough : null,
        ),
      ),
    );
  }
}
