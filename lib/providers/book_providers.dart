import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../models/book.dart';

class Book with ChangeNotifier {
  final String authToken;
  final String userId;
  Map<String, BookItem> _items = {};

  Book.create(this.authToken, this.userId);
  Book.update(this.authToken, this.userId, this._items);

  Future<void> fetchAndSetBooks() async {
    final url = 'http://10.0.2.2:3000/books/';
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
          final Map<String, BookItem> loadedBook = {};
          extractedData.forEach((book) {
            //print(book['isRead']['data'][0].runtimeType);
            loadedBook[book['id'].toString()] = BookItem(
              id: book['id'].toString(),
              name: book['name'],
              start: DateTime.parse(book['start']),
              dueDate: DateTime.parse(book['due']),
              author: book['author'],
              page: book['page'],
              comment: book['comments'],
              isRead: book['isRead']['data'][0] == 0 ? false : true,
              rating: book['b_rating'],
            );
          });
          _items = loadedBook;
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

  Map<String, BookItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  Future<void> add({
    String name,
    String author,
    int page,
    DateTime startDate,
    DateTime dueDate,
  }) async {
    final url = 'http://10.0.2.2:3000/books/';
    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $authToken'
        },
        body: jsonEncode(<String, dynamic>{
          'name': name,
          'author': author,
          'page': page,
          'start': startDate.toIso8601String(),
          'due': dueDate.toIso8601String(),
        }),
      );
      final responseBody = json.decode(response.body);
      final bookId = responseBody['insertId'].toString();
      _items.putIfAbsent(
        bookId,
        () => BookItem(
          id: bookId,
          name: name,
          dueDate: dueDate,
          start: startDate,
          author: author,
          page: page,
          isRead: false,
          rating: 0,
          comment: "",
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

  Future<void> updateItem(BookItem bookItem) async {
    final values = [
      bookItem.name,
      bookItem.author,
      bookItem.page,
      bookItem.start == null ? null : bookItem.start.toIso8601String(),
      bookItem.dueDate == null ? null : bookItem.start.toIso8601String(),
      bookItem.rating,
      bookItem.isRead == true ? 1 : 0,
      bookItem.comment
    ];
    final str = [
      'name',
      'author',
      'page',
      'start',
      'due',
      'rating',
      'read',
      'comment'
    ];
    Map<String, dynamic> change = {};
    for (var i = 0; i < values.length; i++) {
      final value = values[i];
      if (value != null) {
        change[str[i]] = value;
      }
    }
    print('change');
    print(change);
    print(jsonEncode(change));
    print('success');
    final url = 'http://10.0.2.2:3000/books/${bookItem.id}';
    try {
      final response = await http.patch(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $authToken'
        },
        body: jsonEncode(change),
      );
      print(response.body);
      final ex =
          _items[_items.keys.firstWhere((element) => element == bookItem.id)];
      print(ex.rating);
      print(ex.name);
      print(ex.author);
      print(ex.dueDate);
      print(ex.start);
      _items.update(
        bookItem.id,
        (existing) => BookItem(
            id: bookItem.id,
            name: bookItem.name == null ? existing.name : bookItem.name,
            dueDate:
                bookItem.dueDate == null ? existing.dueDate : bookItem.dueDate,
            start: bookItem.start == null ? existing.start : bookItem.start,
            author: bookItem.author == null ? existing.author : bookItem.author,
            page: bookItem.page == null ? existing.page : bookItem.page,
            isRead: bookItem.isRead == null ? existing.isRead : bookItem.isRead,
            comment:
                bookItem.comment == null ? existing.comment : bookItem.comment,
            rating:
                bookItem.rating == null ? existing.rating : bookItem.rating),
      );
      notifyListeners();
    } catch (err) {
      print(err);
      throw err;
    }
  }

  Future<void> removeItem(String bookId) async {
    final existingBookKey = _items.keys.firstWhere((key) => key == bookId);
    var existingBook = _items[existingBookKey];
    _items.removeWhere((key, value) => key == bookId);
    notifyListeners();
    final url = 'http://10.0.2.2:3000/books/$bookId';
    await http.delete(url, headers: <String, String>{
      'Authorization': 'Bearer $authToken'
    }).then((_) {
      existingBook = null;
    }).catchError((err) {
      _items[existingBookKey] = existingBook;
      print(err);
      throw err;
    });
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}
