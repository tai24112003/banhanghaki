import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:bangiayhaki/models/Product.dart';
import 'package:bangiayhaki/presenters/Apiconstants.dart';
import 'package:bangiayhaki/presenters/ProductLocal.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProductPresenter {
  static Future<Product?> fetchProduct(int productId) async {
    try {
      final response = await http
          .get(Uri.parse('${ApiConstants.baseUrl}/api/product/pro/$productId'));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body) as Map<String, dynamic>;

        List<int> imageData =
            (jsonData['Image']['data'] as List<dynamic>).cast<int>();
        Uint8List uint8List = Uint8List.fromList(imageData);
        Product product = Product(
          id: jsonData['ID'],
          idCategory: jsonData['CategoryID'],
          image: uint8List,
          quantity: jsonData['Quantity'],
          name: jsonData['ProductName'],
          price: (jsonData['Price'] as num?)?.toDouble() ?? 0.0,
          description: jsonData['Description'],
        );

        return product;
      } else {
        print('Failed to fetch product from API');
        return null;
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  static Future<List<Product>> fetchProducts(int idCategory) async {
    try {
      final response = await http
          .get(Uri.parse('${ApiConstants.baseUrl}/api/product/$idCategory'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as List<dynamic>;
        List<Product> products = [];

        for (var item in data) {
          Product product = Product.fromJson(item);
          products.add(product);
        }

        // Lưu dữ liệu vào local storage
        await LocalStorage.saveProducts(idCategory, products);

        return products;
      } else {
        // Trả về dữ liệu từ local storage nếu có lỗi
        return LocalStorage.getProducts(idCategory);
      }
    } catch (e) {
      // Trả về dữ liệu từ local storage nếu có lỗi
      return LocalStorage.getProducts(idCategory);
    }
  }

  static Future<void> addProduct(
      File? _imageFile,
      int _selectedItem,
      String _productName,
      String _quantity,
      String _price,
      String _description) async {
    try {
      if (_imageFile == null) {
        throw Exception('Lỗi: Hình ảnh không tồn tại');
      }

      final url = Uri.parse('${ApiConstants.baseUrl}/api/product/add_Product');

      final bytes = await _imageFile.readAsBytes();
      final base64Image = base64Encode(bytes);

      final product = {
        'CategoryID': _selectedItem,
        'ProductName': _productName,
        'Image': base64Image,
        'Quantity': int.parse(_quantity),
        'Price': double.parse(_price),
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
        //   List<int> imageBytes = await _imageFile!.readAsBytes();
        //  final localProduct = Product(
        //   id: null,
        //     idCategory: _selectedItem,
        //     name: _productName,
        //     image: imageBytes,
        //     quantity: int.parse(_quantity),
        //     price: double.parse(_price),
        //     description: _description,
        //   );
        //   await LocalStorage.addLocalProduct(localProduct);
        //   print('Lỗi thêm sản phẩm: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Lỗi: $e');
    }
  }

  static Future<void> updateProduct(
      File? _imageFile,
      int _selectedItem,
      String _productName,
      String _quantity,
      String _price,
      String _description,
      int? id) async {
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
      'Price': double.parse(_price),
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

  static void deleteProduct(int? productId) async {
    final url = '${ApiConstants.baseUrl}/api/product/delete/$productId';

    try {
      final response = await http.put(Uri.parse(url));
      if (response.statusCode == 200) {
        print('Sản phẩm đã được xóa thành công');
      } else {
        print('Lỗi xóa sản phẩm: ${response.statusCode}');
      }
    } catch (e) {
      print('Lỗi kết nối: $e');
    }
  }
}
