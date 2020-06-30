import 'dart:convert';

import 'package:flutter/material.dart';
import '../helpers/http_helper.dart';

import '../models/place.dart';

class Place with ChangeNotifier {
  final String authToken;
  final String userId;
  Map<String, PlaceItem> _items = {};

  Place.create(this.authToken, this.userId);
  Place.update(this.authToken, this.userId, this._items);

  Future<void> fetchAndSetPlaces() async {
    try {
      final extractedData = await MyHttp.fetch(authToken, 'places');
      print(extractedData);
      final Map<String, PlaceItem> loadedProduct = {};
      extractedData.forEach((place) {
        loadedProduct[place['id'].toString()] = PlaceItem(
          id: place['id'].toString(),
          name: place['name'],
          belong: place['belong'],
        );
      });
      _items = loadedProduct;
      notifyListeners();
    } catch (err) {
      print(err);
      throw (err);
    }
  }

  Map<String, PlaceItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  Future<void> add({String name, int belong}) async {
    final body = jsonEncode(<String, dynamic>{
      'name': name,
      'belong': belong,
    });
    try {
      final response = await MyHttp.post(authToken, 'places', body);
      _items.putIfAbsent(
        response,
        () => PlaceItem(
          id: response,
          belong: belong,
          name: name,
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

//   Future<void> updateItem(PlaceItem habitItem) async {
//     try {
//       final url = 'http://10.0.2.2:3000/habits/$authToken/${habitItem.id}';
//       await http.patch(
//         url,
//         headers: <String, String>{
//           'Content-Type': 'application/json; charset=UTF-8',
//           'Authorization': 'Bearer $authToken'
//         },
//         body: jsonEncode(<String, String>{
//           'name': habitItem.name,
//           'start': habitItem.start.toIso8601String(),
//           'due': habitItem.dueDate.toIso8601String(),
//         }),
//       );
//       _items.update(
//         habitItem.id,
//         (existing) => PlaceItem(
//           name: habitItem.name,
//           dueDate: habitItem.dueDate,
//           icon: habitItem.icon,
//           id: habitItem.id,
//           start: habitItem.start,
//         ),
//       );
//       notifyListeners();
//     } catch (err) {
//       print(err);
//       throw err;
//     }
//   }

  void removeItem(String placeId) {
    final existingPlaceKey = _items.keys.firstWhere((key) => key == placeId);
    var existingPlace = items[existingPlaceKey];
    _items.removeWhere((key, value) => key == placeId);
    notifyListeners();
    MyHttp.delete(authToken, placeId).then((_) {
      existingPlace = null;
    }).catchError((err) {
      _items[existingPlaceKey] = existingPlace;
      print(err);
      throw err;
    });
  }
}
//   void clear() {
//     _items = {};
//     notifyListeners();
//   }
// }
// F

// }
