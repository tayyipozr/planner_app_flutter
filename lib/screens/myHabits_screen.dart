import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'page_control_screen.dart';
import '../providers/habit_provider.dart';

class MyHabitsScreen extends StatelessWidget {
  static const routeName = "/my-habits";

  @override
  Widget build(BuildContext context) {
    final habit = Provider.of<Habit>(context);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text("My Habits Screen"),
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pushReplacementNamed(
                  context, PageControlScreen.routeName);
            },
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                print("TABBED");
                habit.add(
                    habitId: "1", name: "Habit 1", dueDate: DateTime.now());
              },
            )
          ],
        ),
        body: ListView.builder(
          itemCount: habit.itemCount,
          itemBuilder: (_, idx) {
            return ListTile(
              title: Text('${habit.items.values.toList()[0].name}'),
            );
          },
        ),
      ),
    );
  }
}
