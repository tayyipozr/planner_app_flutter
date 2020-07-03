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

  static Future<String> post(
      String authToken, String databaseModel, String body) async {
    final url = 'http://10.0.2.2:3000/$databaseModel';
    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $authToken'
        },
        body: body,
      );
      return response.body;
    } catch (err) {
      print(err);
      throw err;
    }
  }

//   @override
//   notifyListeners();

  static Future<void> patch(
      String authToken, String databaseModel, String body, String id) async {
    try {
      final url = 'http://10.0.2.2:3000/$databaseModel/$id';
      await http.patch(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $authToken'
        },
        body: body,
      );
    } catch (err) {
      print(err);
      throw err;
    }
  }

  static Future<void> delete(String authToken, String id) async {
    final url = 'http://10.0.2.2:3000/habits/$id';
    try {
      await http.delete(url,
          headers: <String, String>{'Authorization': 'Bearer $authToken'});
    } catch (err) {
      print(err);
      throw err;
    }
  }
}
//   void clear() {
//     _items = {};
//     notifyListeners();
//   }
// }
// F

// }
