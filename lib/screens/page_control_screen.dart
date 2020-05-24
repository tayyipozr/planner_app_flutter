import 'package:flutter/material.dart';

import 'home_screen.dart';

class PageControlScreen extends StatelessWidget {
  static const routeName = '/page-control';

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context).settings.arguments;
    final pageController = PageController();
    final pageController2 = PageController();
    return PageView(
      controller: pageController,
      scrollDirection: Axis.horizontal,
      children: <Widget>[
        HomeScreen(),
        PageView(
          controller: pageController2,
          scrollDirection: Axis.vertical,
          children: <Widget>[
            Scaffold(body: Center(child: Text("2")), backgroundColor: Colors.yellow),
            Scaffold(body: Center(child: Text("3")), backgroundColor: Colors.green),
          ],
        ),
        Scaffold(body: Center(child: Text("3")), backgroundColor: Colors.purple),
      ],
    );
  }
}
