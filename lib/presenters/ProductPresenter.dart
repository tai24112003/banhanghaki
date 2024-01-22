import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:bangiayhaki/models/Item.dart';
import 'package:bangiayhaki/presenters/Apiconstants.dart';
import 'package:http/http.dart' as http;

class ProductPresenter {
  static Future<List<Product>> fetchProducts(int idCategory) async {
    final response = await http
        .get(Uri.parse('${ApiConstants.baseUrl}/api/product/$idCategory'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List<dynamic>;
      List<Product> products = [];

      for (var item in data) {
        dynamic imageValue = item['Image'];
        List<dynamic> dataList = imageValue['data'];

        List<int> imageData =
            dataList.map<int>((value) => value as int).toList();
        Uint8List uint8List = Uint8List.fromList(imageData);

        Product product = Product(
          id: item['ID'],
          idCategory: item['CategoryID'],
          image: uint8List,
          quantity: item['Quantity'],
          name: item['ProductName'],
          price: (item['Price'] as num).toDouble(),
          description: item['Description'],
        );
        products.add(product);
      }

      return products;
    } else {
      throw Exception('Failed to fetch products');
    }
  }

  static Future<void> addProduct(
      File? _imageFile,
      int _selectedItem,
      String _productName,
      String _quantity,
      String _price,
      String _description) async {
    if (_imageFile == null) {
      print('Lỗi: Hình ảnh không tồn tại');
      return;
    }

    final url = Uri.parse('${ApiConstants.baseUrl}/api/product/add_Product');

    final bytes = await _imageFile!.readAsBytes();
    final base64Image = base64Encode(bytes);

    final product = {
      'CategoryID': _selectedItem,
      'ProductName': _productName,
      'Image': base64Image,
      'Quantity': int.parse(_quantity),
      'UnitPrice': double.parse(_price),
      'Color': "White",
      'Description': _description,
    };

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(product),
    );

    if (response.statusCode == 200) {
      print('Sản phẩm đã được thêm thành công');
    } else {
      print('Lỗi thêm sản phẩm: ${response.reasonPhrase}');
    }
  }

  static Future<void> updateProduct(
      File? _imageFile,
      int _selectedItem,
      String _productName,
      String _quantity,
      String _price,
      String _description,
      int id) async {
    if (_imageFile == null) {
      print('Lỗi: Hình ảnh không tồn tại');
      return;
    }

    final url = Uri.parse('${ApiConstants.baseUrl}/api/product/update/$id');

    final bytes = await _imageFile!.readAsBytes();
    final base64Image = base64Encode(bytes);

    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({
      'ID': id,
      'CategoryID': _selectedItem,
      'ProductName': _productName,
      'Image': base64Image,
      'Quantity': int.parse(_quantity),
      'UnitPrice': double.parse(_price),
      'Color': "White",
      'Description': _description,
    });

    final response = await http.put(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      print('Sản phẩm đã được cập nhật thành công');
    } else {
      print('Lỗi cập nhật sản phẩm: ${response.reasonPhrase}');
    }
  }

  static Future<Product> fetchProduct(int productId) async {
    final response = await http
        .get(Uri.parse('${ApiConstants.baseUrl}/api/product/$productId'));

    if (response.statusCode == 200) {
      final jsonData = json.decode(response.body) as Map<String, dynamic>;

      dynamic imageValue = jsonData['Image'];
      List<dynamic> dataList = imageValue['data'];
      List<int> imageData = dataList.map<int>((value) => value as int).toList();
      Uint8List uint8List = Uint8List.fromList(imageData);

      Product product = Product(
        id: jsonData['ID'],
        name: jsonData['ProductName'],
        idCategory: jsonData['CategoryID'],
        image: uint8List,
        quantity: jsonData['Quantity'],
        price: jsonData['UnitPrice'].toDouble(),
        description: jsonData['Description'],
      );

      return product;
    }

    if (response.statusCode == 404) {
      throw Exception('Product not found');
    }

    throw Exception('Failed to fetch product');
  }
}
