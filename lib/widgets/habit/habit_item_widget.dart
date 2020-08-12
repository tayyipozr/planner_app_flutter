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
                return
                    //Dismissible(
                    //   direction: DismissDirection.startToEnd,
                    //   onDismissed: (direction) {
                    //     if (direction == DismissDirection.startToEnd) {
                    //       try {
                    //         habit.removeItem(habits[idx].id);
                    //         print(habits[idx].id);
                    //       } catch (err) {
                    //         print(err);
                    //         showDialog(
                    //           context: context,
                    //           builder: (ctx) => AlertDialog(
                    //             title: Text("An error occured"),
                    //             content: Text(err.toString()),
                    //             actions: <Widget>[
                    //               FlatButton(
                    //                 child: Text("OK"),
                    //                 onPressed: () {
                    //                   Navigator.of(context).pop();
                    //                 },
                    //               )
                    //             ],
                    //           ),
                    //         );
                    //       }
                    //       Scaffold.of(context).showSnackBar(
                    //           //place.removeItem(data[idx].id);
                    //           SnackBar(
                    //         content:
                    //             Text("${habits[idx].name} deleted from habits."),
                    //         action: SnackBarAction(
                    //           label: "UNDO",
                    //           onPressed: () {
                    //             print("bringed back");
                    //           },
                    //         ),
                    //       ));
                    //     }
                    //   },
                    //   key: Key(habits[idx].id),
                    //   child:
                    Card(
                  elevation: 5,
                  child: ListTile(
                    leading: habits[idx].icon,
                    title: Text(
                      '${habits[idx].name}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                    subtitle: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Start : ${DateFormat.yMd().format(habits[idx].start)}",
                            ),
                            Text(
                              "Due   : ${DateFormat.yMd().format(habits[idx].dueDate)}",
                            ),
                            Text(
                              "Day   : " +
                                  (habits[idx].dueDate.day - habits[idx].start.day)
                                      .toString(),
                            )
                          ],
                        ),
                        
                      ],
                    ),
                    trailing: IconButton(
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
                  ),
                );
                //  );
              },
            ),
          );
  }
}
