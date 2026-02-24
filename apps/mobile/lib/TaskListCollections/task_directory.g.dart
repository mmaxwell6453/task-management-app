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
      listTitle: fields[1] as String,
      taskList: (fields[2] as List).cast<TaskItem>(),
    );
  }

  @override
  void write(BinaryWriter writer, TaskDirectory obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.listDir)
      ..writeByte(1)
      ..write(obj.listTitle)
      ..writeByte(2)
      ..write(obj.taskList);
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

class TaskItemAdapter extends TypeAdapter<TaskItem> {
  @override
  final int typeId = 1;

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
