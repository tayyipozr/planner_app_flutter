import 'package:flutter/material.dart';

import '../widgets/Drawer_widget.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home';

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(),
        drawer: DrawerUI(),
        body: Center(
          child: Text("Home Screen"),
        ),
      ),
    );
  }
}
