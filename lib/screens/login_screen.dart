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
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Color(0xFF00BBFF),
                Color(0xFF4DB5FF),
                Color(0xFF0095FF),
                Color(0xFF0077CC),
              ],
              stops: [0.1, 0.4, 0.6, 0.9],
            ),
          ),
          child: Center(
            child: Container(
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
                      borderSide: BorderSide(color: Colors.blueAccent)
                    ),
                    contentPadding: EdgeInsets.all(20.0),
                    prefixIcon: Icon(
                      Icons.person_outline,
                      color: Theme.of(context).primaryColorDark,
                    )
                  ),
                ),
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            form.currentState.save();
            Navigator.of(context).pushReplacementNamed(HomeScreen.routeName, arguments: username);
          },
          child: Text("LOG IN"),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
