import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:planner_app/models/book.dart';
import 'package:provider/provider.dart';

import '../providers/book_providers.dart';

class BookBottomSheet extends StatefulWidget {
  final String id;
  final String name;
  final String author;
  final int page;
  final DateTime due;
  final DateTime start;
  final bool fromEdit;

  BookBottomSheet(
      {this.id,
      this.name,
      this.author,
      this.page,
      this.due,
      this.start,
      this.fromEdit = false});

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
                    initialValue: widget.name,
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
                    initialValue: widget.author,
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
                    initialValue: widget.fromEdit ? widget.page.toString() : null,
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
                              ? widget.fromEdit
                                  ? 'Picked Date:  ${widget.due}'
                                  : 'No Date Chosen For Due Date!'
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
                              ? widget.fromEdit
                                  ? 'Picked Date:  ${widget.due}'
                                  : 'No Date Chosen For Due Date!'
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
                      print(_selectedDateDue.toString() +
                          " - " +
                          widget.due.toString());
                      print(widget.name);
                      print(_bookName);
                      widget.fromEdit
                          ? book.updateItem(
                              BookItem(
                                id: widget.id,
                                author:
                                    _author == widget.author ? null : _author,
                                comment: null,
                                dueDate: _selectedDateDue,
                                isRead: null,
                                name:
                                    _bookName == widget.name ? null : _bookName,
                                page: _page == widget.page ? null : _page,
                                rating: null,
                                start: _selectedDateStart,
                              ),
                            )
                          : book.add(
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
