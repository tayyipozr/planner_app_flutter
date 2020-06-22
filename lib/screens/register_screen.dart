import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/login_screen.dart';
import '../providers/auth.dart';

class RegisterScreen extends StatelessWidget {
  final formR = GlobalKey<FormState>();
  static const routeName = '/register';

  @override
  Widget build(BuildContext context) {
    var username;
    var password;
    var nickname;

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
            ),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/');
            },
          ),
        ),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: Color(0xFFFF9AA2),
          child: SingleChildScrollView(
            child: Stack(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(top: 50),
                          child: Text(
                            "Planner",
                            style:
                                TextStyle(fontSize: 40, fontFamily: "Raleway"),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 20, top: 50),
                          alignment: Alignment.topLeft,
                          height: MediaQuery.of(context).size.width / 7,
                          child: Image.asset("assets/img/jdi_login.png"),
                        ),
                      ],
                    ),
                    Container(
                      height: MediaQuery.of(context).size.width / 3,
                      child: Image.asset("assets/img/line_graph_login.png"),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.2,
                      child: Form(
                        key: formR,
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                              onSaved: (value) => username = value.trim(),
                              decoration: InputDecoration(
                                labelText: "Username",
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.blueGrey),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(25),
                                  ),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.blueAccent)),
                                contentPadding: EdgeInsets.all(20.0),
                                prefixIcon: Icon(
                                  Icons.person_outline,
                                  color: Theme.of(context).primaryColorDark,
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            TextFormField(
                              onSaved: (value) => nickname = value.trim(),
                              decoration: InputDecoration(
                                labelText: "Nickname",
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.blueGrey),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(25),
                                  ),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.blueAccent)),
                                contentPadding: EdgeInsets.all(20.0),
                                prefixIcon: Icon(
                                  Icons.person_outline,
                                  color: Theme.of(context).primaryColorDark,
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            TextFormField(
                              onSaved: (value) => password = value.trim(),
                              decoration: InputDecoration(
                                labelText: "Password",
                                enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.blueGrey),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(25),
                                  ),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.blueAccent)),
                                contentPadding: EdgeInsets.all(20.0),
                                prefixIcon: Icon(
                                  Icons.person_outline,
                                  color: Theme.of(context).primaryColorDark,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        formR.currentState.save();
                        await Provider.of<Auth>(context, listen: false).register(username, password, nickname);
                        // const url = 'http://10.0.2.2:3000/users';
                        // var response = await http.post(
                        //   url,
                        //   headers: <String, String>{
                        //     'Content-Type': 'application/json; charset=UTF-8'
                        //   },
                        //   body: jsonEncode(<String, String>{
                        //     'name': username,
                        //     'pass': password,
                        //     'nick': nickname
                        //   }),
                        // );
                        // if (response.body == "Success") {
                        //   Navigator.of(context)
                        //       .pushNamed('/', arguments: username);
                        // } else if (response.body == "Duplicate") {
                        //   showDialog(
                        //     context: context,
                        //     builder: (_) => AlertDialog(
                        //       title: Text("Be Carefull !!"),
                        //       content:
                        //           Text("This username has already been taken."),
                        //       actions: <Widget>[
                        //         FlatButton(
                        //             child: Text("OK"),
                        //             onPressed: () => Navigator.pop(context))
                        //       ],
                        //     ),
                        //   );
                        // } else {
                        //   print(response.body);
                        //   print(response.statusCode);
                        // }
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 50),
                        height: MediaQuery.of(context).size.height / 8,
                        child: Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            Container(
                              child: Image.asset("assets/img/agenda_login.png"),
                            ),
                            Transform.rotate(
                              angle: -3.14 / 10,
                              child: Text(
                                "Click to start",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Theme.of(context).primaryColorDark),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                // Container(
                //   child: Positioned(
                //     bottom: 0,
                //     left: 0,
                //     child: ClipPath(
                //       clipper: MyClipper(),
                //       child: Opacity(
                //         opacity: 1.0,
                //         child: Image.asset(
                //           "assets/img/planner_login.jpg",
                //           width: MediaQuery.of(context).size.width,
                //         ),
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
