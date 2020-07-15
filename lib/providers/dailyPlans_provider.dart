import 'dart:convert';

import 'package:flutter/cupertino.dart';

import '../helpers/http_helper.dart';

import '../models/dailyplan.dart';

class DailyPlans with ChangeNotifier {
  final String authToken;
  final String userId;
  Map<String, DailyPlanItem> _items = {};

  DailyPlans.create(this.authToken, this.userId);
  DailyPlans.update(this.authToken, this.userId, this._items);

  Future<void> fetchAndSetDailyPlans() async {
    try {
      final extractedData = await MyHttp.fetch(authToken, 'dailyplans');
      final Map<String, DailyPlanItem> loadedDailyPlans = {};
      extractedData.forEach((dailyPlan) {
        loadedDailyPlans[dailyPlan['date']] = DailyPlanItem(
            DateTime.parse(dailyPlan['date']),
            dailyPlan['tzone0'],
            dailyPlan['tzone1'],
            dailyPlan['tzone2'],
            dailyPlan['tzone3'],
            dailyPlan['tzone4'],
            dailyPlan['tzone5'],
            dailyPlan['tzone6'],
            dailyPlan['tzone7'],
            dailyPlan['tzone8'],
            dailyPlan['tzone9']);
      });
      _items = loadedDailyPlans;
      notifyListeners();
    } catch (err) {
      print(err);
      throw (err);
    }
  }

  DailyPlanItem getDaily(DateTime dateTime) {
    DailyPlanItem item;
    _items.values.forEach((dailyPlanItem) {
      if ((dateTime.day == dailyPlanItem.idAsDate.day) &&
          (dateTime.month == dailyPlanItem.idAsDate.month) &&
          (dateTime.year == dailyPlanItem.idAsDate.year)) {
        item = dailyPlanItem;
      }
    });
    return item ?? null;
  }

  Map<String, DailyPlanItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  Future<void> add(DateTime id, Map<String, String> changedDailyPlans) async {
    if (!_items.containsKey(id.toString().split(" ")[0])) {
      print(id);
      print(changedDailyPlans);
      print(id.toString().split(" ")[0]);
      String body;
      Map<String, String> bodyMap = {'date': id.toString().split(" ")[0]};
      List values = [];
      changedDailyPlans.forEach((key, value) {
        values.add(value);
        if (value != "") {
          bodyMap[key] = value.trim();
        }
      });
      print(bodyMap);
      body = jsonEncode(bodyMap);
      try {
        final response = await MyHttp.post(authToken, 'dailyplans', body);
        final decodedResponse = jsonDecode(response);
        _items.putIfAbsent(
          decodedResponse,
          () => DailyPlanItem(
            DateTime.parse(decodedResponse),
            values[0],
            values[1],
            values[2],
            values[3],
            values[4],
            values[5],
            values[6],
            values[7],
            values[8],
            values[9],
          ),
        );
        notifyListeners();
      } catch (err) {
        print(err);
        throw err;
      }
    } else {
      updateItem(id.toString().split(" ")[0], changedDailyPlans);
    }
  }

  @override
  notifyListeners();

  Future<void> updateItem(
      String id, Map<String, String> changedDailyPlans) async {
    String body;
    String updateId = id.split("T")[0];
    Map<String, String> bodyMap = {};
    changedDailyPlans.forEach((key, value) {
      if (value != null) {
        bodyMap[key] = value.trim();
      }
    });
    body = jsonEncode(bodyMap);
    try {
      if (bodyMap.length >= 1) {
        await MyHttp.patch(authToken, 'dailyplans', body, updateId);
        _items.update(
          updateId,
          (existing) => DailyPlanItem(
              DateTime.parse(updateId),
              changedDailyPlans['tzone0'] == null
                  ? existing.timeZone0
                  : changedDailyPlans['tzone0'],
              changedDailyPlans['tzone1'] == null
                  ? existing.timeZone1
                  : changedDailyPlans['tzone1'],
              changedDailyPlans['tzone2'] == null
                  ? existing.timeZone2
                  : changedDailyPlans['tzone2'],
              changedDailyPlans['tzone3'] == null
                  ? existing.timeZone3
                  : changedDailyPlans['tzone3'],
              changedDailyPlans['tzone4'] == null
                  ? existing.timeZone4
                  : changedDailyPlans['tzone4'],
              changedDailyPlans['tzone5'] == null
                  ? existing.timeZone5
                  : changedDailyPlans['tzone5'],
              changedDailyPlans['tzone6'] == null
                  ? existing.timeZone6
                  : changedDailyPlans['tzone6'],
              changedDailyPlans['tzone7'] == null
                  ? existing.timeZone7
                  : changedDailyPlans['tzone7'],
              changedDailyPlans['tzone8'] == null
                  ? existing.timeZone8
                  : changedDailyPlans['tzone8'],
              changedDailyPlans['tzone9'] == null
                  ? existing.timeZone9
                  : changedDailyPlans['tzone9']),
        );
        notifyListeners();
      } else {
        print("nothing changed");
      }
    } catch (err) {
      print(err);
      throw err;
    }
  }
}
//   void removeItem(String placeId) {
//     final existingPlaceKey = _items.keys.firstWhere((key) => key == placeId);
//     var existingPlace = items[existingPlaceKey];
//     _items.removeWhere((key, value) => key == placeId);
//     notifyListeners();
//     MyHttp.delete(authToken, placeId).then((_) {
//       existingPlace = null;
//     }).catchError((err) {
//       _items[existingPlaceKey] = existingPlace;
//       print(err);
//       throw err;
//     });
//   }
// }
