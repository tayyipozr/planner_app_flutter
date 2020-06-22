import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/habit.dart';

class Habit with ChangeNotifier {
  final String authToken;
  final String userId;
  Map<String, HabitItem> _items = {};

  Habit.create(this.authToken, this.userId);
  Habit.update(this.authToken, this.userId, this._items);

  Future<void> fetchAndSetHabits() async {
    final url = 'http://10.0.2.2:3000/habits/$userId';
    print(authToken);
    try {
      final response = await http.get(
        url,
        headers: <String, String>{'Authorization': 'Bearer $authToken'},
      );
      {
        if (authToken != null) {
          final extractedData = json.decode(response.body) as List<dynamic>;
          print(extractedData);
          final Map<String, HabitItem> loadedProduct = {};
          extractedData.forEach((habit) {
            loadedProduct[habit['id'].toString()] = HabitItem(
              id: habit['id'].toString(),
              name: habit['name'],
              start: DateTime.parse(habit['start']),
              dueDate: DateTime.parse(habit['due']),
            );
          });
          _items = loadedProduct;
          notifyListeners();
        } else {
          throw Error();
        }
      }
    } catch (err) {
      print(err);
      throw (err);
    }
  }

  Map<String, HabitItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  Future<void> add({String name, DateTime dueDate, IconData icon}) async {
    final url = 'http://10.0.2.2:3000/habits/$userId';
    final timelapse = DateTime.now();
    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $authToken'
        },
        body: jsonEncode(<String, String>{
          'name': name,
          'start': timelapse.toIso8601String(),
          'due': dueDate.toIso8601String()
        }),
      );
      print(response.body);
      _items.putIfAbsent(
        response.body,
        () => HabitItem(
          id: response.body,
          name: name,
          dueDate: dueDate,
          start: timelapse,
          icon: Icon(icon),
        ),
      );
      notifyListeners();
    } catch (err) {
      print(err);
      throw err;
    }
  }

  @override
  notifyListeners();

  Future<void> updateItem(HabitItem habitItem) async {
    try {
      final url = 'http://10.0.2.2:3000/habits/$userId/${habitItem.id}';
      await http.patch(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $authToken'
        },
        body: jsonEncode(<String, String>{
          'name': habitItem.name,
          'start': habitItem.start.toIso8601String(),
          'due': habitItem.dueDate.toIso8601String(),
        }),
      );
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
      notifyListeners();
    } catch (err) {
      print(err);
      throw err;
    }
  }

  void removeItem(String habitId) {
    final url = 'http://10.0.2.2:3000/habits/$userId/$habitId';
    final existingProductKey = _items.keys.firstWhere((key) => key == habitId);
    var existingProduct = items[existingProductKey];
    _items.removeWhere((key, value) => key == habitId);
    notifyListeners();
    http.delete(url, headers: <String, String>{
      'Authorization': 'Bearer $authToken'
    }).then((_) {
      existingProduct = null;
    }).catchError((err) {
      _items[existingProductKey] = existingProduct;
      print(err);
      throw err;
    });
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
