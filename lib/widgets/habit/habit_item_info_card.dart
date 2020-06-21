import 'package:flutter/material.dart';

class HabitInfoCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        color: Color(0xFFFFDAC1),
      ),
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
     
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text("text1"),
              Text("text2"),
            ],
          ),
          Row(
            children: <Widget>[
              Text("text3"),
              Text("text4"),
            ],
          )
        ],
      ),
    );
  }
}
