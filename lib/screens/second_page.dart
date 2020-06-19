import 'package:flutter/material.dart';

class SecondPage extends StatelessWidget {
  final String payload;

  const SecondPage({@required this.payload, Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Second page -Payload"),
            const SizedBox(height: 8),
            Text(payload),
            const SizedBox(height: 8),
            RaisedButton(
              child: Text("back"),
              onPressed: () => Navigator.pop(context),
            )
          ],
        ),
      ),
    );
  }
}
