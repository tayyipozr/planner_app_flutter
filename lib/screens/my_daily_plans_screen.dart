import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:planner_app/app_localizations.dart';
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
  bool _isLoading = false;

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });
      Provider.of<DailyPlans>(context).fetchAndSetDailyPlans();
      setState(() {
        _isLoading = false;
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final dailyPlan = Provider.of<DailyPlans>(context);
    DailyPlanItem todayPlanItem = dailyPlan.getDaily(_dateTime);
    final title = AppLocalizations.of(context).translate('daily-plans');
    Map<String, String> changedDailyPlans = {
      "tzone0": null,
      "tzone1": null,
      "tzone2": null,
      "tzone3": null,
      "tzone4": null,
      "tzone5": null,
      "tzone6": null,
      "tzone7": null,
      "tzone8": null,
      "tzone9": null,
    };

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
      "24:00",
    ];
    // List clocks = [
    //   [
    //     DropdownMenuItem(child: Text("06:00")),
    //     DropdownMenuItem(child: Text("06:30")),
    //     DropdownMenuItem(child: Text("07:00"))
    //   ],
    //   [
    //     DropdownMenuItem(child: Text("07:30")),
    //     DropdownMenuItem(child: Text("08:00")),
    //     DropdownMenuItem(child: Text("08:30"))
    //   ],
    //   [
    //     DropdownMenuItem(child: Text("09:00")),
    //     DropdownMenuItem(child: Text("09:30")),
    //     DropdownMenuItem(child: Text("10:00"))
    //   ],
    //   [
    //     DropdownMenuItem(child: Text("10:30")),
    //     DropdownMenuItem(child: Text("11:00")),
    //     DropdownMenuItem(child: Text("11:30"))
    //   ],
    //   [
    //     DropdownMenuItem(child: Text("12:00")),
    //     DropdownMenuItem(child: Text("12:30")),
    //     DropdownMenuItem(child: Text("13:00"))
    //   ],
    //   [
    //     DropdownMenuItem(child: Text("13:30")),
    //     DropdownMenuItem(child: Text("14:00")),
    //     DropdownMenuItem(child: Text("14:30"))
    //   ],
    //   [
    //     DropdownMenuItem(child: Text("15:00")),
    //     DropdownMenuItem(child: Text("15:30")),
    //     DropdownMenuItem(child: Text("16:00"))
    //   ],
    //   [
    //     DropdownMenuItem(child: Text("16:30")),
    //     DropdownMenuItem(child: Text("17:00")),
    //     DropdownMenuItem(child: Text("17:30"))
    //   ],
    //   [
    //     DropdownMenuItem(child: Text("18:00")),
    //     DropdownMenuItem(child: Text("18:30")),
    //     DropdownMenuItem(child: Text("19:00"))
    //   ],
    //   [
    //     DropdownMenuItem(child: Text("19:30")),
    //     DropdownMenuItem(child: Text("20:00")),
    //     DropdownMenuItem(child: Text("20:30"))
    //   ],
    // ];

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
        backgroundColor: Theme.of(context).primaryColor,
        toolbarHeight: height / 5.7,
        centerTitle: true,
        title: Text(title),
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/page-control');
            }),
        actions: [
          IconButton(
            icon: Icon(Icons.arrow_downward),
            onPressed: () {
              print(todayPlanItem);
              print(dailyPlan.items);
              if (dailyPlan.items.containsKey(_dateTime)) {
                dailyPlan.updateItem(todayPlanItem.idAsDate.toIso8601String(),
                    changedDailyPlans);
              } else {
                dailyPlan.add(_dateTime, changedDailyPlans);
              }
            },
          )
        ],
        bottom: _isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : PreferredSize(
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
          color: Color(0xFFF3F5E5),
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
                        // child: ShowUpAnimation(
                        //   animationDuration: Duration(seconds: 1),
                        //   curve: Curves.bounceIn,
                        //   direction: Direction.vertical,
                        //   offset: -0.5,
                        child: TextFormField(
                          key: Key(todayPlanItem == null
                              ? " "
                              : todayPlanItem.idAsDate.toString()),
                          initialValue: plans.isEmpty ? "" : plans[idx],
                          onChanged: (value) => changedDailyPlans[
                              changedDailyPlans.keys.toList()[idx]] = value,
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
                        // ),
                      )
                    : Container(),
                idx % 2 == 0
                    ? Container(
                        decoration: BoxDecoration(
                            border: Border(
                                top: BorderSide(color: colorList[idx % 4]))),
                        width: width / 8.31,
                        height: height / 13,
                        child:
                            //DropdownButton(
                            //   dropdownColor: Theme.of(context).primaryColor,
                            //   isDense: true,
                            //   iconSize: 5.0,
                            //   underline: Container(),
                            //   items: clocks[idx],
                            //   onChanged: (value) => clocks[idx] = value,
                            // )
                            Text(
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
                        child:
                            // DropdownButton(
                            //   dropdownColor: Theme.of(context).primaryColor,
                            //   isDense: true,
                            //   iconSize: 5.0,
                            //   underline: Container(),
                            //   items: clocks[idx],
                            //   onChanged: (value) => clocks[idx] = value,
                            // )
                            Text(
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
                        // child: ShowUpAnimation(
                        //   animationDuration: Duration(seconds: 1),
                        //   curve: Curves.bounceIn,
                        //   direction: Direction.vertical,
                        //   offset: 0.5,
                        child: TextFormField(
                          key: Key(todayPlanItem == null
                              ? " "
                              : todayPlanItem.idAsDate.toString()),
                          initialValue: plans.isEmpty ? "" : plans[idx],
                          onChanged: (value) => changedDailyPlans[
                              changedDailyPlans.keys.toList()[idx]] = value,
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
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
