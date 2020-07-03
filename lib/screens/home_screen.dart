import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/habit.dart';

import '../providers/habit_provider.dart';
import '../widgets/Drawer_widget.dart';
import '../widgets/habit/habit_item_info_card.dart';

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
    List<HabitItem> habits = habit.items.values.toList();
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text("Home Page"),
          elevation: 0,
        ),
        drawer: DrawerUI(),
        body: Container(
          height: height / 1.15,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.height / 4,
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                    ),
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
                      child: Text("PLACES I VISIT"),
                    )
                    // FlatButton(
                    //   child: Text("pk"),
                    //   onPressed: () {
                    //     const url = 'http://10.0.2.2:3000/user';
                    //     fetchUser() async {
                    //       final response = await http.post(
                    //         url,
                    //         headers: <String, String>{
                    //           'Content-Type': 'application/json; charset=UTF-8'
                    //         },
                    //         body: jsonEncode(<String, String>{
                    //           'name': "Tayyip",
                    //         }),
                    //       );
                    //       print(response.body);
                    //       print(response.statusCode);
                    //       if (response.statusCode == 200) {
                    //         return User.fromJson(json.decode(response.body));
                    //       } else {
                    //         throw Exception('Failedto load user');
                    //       }
                    //     }

                    //     fetchUser();
                    //   },
                    // )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
