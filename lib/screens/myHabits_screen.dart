import 'package:flutter/material.dart';
import 'package:planner_app/app_localizations.dart';

import '../widgets/habit/habit_bottom_sheet_widget.dart';
import '../widgets/habit/habit_item_widget.dart';

import 'page_control_screen.dart';

class MyHabitsScreen extends StatelessWidget {
  static const routeName = "/my-habits";

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text(AppLocalizations.of(context).translate('habit-page')),
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
