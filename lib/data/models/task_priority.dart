import 'package:flutter/material.dart';

enum TaskPriority {
  low(
    Icon(
      Icons.low_priority,
      color: Colors.blue,
    ),
    'Niski priorytet',
  ),
  medium(
    Icon(
      Icons.density_medium,
      color: Colors.orangeAccent,
    ),
    'Średni priorytet',
  ),
  high(
    Icon(
      Icons.priority_high,
      color: Colors.red,
    ),
    'Wysoki priorytet',
  );

  const TaskPriority(this.icon, this.text);
  final Icon icon;
  final String text;
}
