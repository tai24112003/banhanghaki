import 'dart:convert';
import 'dart:typed_data';
import 'package:bangiayhaki/models/History.dart';
import 'package:bangiayhaki/presenters/HistoryLocal.dart';
import 'package:http/http.dart' as http;

import 'package:bangiayhaki/models/Product.dart';
import 'package:bangiayhaki/presenters/Apiconstants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HitstoryPresenter {
  static Future<List<Product>> fetchProducts(String searchTerm) async {
    final url = Uri.parse(
        '${ApiConstants.baseUrl}/api/history/search?searchTerm=$searchTerm');
    final response = await http.get(url);

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

  static Future<void> _loadSearchHistory(
      List<String> _searchHistory, int userId) async {
    try {
      final history = await SearchHistoryManager.fetchSearchHistory(userId);
      _searchHistory = history;
    } catch (e) {
      // Xử lý lỗi (nếu cần)
      print('Error loading search history: $e');
    }
  }

  static Future<List<HistorySearch>> fetchSearchHistory(int userId) async {
    final url = '${ApiConstants.baseUrl}/api/history/search-history/$userId';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      final searchHistory = data
          .map((item) => HistorySearch(
                id: item['ID'],
                content: item['Content'],
                idUser: item['UserID'],
              ))
          .toList();
      return searchHistory.cast<HistorySearch>();
    } else {
      throw Exception('Failed to fetch search history');
    }
  }

  static Future<void> addSearchHistory(String content, int userId) async {
    final url = '${ApiConstants.baseUrl}/api/history/add-history';

    final Map<String, dynamic> requestData = {
      'Content': content,
      'UserId': userId.toString(),
    };

    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(requestData),
    );

    if (response.statusCode == 200) {
      print('Thêm thành công history');
    } else {
      print('Error adding search history: ${response.statusCode}');
    }
  }

  static Future<void> deleteSearchHistory(int id) async {
    final url = '${ApiConstants.baseUrl}/api/history/delete-history/$id';

    final response = await http.delete(Uri.parse(url));

    if (response.statusCode == 200) {
      // Xóa thành công, thực hiện các thao tác khác nếu cần
    } else {
      // Xử lý lỗi và trả về phản hồi thích hợp
      print('Error deleting search history: ${response.statusCode}');
    }
  }
}
