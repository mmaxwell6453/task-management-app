import 'package:hive/hive.dart';

part 'task_directory.g.dart';

@HiveType(typeId: 0)
class TaskDirectory extends HiveObject {
  @HiveField(0)
  String listDir;

  @HiveField(1)
  String listTitle;

  @HiveField(2)
  List<TaskItem> taskList;

  TaskDirectory({
    this.listDir = "home",
    required this.listTitle,
    required this.taskList,
  });
}

@HiveType(typeId: 1)
class TaskItem {
  @HiveField(0)
  String title;

  @HiveField(1)
  bool isCompleted;

  TaskItem({required this.title, this.isCompleted = false});
}
