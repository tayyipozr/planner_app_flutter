import 'package:flutter/material.dart';
import 'package:planner_app/screens/books_to_read_screen.dart';
import 'package:provider/provider.dart';

import './screens/page_control_screen.dart';
import './screens/home_screen.dart';
import './screens/myDailyPlans_screen.dart';
import './screens/myHabits_screen.dart';
import './screens/login_screen.dart';
import 'providers/book_providers.dart';
import 'providers/habit_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Habit(),
        ),
        ChangeNotifierProvider.value(
          value: Book(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primaryColor: Color(0xFFFF9AA2),
          primaryColorDark: Colors.blueGrey,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: LoginScreen(),
        routes: {
          HomeScreen.routeName: (ctx) => HomeScreen(),
          PageControlScreen.routeName: (ctx) => PageControlScreen(),
          MyDailyPlansScreen.routeName: (ctx) => MyDailyPlansScreen(),
          MyHabitsScreen.routeName: (ctx) => MyHabitsScreen(),
          BooksToRead.routeName: (ctx) => BooksToRead(),
        },
      ),
    );
  }
}
