import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/place_provider.dart';

class PlaceBottomSheet extends StatefulWidget {
  final int belong;
  PlaceBottomSheet({this.belong});

  @override
  _PlaceBottomSheetState createState() => _PlaceBottomSheetState();
}

class _PlaceBottomSheetState extends State<PlaceBottomSheet> {
  final _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final place = Provider.of<Place>(context);
    String name;

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
          height: MediaQuery.of(context).size.height / 4,
          child: Form(
            key: _form,
            child: ListView(
              children: <Widget>[
                Text(
                  "Add a new place to go",
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
                    decoration: InputDecoration(labelText: "Place name"),
                    onSaved: (value) {
                      setState(() {
                        name = value;
                      });
                    },
                  ),
                ),
                Container(
                  alignment: Alignment.centerRight,
                  child: FlatButton(
                    onPressed: () {
                      _form.currentState.save();
                      place.add(belong: widget.belong, name: name);
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
