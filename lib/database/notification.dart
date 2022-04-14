
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';

/// These comments block a warning for an undesirable naming convention
// ignore_for_file: non_constant_identifier_names
// ignore_for_file: constant_identifier_names

class NotificationApi{
  static final _notifications = FlutterLocalNotificationsPlugin();
  static final on_notifications = BehaviorSubject<String?>();


  static Future init({bool initScheduled = false}) async {
    const AndroidInitializationSettings android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const IOSInitializationSettings iOS = IOSInitializationSettings();
    const settings = InitializationSettings(android: android, iOS: iOS);

    await _notifications.initialize(
        settings,
        onSelectNotification: (payload) async{
           on_notifications.add(payload);
          }
        );
  }

  static Future _notificationDetails() async {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
      'channel id',
      'channel name',
        importance: Importance.max
      ),
    );
  }

  static Future notificationShow({
        int id = 0,
        String? title,
        String? body,
        String? payload,
      }) async =>


      _notifications.show(
          id,
          title,
          body,
          await _notificationDetails(),
          payload: payload
      );
}