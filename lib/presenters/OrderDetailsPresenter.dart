import 'dart:convert';
import 'dart:io';
import 'package:bangiayhaki/models/OrderDetailsModel.dart';
import 'package:bangiayhaki/presenters/Apiconstants.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

class OrderDetailPresenter {
  static List<OrderDetails> lstOrderDetails = List.empty();

  static Future<void> loadData(int id) async {
    HttpClient client = new HttpClient();
    client.badCertificateCallback =
        ((X509Certificate cert, String host, int port) => true);
    final req = new IOClient(client);
    final response = await req.post(
      Uri.parse('${ApiConstants.baseUrl}/api/orderdetail/get'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'id': id}),
    );
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      lstOrderDetails = data
          .map((orderdetaildata) => OrderDetails.fromJson(orderdetaildata))
          .toList();

      print(lstOrderDetails.isEmpty);
    } else {
      throw Exception('Failed to load data');
    }
  }
}
