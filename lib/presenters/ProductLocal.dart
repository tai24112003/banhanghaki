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

    if (productsJsonList != null && productsJsonList.isNotEmpty) {
      return productsJsonList.map((jsonString) => Product.fromJson(json.decode(jsonString))).toList();
    } else {
      return [];
    }
  }
static const String localProductsKey = 'products';

    static Future<void> addLocalProduct(Product localProduct) async {
      final prefs = await SharedPreferences.getInstance();
  
  // Lấy danh sách dữ liệu hiện tại từ SharedPreferences
  final localProductsJsonList = prefs.getStringList(localProductsKey) ?? [];

  // Thêm dữ liệu mới vào danh sách
  localProductsJsonList.add(jsonEncode(localProduct.toJson()));

  // Lưu lại danh sách mới vào SharedPreferences
  prefs.setStringList(localProductsKey, localProductsJsonList);

  // Kiểm tra xem liệu dữ liệu mới đã được thêm vào thành công hay không
  final updatedList = prefs.getStringList(localProductsKey);
  if (updatedList != null) {
    print("Dữ liệu đã được thêm vào thành công: $updatedList");
  } else {
    print("Có lỗi khi thêm dữ liệu vào SharedPreferences");
  }
    }

static Future<List<Product>> getProduct(int productId) async {
  final prefs = await SharedPreferences.getInstance();
  final categoryKey = '$productsKey:$productId';
  final List<String>? productsJsonList = prefs.getStringList(categoryKey);
  
  if (productsJsonList != null && productsJsonList.isNotEmpty) {
    // Tìm sản phẩm theo productId trong danh sách sản phẩm
    final List<Product> products = productsJsonList
        .map((jsonString) => Product.fromJson(json.decode(jsonString)))
        .toList();

    // Sử dụng hàm firstWhere để lấy sản phẩm có productId tương ứng
    final List<Product> selectedProduct = products
        .where((product) => product.id == productId)
        .toList();

    return selectedProduct;
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

    LocalProduct({
      required this.productId,

      required this.categoryId,
      required this.productName,
      required this.imageBase64,
      required this.quantity,
      required this.price,
      required this.description,
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
      };
    }
  
}

