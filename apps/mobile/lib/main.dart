import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'package:mobile/TaskListCollections/task_list_collection_box.dart';
import 'package:mobile/Tasks/selected_task_list.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive for Flutter
  await Hive.initFlutter();
  Hive.registerAdapter(TaskListCollectionBoxAdapter());

  // Open a box (like a table)
  await Hive.openBox<TaskListCollectionBox>('todoBox');

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(title: Text('TManager'), centerTitle: true),
        resizeToAvoidBottomInset: true,
        body: SelectedTaskList(),
      ),
    );
  }
}
