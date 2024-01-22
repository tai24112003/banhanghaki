import 'dart:convert';
import 'dart:typed_data';
import 'package:bangiayhaki/models/History.dart';
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

  
  static const String searchHistoryKey = 'searchHistory';

  // Lấy lịch sử tìm kiếm từ server và lưu vào SharedPreferences
  static Future<List<HistorySearch>> fetchAndSaveSearchHistory(int userId) async {
    final url = '${ApiConstants.baseUrl}/api/history/search-history/$userId';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      final searchHistory = data
          .map((item) => HistorySearch.fromJson(
                item as Map<String, dynamic>,
              ))
          .toList();

      // Lưu vào SharedPreferences
      await saveSearchHistory(searchHistory);

      return searchHistory;
    } else {
      throw Exception('Failed to fetch search history');
    }
  }

  // Lưu lịch sử tìm kiếm vào SharedPreferences
  static Future<void> saveSearchHistory(List<HistorySearch> searchHistory) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> searchHistoryJsonList =
        searchHistory.map((search) => json.encode(search.toJson())).toList();
    prefs.setStringList(searchHistoryKey, searchHistoryJsonList);
  }

  // Lấy lịch sử tìm kiếm từ SharedPreferences
  static Future<List<HistorySearch>> getSearchHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? searchHistoryJsonList = prefs.getStringList(searchHistoryKey);

    if (searchHistoryJsonList != null) {
      return searchHistoryJsonList
          .map((jsonString) => HistorySearch.fromJson(json.decode(jsonString)))
          .toList();
    } else {
      return [];
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
