import 'package:hive/hive.dart';

part 'task_directory.g.dart';

@HiveType(typeId: 0)
class TaskDirectory extends HiveObject {
  @HiveField(0)
  String listDir;

  @HiveField(1)
  List<TaskList> lists;

  TaskDirectory({this.listDir = "root", List<TaskList>? lists})
    : lists = lists ?? [];
}

@HiveType(typeId: 1)
class TaskList extends HiveObject {
  @HiveField(0)
  String listTitle;

  @HiveField(1)
  List<TaskItem> taskList;

  TaskList({required this.listTitle, List<TaskItem>? taskList})
    : taskList = taskList ?? [];
}

@HiveType(typeId: 2)
class TaskItem {
  @HiveField(0)
  String title;

  @HiveField(1)
  bool isCompleted;

  TaskItem({required this.title, this.isCompleted = false});
}
