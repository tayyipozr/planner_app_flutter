import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/page_control_screen.dart';
import './screens/home_screen.dart';
import './screens/myDailyPlans_screen.dart';
import './screens/myHabits_screen.dart';
import './screens/login_screen.dart';
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
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          primaryColor: Colors.blueAccent,
          primaryColorDark: Colors.blueGrey,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: LoginScreen(),
        routes: {
          HomeScreen.routeName: (ctx) => HomeScreen(),
          PageControlScreen.routeName: (ctx) => PageControlScreen(),
          MyDailyPlansScreen.routeName: (ctx) => MyDailyPlansScreen(),
          MyHabitsScreen.routeName: (ctx) => MyHabitsScreen(),
        },
      ),
    );
  }
}
