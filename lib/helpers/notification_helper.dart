import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class Notifications {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  static NotificationDetails platform;

  static void initialization(BuildContext context) {
    flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    var android = AndroidInitializationSettings('@mipmap/ic_launcher');
    var ios = new IOSInitializationSettings();
    var initSetting = new InitializationSettings(android, ios);
    flutterLocalNotificationsPlugin.initialize(initSetting,
        onSelectNotification: (String payload) async {
      debugPrint("payload : $payload");
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
                title: new Text("notification"),
                content: new Text("$payload"),
              ));
    });
  }

  static Future<void> initializeNotification(
    String channelId,
    String channelName,
    String channelDescription,
  ) async {
    var android = new AndroidNotificationDetails(
        channelId, channelName, channelDescription,
        importance: Importance.Max, priority: Priority.Max, ticker: 'ticker');
    var ios = new IOSNotificationDetails();
    platform = new NotificationDetails(android, ios);
  }

  static Future<void> showDailyAtTime(
    int notificationId,
    DateTime dateTime,
    String title,
    String body,
  ) async {
    await flutterLocalNotificationsPlugin.showDailyAtTime(notificationId, title,
        body, Time(dateTime.hour, dateTime.minute, dateTime.second), platform);
  }

  static Future<void> showWeeklyAtDayAndTime(
      int notificationId, DateTime dateTime, String title, String body) async {
    await flutterLocalNotificationsPlugin.showWeeklyAtDayAndTime(
        notificationId,
        title,
        body,
        Day(dateTime.day),
        Time(dateTime.hour, dateTime.minute, dateTime.second),
        platform);
  }

  static Future<void> show(
      int notificationId, String title, String body) async {
    await flutterLocalNotificationsPlugin.show(
        notificationId, title, body, platform);
  }

  static Future<void> periodicallyShow(int notificationId, String title,
      String body, RepeatInterval repeatInterval) async {
    await flutterLocalNotificationsPlugin.periodicallyShow(
        notificationId, title, body, repeatInterval, platform);
  }

  static Future<void> schedule(int notificationId, String title, String body,
      DateTime scheduledDate) async {
    await flutterLocalNotificationsPlugin.schedule(
        notificationId, title, body, scheduledDate, platform);
  }

  static Future<void> cancel(int notificationId) async {
    await flutterLocalNotificationsPlugin.cancel(notificationId);
  }

  static Future<void> cancelAll() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }
}
