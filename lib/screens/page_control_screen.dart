import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = '/home';

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context).settings.arguments;
    final pageController = PageController();
    final pageController2 = PageController();
    return PageView(
      controller: pageController,
      scrollDirection: Axis.horizontal,
      children: <Widget>[
        Scaffold(body: Center(child: Text("1")), backgroundColor: Colors.blue,),
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
