import 'dart:convert';
import 'dart:typed_data';

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
static const String localProductsKey = 'productss';

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

    final int? id;
  final int quantity;
  final int idCategory;

  // Thay đổi kiểu dữ liệu của image thành Uint8List
  final Uint8List image;

  final String name;
  final double price;
  final String description;

  LocalProduct({
    required this.id,
    required this.image,
    required this.idCategory,
    required this.name,
    required this.quantity,
    required this.price,
    required this.description,
  });
static const String productsKey = 'products';

  static Future<void> saveProducts(int idCategory, List<LocalProduct> products) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> productsJsonList = products.map((p) => json.encode(p.toJson())).toList();
    final categoryKey = '$productsKey:$idCategory';
    prefs.setStringList(categoryKey, productsJsonList);
  }

  static Future<List<LocalProduct>> getProducts(int idCategory) async {
    final prefs = await SharedPreferences.getInstance();
    final categoryKey = '$productsKey:$idCategory';
    final List<String>? productsJsonList = prefs.getStringList(categoryKey);

    if (productsJsonList != null && productsJsonList.isNotEmpty) {
      return productsJsonList.map((jsonString) => LocalProduct.fromJson(json.decode(jsonString))).toList();
    } else {
      return [];
    }
  }
  factory LocalProduct.fromJson(Map<String, dynamic> json) {
    return LocalProduct(
      id: json['ID'] as int?,
      quantity: json['Quantity'] ?? 0,
      idCategory: json['CategoryID'] ?? 0,
      image: _getImageBytes(json['Image']),
      name: json['ProductName'] ?? "",
      price: (json['Price'] as num?)?.toDouble() ?? 0.0,
      description: json['Description'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'CategoryID': idCategory,
      'Image': image,
      'Quantity': quantity,
      'ProductName': name,
      'Price': price,
      'Description': description,
    };
  }

  // Phương thức hỗ trợ chuyển đổi 'Image' thành Uint8List
  static Uint8List _getImageBytes(dynamic imageData) {
    if (imageData != null && imageData['data'] is List<dynamic>) {
      List<dynamic> dataList = imageData['data'];
      List<int> bytes = dataList.map<int>((value) => value as int).toList();
      return Uint8List.fromList(bytes);
    } else {
      return Uint8List(0);
    }
  }
}

