import 'dart:convert';

import 'package:bangiayhaki/models/OrderModel.dart';
import 'package:http/http.dart' as http;

class OrderPresenter {
  static List<Order> lstOrder = [];

  static Future<void> loadData() async {
    final response = await http.get(Uri.parse(
        'https://7a4d-2402-9d80-349-2be8-3053-a093-c8c0-b082.ngrok-free.app/api/order/get'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      lstOrder = data.map((orderData) => Order.fromJson(orderData)).toList();
    } else {
      throw Exception('Failed to load data');
    }
  }

  static List<Order> statusfilter(String stt) {
    if (lstOrder.isEmpty) {
      return [];
    }
    return lstOrder.where((element) => element.status == stt).toList();
  }
}
