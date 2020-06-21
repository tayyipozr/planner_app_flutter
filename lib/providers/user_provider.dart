// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// import '../models/user.dart';

// class UserProvider with ChangeNotifier {
//   static const url = 'http://10.0.2.2:3000/user';

//   Future<User> fetchUser() async {
//     final response = await http.post(
//       url,
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8'
//       },
//       body: jsonEncode(<String, String>{
//         'name': "Tayyip",
//       }),
//     );
//     if (response.statusCode == 200) {
//       return User.fromJson(json.decode(response.body));
//     } else {
//       throw Exception('Failedto load user');
//     }
//   }
// }
