import 'dart:io';
import 'package:flutter/material.dart';
import 'package:planner_app/helpers/custom_route.dart';
import 'package:planner_app/providers/auth.dart';
import 'package:provider/provider.dart';

import '../screens/books_to_read_screen.dart';
import '../screens/myHabits_screen.dart';
import '../screens/myDailyPlans_screen.dart';

class DrawerUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        elevation: 10,
        child: Container(
          color: Color(0xFFFB5EA7),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 30,
              ),
              Column(
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.perm_identity),
                    title: Text("Name"),
                    subtitle: Text("Bilgisayar mühendisi"),
                  ),
                  Divider(
                    height: 0,
                    thickness: 0.5,
                    color: Colors.black.withOpacity(0.4),
                    indent: 16,
                    endIndent: 16,
                  ),
                ],
              ),
              SizedBox(
                height: 25,
              ),
              Column(
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.loop),
                    title: Text("My Habits"),
                    onTap: () {
                      Navigator.popAndPushNamed(
                          context, MyHabitsScreen.routeName);
                      //Navigator.of(context).pushReplacement(CustomRoute(builder: (ctx) => MyHabitsScreen()));
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.timelapse),
                    title: Text("My Daily Plans"),
                    onTap: () {
                      Provider.of<Auth>(context, listen: false).tryAutoLogin();
                      Navigator.popAndPushNamed(
                          context, MyDailyPlansScreen.routeName);
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.today),
                    title: Text("My Monthly Plans"),
                    onTap: () => {},
                  ),
                  ListTile(
                    leading: Icon(Icons.calendar_today),
                    title: Text("My Yearly Plans"),
                    onTap: () => {},
                  ),
                  ListTile(
                    leading: Icon(Icons.calendar_today),
                    title: Text("Reading Book"),
                    onTap: () {
                      Navigator.popAndPushNamed(context, BooksToRead.routeName);
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 25,
              ),
              Column(
                children: <Widget>[
                  Divider(
                    height: 0,
                    thickness: 0.5,
                    color: Colors.black.withOpacity(0.4),
                    indent: 16,
                    endIndent: 16,
                  ),
                  ListTile(
                    leading: Icon(Icons.settings),
                    title: Text("Settings"),
                    onTap: () => {},
                  ),
                  ListTile(
                    leading: Icon(Icons.exit_to_app),
                    title: Text("Logout"),
                    onTap: () => logOutApp(context),
                  ),
                  ListTile(
                    leading: Icon(Icons.power_settings_new),
                    title: Text("Exit"),
                    onTap: () => exit(0),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void logOutApp(BuildContext context) {
    Navigator.of(context).pop();
    Navigator.of(context).pushReplacementNamed('/');
    Provider.of<Auth>(context, listen: false).logout();
  }
}
