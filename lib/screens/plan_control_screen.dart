import 'package:flutter/material.dart';
import 'package:planner_app/screens/monthly_plan_screen.dart';
import 'package:planner_app/screens/my_daily_plans_screen.dart';

import 'my_daily_routines_screen.dart';

class PlanControlScreen extends StatelessWidget {
  static const routeName = '/plan-control';

  @override
  Widget build(BuildContext context) {
    final pageController = PageController(initialPage: 1);
    return PageView(
      controller: pageController,
      scrollDirection: Axis.horizontal,
      children: <Widget>[
        MonthlyPlanScreen(),
        MyDailyRoutinesScreen(),
        MyDailyPlansScreen(),
      ],
    );
  }
}
