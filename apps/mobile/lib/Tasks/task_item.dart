import 'package:hive/hive.dart';

part 'task_item.g.dart';

@HiveType(typeId: 0)
class TaskItem extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  bool isCompleted;

  TaskItem({required this.title, this.isCompleted = false});
}
