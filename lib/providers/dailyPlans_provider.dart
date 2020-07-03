import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

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
        DateTime formattedDate =
            DateTime.parse(dailyPlan['date'].toString().split("T")[0]);
        loadedDailyPlans[formattedDate.toString()] = DailyPlanItem(
            formattedDate,
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
      if ((dateTime.day == dailyPlanItem.idAsDate.add(Duration(days: 1)).day) &&
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
}
//   Future<void> add({String name, int belong}) async {
//     final body = jsonEncode(<String, dynamic>{
//       'name': name,
//       'belong': belong,
//     });
//     try {
//       final response = await MyHttp.post(authToken, 'places', body);
//       _items.putIfAbsent(
//         response,
//         () => DailyPlanItem(
//           id: response,
//           belong: belong,
//           name: name,
//         ),
//       );
//       notifyListeners();
//     } catch (err) {
//       print(err);
//       throw err;
//     }
//   }

//   @override
//   notifyListeners();

//   Future<void> updateItem(String id, bool visited) async {
//     final String body = jsonEncode(<String, int>{
//       'visited': visited == true ? 1 : 0,
//     });
//     try {
//       await MyHttp.patch(authToken, 'places', body, id);
//       _items.update(
//         id,
//         (existing) => DailyPlanItem(
//           name: existing.name,
//           belong: existing.belong,
//           id: existing.id,
//           visited: visited,
//         ),
//       );
//       notifyListeners();
//     } catch (err) {
//       print(err);
//       throw err;
//     }
//   }

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
