import 'dart:convert';

import 'package:bangiayhaki/models/Product.dart';
import 'package:bangiayhaki/presenters/Apiconstants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static const String productsKey = 'products';
 static Future<void> saveProducts(int idCategory, List<Product> products) async {
  final prefs = await SharedPreferences.getInstance();
  final List<String> productsJsonList = products.map((p) => json.encode(p.toJson())).toList();
  final categoryKey = '$productsKey:$idCategory';
  prefs.setStringList(categoryKey, productsJsonList);
}

static Future<List<Product>> getProducts(int idCategory) async {
  final prefs = await SharedPreferences.getInstance();
  final categoryKey = '$productsKey:$idCategory';
  final List<String>? productsJsonList = prefs.getStringList(categoryKey);
  if (productsJsonList != null) {
    return productsJsonList.map((jsonString) => Product.fromJson(json.decode(jsonString))).toList();
  } else {
    return [];
  }
}
static Future<List<Product>> getProduct(int productId) async {
  final prefs = await SharedPreferences.getInstance();
  final categoryKey = '$productsKey:$productId';
  final List<String>? productsJsonList = prefs.getStringList(categoryKey);
  if (productsJsonList != null) {
    return productsJsonList.map((jsonString) => Product.fromJson(json.decode(jsonString))).toList();
  } else {
    return [];
  }
}
} 
class LocalProduct {

  final int productId;

  final int categoryId;
  final String productName;
  final String imageBase64;
  final int quantity;
  final double price;
  final String description;
  bool isSynced; // Trạng thái đồng bộ

  LocalProduct({
    required this.productId,

    required this.categoryId,
    required this.productName,
    required this.imageBase64,
    required this.quantity,
    required this.price,
    required this.description,
    this.isSynced = false, // Mặc định là chưa đồng bộ
  });

  Map<String, dynamic> toJson() {
    return {
      'ProductID': productId,

      'CategoryID': categoryId,
      'ProductName': productName,
      'Image': imageBase64,
      'Quantity': quantity,
      'Price': price,
      'Description': description,
      'IsSynced': isSynced,
    };
  }
}

