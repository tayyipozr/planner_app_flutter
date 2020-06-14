import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../providers/habit_provider.dart';

class HabitBottomSheet extends StatefulWidget { 
  @override
  _HabitBottomSheetState createState() => _HabitBottomSheetState();
}

class _HabitBottomSheetState extends State<HabitBottomSheet> {
  DateTime _selectedDateDue;
  var _selectedIcon;
  String _habitName;
  final _form = GlobalKey<FormState>();

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 90)),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDateDue = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final habit = Provider.of<Habit>(context);

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Padding(
        padding:
            EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          height: MediaQuery.of(context).size.height / 2.2,
          child: Form(
            key: _form,
            child: ListView(
              children: <Widget>[
                Text(
                  "Add a new habit",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: "RobotoCondensed",
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(offset: Offset(0.5, 2), color: Colors.grey)
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(labelText: "Habit name"),
                    onSaved: (value) {
                      setState(() {
                        _habitName = value;
                      });
                    },
                  ),
                ),
                Container(
                  height: 50,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          _selectedDateDue == null
                              ? 'No Date Chosen For Due Date!'
                              : 'Picked Date:  ${DateFormat.yMd().format(_selectedDateDue)}',
                        ),
                      ),
                      FlatButton(
                        textColor: Theme.of(context).primaryColor,
                        child: Text(
                          'Chose Date',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        onPressed: () => _presentDatePicker(),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text("Chose an icon for your habit"),
                      SingleChildScrollView(
                        child: DropdownButton(
                          value: _selectedIcon == null
                              ? Icons.loop
                              : _selectedIcon,
                          items: [
                            DropdownMenuItem(
                                value: Icons.loop, child: Icon(Icons.loop)),
                            DropdownMenuItem(
                                value: Icons.book, child: Icon(Icons.book)),
                            DropdownMenuItem(
                                value: Icons.computer,
                                child: Icon(Icons.computer)),
                            DropdownMenuItem(
                                value: Icons.phone_android,
                                child: Icon(Icons.phone_android)),
                          ],
                          onChanged: (value) {
                            setState(() {
                              _selectedIcon = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: FlatButton(
                    onPressed: () {
                      _form.currentState.save();
                      habit.add(
                        name: _habitName,
                        habitId: DateTime.now().toString(),
                        dueDate: _selectedDateDue,
                        icon: _selectedIcon,
                      );
                      Navigator.pop(context);
                    },
                    child: Text(
                      "Save",
                      style: TextStyle(fontSize: 20, color: Colors.blue),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
