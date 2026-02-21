// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_list_collection_box.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskListCollectionBoxAdapter extends TypeAdapter<TaskListCollectionBox> {
  @override
  final int typeId = 0;

  @override
  TaskListCollectionBox read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TaskListCollectionBox(
      title: fields[0] as String,
      taskList: fields[1] as TaskItem,
    );
  }

  @override
  void write(BinaryWriter writer, TaskListCollectionBox obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.taskList);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskListCollectionBoxAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
