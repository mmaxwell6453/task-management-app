// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task_directory.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskDirectoryAdapter extends TypeAdapter<TaskDirectory> {
  @override
  final int typeId = 0;

  @override
  TaskDirectory read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TaskDirectory(
      listDir: fields[0] as String,
      lists: (fields[1] as List?)?.cast<TaskList>(),
    );
  }

  @override
  void write(BinaryWriter writer, TaskDirectory obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.listDir)
      ..writeByte(1)
      ..write(obj.lists);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskDirectoryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class TaskListAdapter extends TypeAdapter<TaskList> {
  @override
  final int typeId = 1;

  @override
  TaskList read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TaskList(
      listTitle: fields[0] as String,
      taskList: (fields[1] as List?)?.cast<TaskItem>(),
    );
  }

  @override
  void write(BinaryWriter writer, TaskList obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.listTitle)
      ..writeByte(1)
      ..write(obj.taskList);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskListAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class TaskItemAdapter extends TypeAdapter<TaskItem> {
  @override
  final int typeId = 2;

  @override
  TaskItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TaskItem(title: fields[0] as String, isCompleted: fields[1] as bool);
  }

  @override
  void write(BinaryWriter writer, TaskItem obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.isCompleted);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
