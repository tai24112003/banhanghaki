import 'dart:convert';
import 'package:bangiayhaki/models/OrderDetailsModel.dart';
import 'package:http/http.dart' as http;

class OrderDetailPresenter {
  static List<OrderDetails> lstOrderDetails = List.empty();

  static Future<void> loadData() async {
    final response = await http.get(Uri.parse(
        'https://7a4d-2402-9d80-349-2be8-3053-a093-c8c0-b082.ngrok-free.app/api/orderdetails/get'));

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      print(data);
      lstOrderDetails = data
          .map((orderdetaildata) => OrderDetails.fromJson(orderdetaildata))
          .toList();

      print(lstOrderDetails.isEmpty);
    } else {
      throw Exception('Failed to load data');
    }
  }

  static List<OrderDetails> statusfilter(int id) {
    if (lstOrderDetails.isEmpty) {
      return [];
    }
    return lstOrderDetails.where((element) => element.OrderID == id).toList();
  }
}
