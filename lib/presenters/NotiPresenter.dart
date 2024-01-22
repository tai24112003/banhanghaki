import 'dart:convert';

import 'package:bangiayhaki/models/NotificationModel.dart';
import 'package:bangiayhaki/presenters/Apiconstants.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;

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

  Future<void> insertNotification(
      {required String Name,
      required String content,
      required NotificationType,
      required int UserID}) async {
    final res =
        http.post(Uri.parse('${ApiConstants.baseUrl}/api/notifications/'),
            headers: {'Content-Type': 'application/json'},
            body: json.encode({
              'Name': Name,
              'Content': content,
              'NotificationType': NotificationType,
              'UserID': UserID
            }));
  }

  Future<List<Notifications>> getNotificationbyId(int ID) async {
    final response = await http
        .get(Uri.parse('${ApiConstants.baseUrl}/api/notifications/$ID'));

    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body);

      List<Notifications> Notificationses =
          responseData.map((data) => Notifications.fromJson(data)).toList();

      return Notificationses;
    } else {
      print(
          'Failed to load Notificationses. Status code: ${response.statusCode}');
      return [];
    }
  }
}
