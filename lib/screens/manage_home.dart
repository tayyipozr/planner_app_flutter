import 'package:flutter/material.dart';
import 'package:planner_app/screens/books_to_read_screen.dart';
import 'package:planner_app/screens/plan_control_screen.dart';
import 'package:planner_app/screens/profile_screen.dart';
import 'package:provider/provider.dart';

import '../app_localizations.dart';
import '../screens/home_screen.dart';
import '../screens/places_to_go_screen.dart';
import '../providers/habit_provider.dart';

class ManageHomeScreen extends StatefulWidget {
  static const routeName = '/manage-home';

  @override
  _ManageHomeScreenState createState() => _ManageHomeScreenState();
}

class _ManageHomeScreenState extends State<ManageHomeScreen> {
  var _isInit = true;
  var _isLoading = false;

  int _selectedIndex = 0;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<Habit>(context).fetchAndSetHabits().then((_) => {
            setState(() {
              _isLoading = false;
            })
          });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  final _widgetOptions = [
    HomeScreen(),
    PlacesToGoScreen(),
    BooksToRead(),
    PlanControlScreen(),
    ProfileScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Scaffold(
            body: _widgetOptions.elementAt(_selectedIndex),
            bottomNavigationBar: BottomNavigationBar(
              backgroundColor: Colors.purple,
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  title: Text('Home'),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.flight),
                  title: Text('To Go'),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.book),
                  title: Text('Books'),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.calendar_view_day),
                  title: Text('Plans'),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.account_circle),
                  title: Text('Profile'),
                ),
              ],
              currentIndex: _selectedIndex,
              unselectedItemColor: Colors.black,
              selectedItemColor: Colors.amber[800],
              onTap: _onItemTapped,
            ),
          );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
