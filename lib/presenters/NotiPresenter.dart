import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotiPresenter {
  static Future init(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    print("success<=====");
    var adrInit = new AndroidInitializationSettings('logo');
    var initSet = new InitializationSettings(android: adrInit);
    await flutterLocalNotificationsPlugin.initialize(initSet);
    print("success=====>");
  }

  static Future showNoti(
      {var id = 0,
      required String title,
      required String body,
      var payload,
      required FlutterLocalNotificationsPlugin fln}) async {
    AndroidNotificationDetails adrChanelSpecific =
        const AndroidNotificationDetails('2', 'haki_store',
            playSound: true,
            importance: Importance.max,
            priority: Priority.high);
    var noti = NotificationDetails(android: adrChanelSpecific);

    await fln.show(id, title, body, noti);
    print("show");
  }


  
}
