import 'package:flutter/material.dart';

import '../models/user.dart';

class Users with ChangeNotifier {
  Map<String, User> _items = {};

  Map<String, User> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  void add({String userId, String name}) {
    _items.putIfAbsent(
      userId,
      () => User(
        id: userId,
        name: name,
      ),
    );
    notifyListeners();
  }

  @override
  notifyListeners();

  void updateItem(User user) {
    _items.update(
      user.id,
      (existing) => User(
        id: existing.id,
        name: user.name,
      ),
    );
  }

  void removeItem(String userId) {
    _items.removeWhere((key, value) => key == userId);
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
