import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../providers/habit_provider.dart';
import '../../helpers/notification_helper.dart';
import '../../models/habit.dart';
import 'habit_bottom_sheet_widget.dart';

class HabitItemUI extends StatefulWidget {
  @override
  _HabitItemUIState createState() => _HabitItemUIState();
}

class _HabitItemUIState extends State<HabitItemUI> {
  var _isInit = true;
  var _isLoading = false;

  Future<void> _refreshPage(BuildContext context) async {
    await Provider.of<Habit>(context, listen: false).fetchAndSetHabits();
  }

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

  @override
  Widget build(BuildContext context) {
    final habit = Provider.of<Habit>(context, listen: false);
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    double height = size.height;
    List<HabitItem> habits = habit.items.values.toList();
    return _isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : RefreshIndicator(
            onRefresh: () => _refreshPage(context),
            child: ListView.builder(
              itemCount: habit.itemCount,
              itemBuilder: (_, idx) {
                return Card(
                  elevation: 5,
                  child: ListTile(
                    leading: habits[idx].icon,
                    title: Text(
                      '${habits[idx].name}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                        "start: ${DateFormat.yMd().format(habits[idx].start)} - due: ${DateFormat.yMd().format(habits[idx].dueDate)}"),
                    trailing: Container(
                      width: width / 4,
                      child: Row(
                        children: <Widget>[
                          IconButton(
                            color: Colors.brown,
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return HabitBottomSheet(
                                    id: habits[idx].id,
                                    name: habits[idx].name,
                                    start: habits[idx].start,
                                    due: habits[idx].dueDate,
                                    fromEdit: true,
                                  );
                                },
                              );
                            },
                          ),
                          IconButton(
                            color: Colors.red,
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                  title: Text("Are you sure to delete"),
                                  content: Text(""),
                                  actions: <Widget>[
                                    FlatButton(
                                      child: Text("YES"),
                                      onPressed: () {
                                        try {
                                          habit.removeItem(habits[idx].id);
                                          print(habits[idx].id);
                                          Navigator.of(context).pop();
                                        } catch (err) {
                                          print(err);
                                          showDialog(
                                            context: context,
                                            builder: (ctx) => AlertDialog(
                                              title: Text("An error occured"),
                                              content: Text(err.toString()),
                                              actions: <Widget>[
                                                FlatButton(
                                                  child: Text("OK"),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                )
                                              ],
                                            ),
                                          );
                                        }
                                      },
                                    ),
                                    FlatButton(
                                      child: Text("NO"),
                                      onPressed: () =>
                                          Navigator.of(context).pop(),
                                    )
                                  ],
                                ),
                              );
                            },
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
  }
}
