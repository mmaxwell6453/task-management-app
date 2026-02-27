import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:mobile/TaskDirectories/task_directory.dart';
import 'package:mobile/Tasks/selected_task_list.dart';
import 'package:mobile/TaskDirectories/task_directory_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(TaskDirectoryAdapter());
  Hive.registerAdapter(TaskListAdapter());
  Hive.registerAdapter(TaskItemAdapter());

  final box = await Hive.openBox<TaskDirectory>('taskDirectories');

  // ✅ Create root directory if it doesn't exist
  if (!box.containsKey("root")) {
    await box.put("root", TaskDirectory(listDir: "home"));
  }

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(
          title: Column(
            children: [Text('**Advertisements**'), Text('TManager')],
          ),
          centerTitle: true,
        ),
        resizeToAvoidBottomInset: true,
        body: const TaskDirectoryScreen(),
      ),
    );
  }
}
