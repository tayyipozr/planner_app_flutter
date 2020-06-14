import 'package:flutter/material.dart';

import '../models/habit.dart';

class Habit with ChangeNotifier {
  Map<String, HabitItem> _items = {
    "id": HabitItem(
      id: "id",
      name: "name",
      start: DateTime.now(),
      dueDate: DateTime.now().add(Duration(days: 90)),
      icon: Icon(
        Icons.check_box_outline_blank,
      ),
    ),
    "id2": HabitItem(
      id: "id2",
      name: "name",
      start: DateTime.now(),
      dueDate: DateTime.now().add(Duration(days: 90)),
      icon: Icon(
        Icons.check_box_outline_blank,
      ),
    ),
    "id3": HabitItem(
      id: "id3",
      name: "name",
      start: DateTime.now(),
      dueDate: DateTime.now().add(Duration(days: 90)),
      icon: Icon(
        Icons.check_box_outline_blank,
      ),
    ),
    "id4": HabitItem(
      id: "id4",
      name: "name",
      start: DateTime.now(),
      dueDate: DateTime.now().add(Duration(days: 90)),
      icon: Icon(
        Icons.check_box_outline_blank,
      ),
    ),
    "id5": HabitItem(
      id: "id5",
      name: "name",
      start: DateTime.now(),
      dueDate: DateTime.now().add(Duration(days: 90)),
      icon: Icon(
        Icons.check_box_outline_blank,
      ),
    )
  };

  Map<String, HabitItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  void add({String habitId, String name, DateTime dueDate, IconData icon}) {
    _items.putIfAbsent(
      habitId,
      () => HabitItem(
        id: habitId,
        name: name,
        dueDate: dueDate,
        start: DateTime.now(),
        icon: Icon(icon),
      ),
    );
    notifyListeners();
  }

  @override
  notifyListeners();

  void updateItem(HabitItem habitItem) {
    _items.update(
      habitItem.id,
      (existing) => HabitItem(
        name: habitItem.name,
        dueDate: habitItem.dueDate,
        icon: habitItem.icon,
        id: habitItem.id,
        start: habitItem.start,
      ),
    );
  }

  void removeItem(String habitId) {
    _items.removeWhere((key, value) => key == habitId);
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
