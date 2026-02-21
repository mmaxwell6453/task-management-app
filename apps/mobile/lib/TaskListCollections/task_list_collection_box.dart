import 'package:hive/hive.dart';

import 'package:mobile/Tasks/task_item.dart';

part 'task_list_collection_box.g.dart';

@HiveType(typeId: 0)
class TaskListCollectionBox extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  TaskItem taskList;

  TaskListCollectionBox({required this.title, required this.taskList});
}
