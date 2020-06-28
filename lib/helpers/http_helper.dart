import 'dart:convert';

import 'package:http/http.dart' as http;

class MyHttp {
  static Future<List<dynamic>> fetch(
      String authToken, String databaseModel) async {
    final url = 'http://10.0.2.2:3000/$databaseModel';
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
          return extractedData;
        } else {
          throw Error();
        }
      }
    } catch (err) {
      print(err);
      throw (err);
    }
  }
}
//   Map<String, PlaceItem> get items {
//     return {..._items};
//   }

//   int get itemCount {
//     return _items.length;
//   }

//   Future<void> add({String name, DateTime dueDate, IconData icon}) async {
//     final url = 'http://10.0.2.2:3000/habits/$authToken';
//     final timelapse = DateTime.now();
//     try {
//       final response = await http.post(
//         url,
//         headers: <String, String>{
//           'Content-Type': 'application/json; charset=UTF-8',
//           'Authorization': 'Bearer $authToken'
//         },
//         body: jsonEncode(<String, String>{
//           'name': name,
//           'start': timelapse.toIso8601String(),
//           'due': dueDate.toIso8601String()
//         }),
//       );
//       print(response.body);
//       _items.putIfAbsent(
//         response.body,
//         () => PlaceItem(
//           id: response.body,
//           name: name,
//           dueDate: dueDate,
//           start: timelapse,
//           icon: Icon(icon),
//         ),
//       );
//       notifyListeners();
//     } catch (err) {
//       print(err);
//       throw err;
//     }
//   }

//   @override
//   notifyListeners();

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

//   void removeItem(String habitId) {
//     final url = 'http://10.0.2.2:3000/habits/$authToken/$habitId';
//     final existingHabitKey = _items.keys.firstWhere((key) => key == habitId);
//     var existingHabit = items[existingHabitKey];
//     _items.removeWhere((key, value) => key == habitId);
//     notifyListeners();
//     http.delete(url, headers: <String, String>{
//       'Authorization': 'Bearer $authToken'
//     }).then((_) {
//       existingHabit = null;
//     }).catchError((err) {
//       _items[existingHabitKey] = existingHabit;
//       print(err);
//       throw err;
//     });
//   }

//   void clear() {
//     _items = {};
//     notifyListeners();
//   }
// }
// F

// }
