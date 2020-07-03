import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

import '../providers/dailyPlans_provider.dart';

import '../models/dailyplan.dart';

class MyDailyPlansScreen extends StatefulWidget {
  @override
  _MyDailyPlansScreenState createState() => _MyDailyPlansScreenState();
}

class _MyDailyPlansScreenState extends State<MyDailyPlansScreen> {
  DateTime _dateTime = DateTime.now();
  bool _isInit = true;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      Provider.of<DailyPlans>(context).fetchAndSetDailyPlans();
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final dailyPlan = Provider.of<DailyPlans>(context);
    DailyPlanItem todayPlanItem = dailyPlan.getDaily(_dateTime);

    List<Color> colorList = [
      Colors.orange,
      Colors.amber,
      Colors.purple,
      Colors.green
    ];
    List<String> plans = [];
    List clocks = [
      "06:00",
      "08:00",
      "10:00",
      "12:00",
      "14:00",
      "16:00",
      "18:00",
      "20:00",
      "22:00",
      "24:00"
    ];

    if (todayPlanItem != null) {
      print("worked");
      setState(() {
        plans = [
          todayPlanItem.timeZone0,
          todayPlanItem.timeZone1,
          todayPlanItem.timeZone2,
          todayPlanItem.timeZone3,
          todayPlanItem.timeZone4,
          todayPlanItem.timeZone5,
          todayPlanItem.timeZone6,
          todayPlanItem.timeZone7,
          todayPlanItem.timeZone8,
          todayPlanItem.timeZone9
        ];
      });
    }

    Size size = MediaQuery.of(context).size;
    final double width = size.width;
    final double height = size.height;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: height / 7,
        centerTitle: true,
        title: Text("My daily plans"),
        actions: [
          IconButton(
            icon: Icon(Icons.arrow_downward),
            onPressed: () {},
          )
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(70.0),
          child: SizedBox(
            height: 70,
            child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.date,
                initialDateTime: _dateTime,
                onDateTimeChanged: (dateTime) {
                  print(dateTime);
                  print(_dateTime);
                  setState(() {
                    _dateTime = dateTime;
                  });
                }),
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
          if (!currentFocus.hasPrimaryFocus) {
            currentFocus.unfocus();
          }
        },
        child: Container(
          padding: EdgeInsets.only(
              top: height / 100, left: width / 50, right: width / 50),
          child: ListView.builder(
            itemCount: 10,
            itemBuilder: (ctx, idx) => Row(
              mainAxisAlignment: idx % 2 == 0
                  ? MainAxisAlignment.start
                  : MainAxisAlignment.end,
              children: [
                idx % 2 == 0
                    ? Container(
                        height: height / 13,
                        width: width / 3,
                        child: TextFormField(
                          key: Key(todayPlanItem == null
                              ? " "
                              : todayPlanItem.idAsDate.toString()),
                          initialValue: plans.isEmpty ? "" : plans[idx],
                          onChanged: (value) => plans[idx] = value,
                          keyboardType: TextInputType.multiline,
                          maxLines: 2,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: colorList[idx % 4].withOpacity(0.5),
                            contentPadding: EdgeInsets.only(right: 5, left: 5),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: colorList[idx % 4])),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: colorList[idx % 4])),
                          ),
                        ),
                      )
                    : Container(),
                idx % 2 == 0
                    ? Container(
                        decoration: BoxDecoration(
                            border: Border(
                                top: BorderSide(color: colorList[idx % 4]))),
                        width: width / 8.31,
                        height: height / 13,
                        child: Text(
                          clocks[idx],
                          textAlign: TextAlign.center,
                          style: TextStyle(color: colorList[idx % 4]),
                        ),
                      )
                    : Container(
                        width: width / 8.31,
                      ),
                Container(
                  height: height / 13,
                  width: width / 19,
                  color: colorList[idx % 4],
                ),
                idx % 2 != 0
                    ? Container(
                        decoration: BoxDecoration(
                            border: Border(
                                top: BorderSide(color: colorList[idx % 4]))),
                        width: width / 8.31,
                        height: height / 13,
                        child: Text(
                          clocks[idx],
                          textAlign: TextAlign.center,
                          style: TextStyle(color: colorList[idx % 4]),
                        ),
                      )
                    : Container(
                        width: width / 8.31,
                      ),
                idx % 2 == 0
                    ? Container()
                    : Container(
                        height: height / 13,
                        width: width / 3,
                        child: TextFormField(
                          key: Key(todayPlanItem == null
                              ? " "
                              : todayPlanItem.idAsDate.toString()),
                          initialValue: plans.isEmpty ? "" : plans[idx],
                          keyboardType: TextInputType.multiline,
                          maxLines: 2,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: colorList[idx % 4].withOpacity(0.5),
                            contentPadding: EdgeInsets.only(right: 5, left: 5),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: colorList[idx % 4])),
                            enabledBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: colorList[idx % 4])),
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
