import 'dart:convert';
import 'dart:io';
import 'package:bangiayhaki/components/CartItem.dart';
import 'package:bangiayhaki/models/CartItemModel.dart';
import 'package:bangiayhaki/models/Item.dart';
import 'package:bangiayhaki/models/MessageModel.dart';
import 'package:bangiayhaki/models/OrderDetailsModel.dart';
import 'package:bangiayhaki/presenters/Apiconstants.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

class MessagePresenter {
  static List<MessageConvert> lstProIncart = List.empty();

  static Future<void> loadData(int id) async {
    HttpClient client = new HttpClient();
    client.badCertificateCallback =
        ((X509Certificate cert, String host, int port) => true);
    final req = new IOClient(client);
    final response = await req.get(
      Uri.parse('${ApiConstants.baseUrl}/message/$id'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      print(data);
      lstProIncart = data.map((orderdetaildata) {
        print("===>${orderdetaildata["MessageText"]}");
        return MessageConvert.fromJson({
          "FromID": orderdetaildata["FromID"],
          "MessageText": orderdetaildata["MessageText"]
        });
      }).toList();
    } else {
      //throw Exception('Failed to load data');
      lstProIncart = [];
    }
  }

  static Future<void> loadDataAdmin(int id) async {
    HttpClient client = new HttpClient();
    client.badCertificateCallback =
        ((X509Certificate cert, String host, int port) => true);
    final req = new IOClient(client);
    final response = await req.get(
      Uri.parse('${ApiConstants.baseUrl}/message/$id'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      lstProIncart = data.map((orderdetaildata) {
        return MessageConvert.fromJson({
          "FromID": orderdetaildata["FromID"],
          "MessageText": orderdetaildata["MessageText"]
        });
      }).toList();
    } else {
      //throw Exception('Failed to load data');
      lstProIncart = [];
    }
  }
}
