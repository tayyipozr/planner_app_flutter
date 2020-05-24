import 'package:flutter/material.dart';

import '../screens/page_control_screen.dart';


class MyDailyPlansScreen extends StatelessWidget {
  static const routeName = "/my-daily-plans";

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pushReplacementNamed(context, PageControlScreen.routeName);
            },
          ),
          title: Text("My Daily Plans Screen"),
          centerTitle: true,
        ),
      ),
    );
  }
}
