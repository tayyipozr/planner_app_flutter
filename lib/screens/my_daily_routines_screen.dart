import 'package:flutter/material.dart';

import 'page_control_screen.dart';

class MyDailyRoutinesScreen extends StatelessWidget {
  static const routeName = "/my-daily-routines";

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pushReplacementNamed(
                  context, PageControlScreen.routeName);
            },
          ),
          title: Text("My Daily Routines"),
          centerTitle: true,
        ),
      ),
    );
  }
}
