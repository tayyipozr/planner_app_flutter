import 'package:flutter/material.dart';

import '../models/habit.dart';

class Habit with ChangeNotifier {
  Map<String, HabitItem> _items = {};

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
        id: DateTime.now().toString(),
        name: name,
        dueDate: dueDate,
        start: DateTime.now(),
        icon: Icon(icon),
      ),
    );
    notifyListeners();
    print("lenght:" + _items.length.toString());
  }
  
  @override
  notifyListeners();

  void removeItem(String habitId) {
    _items.remove(habitId);
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
