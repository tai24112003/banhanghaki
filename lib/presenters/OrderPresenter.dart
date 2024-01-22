import 'dart:convert';
import 'dart:io';

import 'package:bangiayhaki/models/OrderModel.dart';
import 'package:bangiayhaki/presenters/Apiconstants.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

class OrderPresenter {
  static List<Order> lstOrder = [];

  static Future<void> loadData(int id) async {
    HttpClient client = new HttpClient();
    client.badCertificateCallback =
        ((X509Certificate cert, String host, int port) => true);
    final req = new IOClient(client);
    final response = await req.post(
      Uri.parse('${ApiConstants.baseUrl}/api/order/get'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'id': id}),
    );
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      lstOrder = data.map((orderData) => Order.fromJson(orderData)).toList();
    } else {
      print('Failed to load data. Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');
    }
  }

  static Future<bool> updateStt(int id) async {
    HttpClient client = new HttpClient();
    client.badCertificateCallback =
        ((X509Certificate cert, String host, int port) => true);
    final req = new IOClient(client);
    final response = await req.put(
      Uri.parse('${ApiConstants.baseUrl}/api/order/$id'),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      print('Failed to load data. Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');
      return false;
    }
  }

  static List<Order> statusFilter(String stt) {
    if (lstOrder.isEmpty) {
      return [];
    }
    return lstOrder.where((element) => element.status == stt).toList();
  }

  static Future<List<Order>> loadOrderStt() async {
    HttpClient client = new HttpClient();
    client.badCertificateCallback =
        ((X509Certificate cert, String host, int port) => true);
    final req = new IOClient(client);
    final response = await req.get(
      Uri.parse('${ApiConstants.baseUrl}/api/order/stt-xn'),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      lstOrder = data.map((orderData) => Order.fromJson(orderData)).toList();
      return lstOrder;
    } else {
      print('Failed to load data. Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');
      return List<Order>.empty();
    }
  }
}
