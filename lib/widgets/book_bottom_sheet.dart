import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../providers/book_providers.dart';

class BookBottomSheet extends StatefulWidget {
  @override
  _BookBottomSheetState createState() => _BookBottomSheetState();
}

class _BookBottomSheetState extends State<BookBottomSheet> {
  DateTime _selectedDateDue;
  DateTime _selectedDateStart;
  String _bookName;
  int _page;
  String _author;
  final _form = GlobalKey<FormState>();

  void _presentDatePicker(whichDate) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        whichDate == "s"
            ? _selectedDateStart = pickedDate
            : _selectedDateDue = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final book = Provider.of<Book>(context);

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
                  "Add a new book",
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
                  padding: const EdgeInsets.all(2.0),
                  child: TextFormField(
                    decoration: InputDecoration(labelText: "Book name"),
                    onSaved: (value) {
                      setState(() {
                        _bookName = value;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: TextFormField(
                    decoration: InputDecoration(labelText: "Author"),
                    onSaved: (value) {
                      setState(() {
                        _author = value;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: TextFormField(
                    decoration: InputDecoration(labelText: "Page"),
                    onSaved: (value) {
                      setState(() {
                        _page = int.parse(value);
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
                          _selectedDateStart == null
                              ? 'No Date Chosen For Start Date!'
                              : 'Picked Date:  ${DateFormat.yMd().format(_selectedDateStart)}',
                        ),
                      ),
                      FlatButton(
                        textColor: Theme.of(context).primaryColor,
                        child: Text(
                          'Chose Date',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        onPressed: () => _presentDatePicker("s"),
                      ),
                    ],
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
                        onPressed: () => _presentDatePicker("d"),
                      ),
                    ],
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: FlatButton(
                    onPressed: () {
                      _form.currentState.save();
                      book.add(
                        bookId: DateTime.now().toString(),
                        name: _bookName,
                        startDate: _selectedDateStart,
                        dueDate: _selectedDateDue,
                        author: _author,
                        page: _page,
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
