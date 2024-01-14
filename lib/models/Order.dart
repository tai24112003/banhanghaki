import 'dart:convert';
import 'package:http/http.dart' as http;

class Order {
  final int id;
  final int quantity;
  final DateTime date;
  final double totalAmount;
  final String status;

  Order({
    required this.id,
    required this.quantity,
    required this.date,
    required this.totalAmount,
    required this.status,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['ID'] as int,
      quantity: json['Quantity'] as int,
      date: DateTime.parse(json['Date'] as String),
      totalAmount: json['TotalAmount'] as double,
      status: json['Status'] as String,
    );
  }

  static List<Order> lstOrder = [];

  static Future<void> loadData() async {
    final response =
        await http.get(Uri.parse('http://127.0.0.1:3000/api/_order'));

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
