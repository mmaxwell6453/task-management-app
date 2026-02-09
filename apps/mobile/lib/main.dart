import 'package:flutter/material.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  App({super.key});

  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(title: Text('TManager')),
        body: Center(child: TaskList()),
        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(8),
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                hintText: "+ Add a Task...",
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class TaskList extends StatefulWidget {
  const TaskList({super.key});

  @override
  State<TaskList> createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  List<String> tasks = ['Apple', 'Banana', 'Orange', 'Grapes', 'Mango'];

  void addTask() {
    setState(() {
      tasks.add('Orange');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Fruits')),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return ListTile(title: Text(tasks[index]));
        },
      ),
    );
  }
}
