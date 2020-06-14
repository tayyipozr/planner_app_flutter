import 'package:flutter/material.dart';
import '../models/book.dart';

class Book with ChangeNotifier {
  Map<String, BookItem> _items = {
    "id": BookItem(
      id: "id",
      name: "Where the Crawdads Sing",
      start: DateTime.now().add(Duration(days: 120)),
      rating: 5,
      dueDate: DateTime.now().add(Duration(days: 90)),
      author: "Delia Owens",
      page: 300,
      isRead: false,
    ),
    "id2": BookItem(
      id: "id2",
      name: "My Story",
      start: DateTime.now().add(Duration(days: 30)),
      rating: 4,
      dueDate: DateTime.now().add(Duration(days: 90)),
      author: "Michelle Obama",
      page: 200,
      isRead: false,
    ),
    "id3": BookItem(
      id: "id3",
      name: "Ufak Yanginlar: Dergi Zeitschrift",
      start: DateTime.now().add(Duration(days: 60)),
      rating: 1,
      dueDate: DateTime.now().add(Duration(days: 90)),
      author: "Celeste Ng",
      page: 100,
      isRead: true,
    ),
    "id4": BookItem(
      id: "id4",
      name: "White Fragility",
      start: DateTime.now().add(Duration(days: 240)),
      rating: 2,
      dueDate: DateTime.now().add(Duration(days: 90)),
      author: "Robin DiAngelo",
      page: 150,
      isRead: true,
    ),
    "id5": BookItem(
      id: "id5",
      name: "Normal People",
      start: DateTime.now().add(Duration(days: 150)),
      rating: 3,
      dueDate: DateTime.now().add(Duration(days: 90)),
      author: "Sally Rooney",
      page: 250,
      isRead: true,
    ),
    "id6": BookItem(
      id: "id6",
      name: "Martı",
      start: DateTime.now().add(Duration(days: 210)),
      rating: 4,
      dueDate: DateTime.now().add(Duration(days: 90)),
      author: "Richard Back",
      page: 400,
      isRead: true,
    )
  };

  Map<String, BookItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  void add(
      {String bookId, String name, String author, int page, DateTime dueDate}) {
    _items.putIfAbsent(
      bookId,
      () => BookItem(
        id: bookId,
        name: name,
        dueDate: dueDate,
        start: DateTime.now(),
        author: author,
        page: page,
        isRead: false,
      ),
    );
    notifyListeners();
  }

  @override
  notifyListeners();

  void updateItem(BookItem bookItem) {
    _items.update(
      bookItem.id,
      (existing) => BookItem(
        name: bookItem.name,
        dueDate: bookItem.dueDate,
        id: bookItem.id,
        start: bookItem.start,
        author: bookItem.author,
        page: bookItem.page,
        isRead: bookItem.isRead,
      ),
    );
  }

  void removeItem(String bookId) {
    _items.removeWhere((key, value) => key == bookId);
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
