import 'package:flutter/material.dart';

class HabitItem {
  final String id;
  final String name;
  final Icon icon;
  final DateTime start;
  final DateTime dueDate;

  HabitItem({
    @required this.id,
    @required this.name,
    @required this.start,
    @required this.dueDate,
    this.icon,
  });
}
