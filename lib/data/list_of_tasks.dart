import 'package:flutter/material.dart';
import 'package:flutter_academy_app/data/models/task.dart';
import 'package:flutter_academy_app/data/models/task_priority.dart';
import 'package:uuid/uuid.dart';

final uuid = const Uuid();

var listOfTask = [
  Task(
    id: uuid.v4(),
    title: 'first Task',
    color: Colors.yellow,
    taskPriority: TaskPriority.low,
  ),
];
