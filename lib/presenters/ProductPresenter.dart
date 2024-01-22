import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:bangiayhaki/models/Product.dart';
import 'package:bangiayhaki/presenters/Apiconstants.dart';
import 'package:bangiayhaki/presenters/ProductLocal.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProductPresenter {
 static Future<List<Product>> fetchProducts(int idCategory) async {
  try {
    final response = await http.get(Uri.parse('${ApiConstants.baseUrl}/api/product/$idCategory'));
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

      // Lưu dữ liệu xuống SharedPreferences theo danh mục
      await LocalStorage.saveProducts(idCategory, products);

      return products;
    } else {
      // Nếu không thành công, thử đọc từ SharedPreferences theo danh mục
      return LocalStorage.getProducts(idCategory);
    }
  } catch (e) {
    // Nếu có lỗi khi fetch, thử đọc từ SharedPreferences theo danh mục
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
     final localProduct = LocalProduct(
        categoryId: _selectedItem, 
        productName: _productName,
        imageBase64: base64Image,
        quantity: int.parse(_quantity),
        price: double.parse(_price),
        description: _description,
      );
      await addLocalProduct(localProduct);
      print('Lỗi thêm sản phẩm: ${response.reasonPhrase}');
    }
  } catch (e) {
    print('Lỗi: $e');
  }
}

    static const String localProductsKey = 'localProducts';

    static Future<void> addLocalProduct(LocalProduct localProduct) async {
      final prefs = await SharedPreferences.getInstance();
      final localProductsJsonList = prefs.getStringList(localProductsKey) ?? [];
      localProductsJsonList.add(jsonEncode(localProduct.toJson()));
      prefs.setStringList(localProductsKey, localProductsJsonList);
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
  static void deleteProduct(int productId) async {
    final url = '${ApiConstants.baseUrl}/api/product/delete/$productId';

    try {
      final response = await http.put(Uri.parse(url));
      if (response.statusCode == 200) {
        print('Sản phẩm đã được xóa thành công');
        // widget.onReStart();
      } else {
        print('Lỗi xóa sản phẩm: ${response.statusCode}');
      }
    } catch (e) {
      print('Lỗi kết nối: $e');
    }
  }
}
