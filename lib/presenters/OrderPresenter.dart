import 'dart:convert';

import 'package:bangiayhaki/models/OrderModel.dart';
import 'package:bangiayhaki/presenters/Apiconstants.dart';
import 'package:http/http.dart' as http;

class OrderPresenter {
  static List<Order> lstOrder = [];

  static Future<void> loadData(int id) async {
    final response = await http.post(
      Uri.parse('${ApiConstants.baseUrl}/api/order/get'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'id': id}),
    );
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      print(data);
      lstOrder = data.map((orderData) => Order.fromJson(orderData)).toList();
    } else {
      print('Failed to load data. Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');
      throw Exception('Failed to load data');
    }
  }

  static List<Order> statusFilter(String stt) {
    if (lstOrder.isEmpty) {
      return [];
    }
    return lstOrder.where((element) => element.status == stt).toList();
  }
}
