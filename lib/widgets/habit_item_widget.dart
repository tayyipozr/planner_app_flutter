import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/habit_provider.dart';
import '../models/habit.dart';

class HabitItemUI extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final habit = Provider.of<Habit>(context, listen: false);
    List<HabitItem> habits = habit.items.values.toList();
    return ListView.builder(
      itemCount: habit.itemCount,
      itemBuilder: (_, idx) {
        return ListTile(
          leading: habits[idx].icon,
          title: Text('${habits[idx].name}'),
          subtitle: Text("${habits[idx].start} - ${habits[idx].dueDate}"),
        );
      },
    );
  }
}
