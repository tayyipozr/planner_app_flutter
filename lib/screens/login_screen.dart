import 'package:flutter/material.dart';

import 'page_control_screen.dart';

class LoginScreen extends StatelessWidget {
  final form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var username;

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          color: Color(0xFFFF9AA2),
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
                          style: TextStyle(fontSize: 40, fontFamily: "Raleway"),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 20, top: 50),
                        alignment: Alignment.topLeft,
                        height: MediaQuery.of(context).size.width / 5,
                        child: Image.asset("assets/img/jdi_login.png"),
                      ),
                    ],
                  ),
                  Container(
                    height: MediaQuery.of(context).size.width / 2,
                    child: Image.asset("assets/img/line_graph_login.png"),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width / 1.2,
                    child: Form(
                      key: form,
                      child: TextFormField(
                        onSaved: (value) => username = value,
                        decoration: InputDecoration(
                            hintText: "Username",
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.blueGrey),
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
                            )),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      form.currentState.save();
                      Navigator.of(context).pushReplacementNamed(
                          PageControlScreen.routeName,
                          arguments: username);
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
              Container(
                child: Positioned(
                  bottom: 0,
                  left: 0,
                  child: ClipPath(
                    clipper: MyClipper(),
                    child: Opacity(
                      opacity: 1.0,
                      child: Image.asset(
                        "assets/img/planner_login.jpg",
                        width: MediaQuery.of(context).size.width,
                      ),
                    ),
                  ),
                ),
              ),
            ],
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
