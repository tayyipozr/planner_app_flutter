import 'package:flutter/material.dart';
import 'package:planner_app/widgets/habit_bottom_sheet_widget.dart';
import 'package:planner_app/widgets/habit_item_widget.dart';
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
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return HabitBottomSheet();
                  },
                );
              },
            )
          ],
        ),
        body: HabitItemUI(),
      ),
    );
  }
}
