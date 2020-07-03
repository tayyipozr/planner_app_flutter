import 'package:flutter/material.dart';
import 'package:planner_app/screens/books_to_read_screen.dart';
import 'package:planner_app/screens/places_to_go_screen.dart';

import 'home_screen.dart';
import 'my_daily_routines_screen.dart';
import 'myHabits_screen.dart';

class PageControlScreen extends StatelessWidget {
  static const routeName = '/page-control';

  @override
  Widget build(BuildContext context) {
    final pageController = PageController();
    return PageView(
      controller: pageController,
      scrollDirection: Axis.horizontal,
      children: <Widget>[
        HomeScreen(),
        MyHabitsScreen(),
        // PageView(
        //   controller: pageController2,
        //   scrollDirection: Axis.vertical,
        //   children: <Widget>[
        //     Scaffold(body: Center(child: Text("2")), backgroundColor: Colors.yellow),
        //     Scaffold(body: Center(child: Text("3")), backgroundColor: Colors.green),
        //   ],
        // ),
        MyDailyRoutinesScreen(),
        BooksToRead(),
        PlacesToGoScreen(),
      ],
    );
  }
}
