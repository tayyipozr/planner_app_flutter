import 'package:flutter/material.dart';
import 'package:planner_app/app_localizations.dart';
import 'package:planner_app/widgets/habit/habit_item_info_card.dart';
import 'package:provider/provider.dart';

import '../models/habit.dart';
import '../models/place.dart';

import '../providers/habit_provider.dart';
import '../providers/auth.dart';
import '../providers/place_provider.dart';

class HomeScreen extends StatefulWidget {
  static const routeName = '/home';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _isInit = true;
  var _isLoading = false;

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
    final habit = Provider.of<Habit>(context);
    final place = Provider.of<Place>(context);
    final auth = Provider.of<Auth>(context);
    List<HabitItem> habits = habit.items.values.toList();
    List<PlaceItem> places = place.items.values
        .toList()
        .where((element) => element.visited == true)
        .toList();
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final welcome =
        AppLocalizations.of(context).translate('welcome').split(',');

    return _isLoading
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Container(
            height: height / 1.15,
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height / 4,
                    width: width,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30),
                      ),
                    ),
                    child: Text(
                      "${DateTime.now().hour < 12 ? welcome[0] : DateTime.now().hour < 18 ? welcome[1] : welcome[2]} ${auth.nick}",
                      style: TextStyle(
                          fontSize: 35, fontFamily: "RobotoCondensed"),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        width: 100,
                        decoration: BoxDecoration(
                          color: Color(0xFFE2F0CB),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(22),
                            bottomRight: Radius.circular(22),
                          ),
                        ),
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(
                          top: 5,
                        ),
                        child: Text("HABITS"),
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: width - 20,
                        decoration: BoxDecoration(
                            color: Color(0xFFE2F0CB),
                            borderRadius: BorderRadius.circular(22)),
                        height: MediaQuery.of(context).size.height / 5,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: habits.length,
                            itemBuilder: (ctx, idx) {
                              return HabitInfoCard();
                            }),
                      ),
                      Container(
                        width: 100,
                        decoration: BoxDecoration(
                          color: Color(0xFFE2F0CB),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(22),
                            bottomRight: Radius.circular(22),
                          ),
                        ),
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(
                          top: 5,
                        ),
                        child: Text("The Place I Visit"),
                      ),
                      Container(
                        alignment: Alignment.center,
                        width: width - 20,
                        decoration: BoxDecoration(
                            color: Color(0xFFE2F0CB),
                            borderRadius: BorderRadius.circular(22)),
                        height: MediaQuery.of(context).size.height / 5,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: places.length,
                            itemBuilder: (ctx, idx) {
                              return Text(places[idx].name);
                            }),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
  }
}
