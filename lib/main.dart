import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/page_control_screen.dart';
import './screens/home_screen.dart';
import './screens/myDailyPlans_screen.dart';
import './screens/myHabits_screen.dart';
import './screens/login_screen.dart';
import './screens/books_to_read_screen.dart';
import 'screens/book_details_screen.dart';
import 'screens/register_screen.dart';
import './screens/splash_screen.dart';

import 'providers/book_providers.dart';
import 'providers/habit_provider.dart';
import './providers/auth.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, Habit>(
          create: (BuildContext context) => Habit.create("", ""),
          update: (BuildContext context, Auth auth, Habit previous) =>
              Habit.update(auth.token, auth.userId,
                  previous == null ? {} : previous.items),
        ),
        ChangeNotifierProxyProvider<Auth, Book>(
          create: (BuildContext context) => Book.create("", ""),
          update: (BuildContext context, Auth auth, Book previous) =>
              Book.update(auth.token, auth.userId,
                  previous == null ? {} : previous.items),
        ),
      ],
      child: Consumer<Auth>(
        builder: (BuildContext context, Auth auth, Widget _) => MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primaryColor: Color(0xFFFF9AA2),
            primaryColorDark: Colors.blueGrey,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: auth.isAuth
              ? PageControlScreen()
              : FutureBuilder(
                  future: auth.tryAutoLogin(),
                  builder: (ctx, authResultSnapShot) =>
                      authResultSnapShot.connectionState ==
                              ConnectionState.waiting
                          ? SplashScreen()
                          : LoginScreen(),
                ),
          routes: {
            HomeScreen.routeName: (ctx) => HomeScreen(),
            PageControlScreen.routeName: (ctx) => PageControlScreen(),
            MyDailyPlansScreen.routeName: (ctx) => MyDailyPlansScreen(),
            MyHabitsScreen.routeName: (ctx) => MyHabitsScreen(),
            BooksToRead.routeName: (ctx) => BooksToRead(),
            BookDetailScreen.routeName: (ctx) => BookDetailScreen(),
            RegisterScreen.routeName: (ctx) => RegisterScreen()
          },
        ),
      ),
    );
  }
}
