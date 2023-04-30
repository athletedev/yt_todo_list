import 'dart:ui';

import 'package:flutter_academy_app/data/models/task_priority.dart';

class Task {
  const Task({
    required this.id,
    required this.title,
    required this.taskPriority,
    this.isDone = false,
    this.subtitile,
    this.color,
  });

  final String id;
  final Color? color;
  final bool isDone;
  final String title;
  final String? subtitile;
  final TaskPriority taskPriority;

  Task copyWith({
    String? id,
    Color? color,
    String? title,
    bool? isDone,
    String? subtitile,
    TaskPriority? taskPriority,
  }) {
    return Task(
      isDone: isDone ?? this.isDone,
      id: id ?? this.id,
      color: color ?? this.color,
      title: title ?? this.title,
      subtitile: subtitile ?? this.subtitile,
      taskPriority: taskPriority ?? this.taskPriority,
    );
  }
}
