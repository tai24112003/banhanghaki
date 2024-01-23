import 'dart:convert';
import 'dart:io';
import 'package:bangiayhaki/components/CartItem.dart';
import 'package:bangiayhaki/models/CartItemModel.dart';
import 'package:bangiayhaki/models/Product.dart';
import 'package:bangiayhaki/models/OrderDetailsModel.dart';
import 'package:bangiayhaki/presenters/Apiconstants.dart';
import 'package:bangiayhaki/presenters/HistoryPresenter.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

class CartPresenter {
  static List<CartItemModel> lstProIncart = List.empty();
  static Future<bool> addItemToCart(
      int? productId, int cartId, int quantity) async {
    try {
      final response = await http.post(
        Uri.parse('${ApiConstants.baseUrl}/cart'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'idpro': productId,
          'idc': cartId,
          'quan': quantity,
        }),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        // In thong bao loi khi co loi
        print(
            'Failed to add item to cart. Status code: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      // Xu ly cac loi khac neu co
      print('Error: $e');
      return false;
    }
  }

  static Future<void> loadData(int id) async {
    HttpClient client = new HttpClient();
    client.badCertificateCallback =
        ((X509Certificate cert, String host, int port) => true);
    final req = new IOClient(client);
    final response = await req.get(
      Uri.parse('${ApiConstants.baseUrl}/cart/$id'),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      lstProIncart = data
          .map((orderdetaildata) => CartItemModel.fromJson(orderdetaildata))
          .toList();
    } else {
      lstProIncart = [];
    }
  }

  static Future<bool> deleteItemInCartById(int id) async {
    HttpClient client = new HttpClient();
    client.badCertificateCallback =
        ((X509Certificate cert, String host, int port) => true);
    final req = new IOClient(client);
    final response = await req.delete(
      Uri.parse('${ApiConstants.baseUrl}/cart/$id'),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      //throw Exception('Failed to load data');
      return false;
    }
  }

  static Future<bool> deleteItemInCart(int id) async {
    HttpClient client = new HttpClient();
    client.badCertificateCallback =
        ((X509Certificate cert, String host, int port) => true);
    final req = new IOClient(client);
    final response = await req.put(Uri.parse('${ApiConstants.baseUrl}/cart'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'id': id}));
    if (response.statusCode == 200) {
      return true;
    } else {
      //throw Exception('Failed to load data');
      return false;
    }
  }

  static Future<String> getCartID(int idU) async {
    HttpClient client = new HttpClient();
    client.badCertificateCallback =
        ((X509Certificate cert, String host, int port) => true);
    final req = new IOClient(client);
    bool hasNetwork = await HitstoryPresenter.hasNetworkConnection();
    if(hasNetwork){final response = await req.get(
      Uri.parse('${ApiConstants.baseUrl}/cart/userOf/$idU'),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      return response.body.toString();
    } else {
      
      return "-1";
    }
    } return "1";
    
  }

  static Future<bool> updateItemInCart(int id, int quan) async {
    HttpClient client = new HttpClient();
    client.badCertificateCallback =
        ((X509Certificate cert, String host, int port) => true);
    final req = new IOClient(client);
    final response = await req.put(
        Uri.parse('${ApiConstants.baseUrl}/cart/$quan'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'id': id}));
    if (response.statusCode == 200) {
      return true;
    } else {
      //throw Exception('Failed to load data');
      return false;
    }
  }
}
