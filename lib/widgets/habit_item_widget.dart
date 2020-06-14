import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../providers/habit_provider.dart';
import '../models/habit.dart';

class HabitItemUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final habit = Provider.of<Habit>(context);
    List<HabitItem> habits = habit.items.values.toList();
    return ListView.builder(
      itemCount: habit.itemCount,
      itemBuilder: (_, idx) {
        return Column(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            ListTile(
              leading: habits[idx].icon,
              title: Text(
                '${habits[idx].name}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                  "start: ${DateFormat.yMd().format(habits[idx].start)} - due: ${DateFormat.yMd().format(habits[idx].dueDate)}"),
              trailing: Container(
                width: 100,
                child: Row(
                  children: <Widget>[
                    IconButton(
                      color: Colors.brown,
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            //return HabitBottomSheet();
                          },
                        );
                      },
                    ),
                    IconButton(
                      color: Colors.red,
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        habit.removeItem(habits[idx].id);
                        print(habits.length);
                      },
                    )
                  ],
                ),
              ),
            ),
            Divider()
          ],
        );
      },
    );
  }
}
