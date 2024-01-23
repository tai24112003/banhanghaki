import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:bangiayhaki/models/History.dart';
import 'package:http/http.dart' as http;

import 'package:bangiayhaki/models/Product.dart';
import 'package:bangiayhaki/presenters/Apiconstants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HitstoryPresenter {
  static Future<List<Product>> fetchProducts(String searchTerm) async {
    bool hasNetwork = await hasNetworkConnection();
    if (hasNetwork) {
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
    } else {
      List<Product> localProducts = await getLocalProducts(searchTerm);
      return localProducts;
    }
  }

  static Future<List<Product>> getLocalProducts(String searchTerm) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? productListJson = prefs.getString('products');

    if (productListJson != null) {
      List<dynamic> data = json.decode(productListJson);
      List<Product> localProducts = [];

      for (var item in data) {
        Product product = Product.fromJson(item);
        localProducts.add(product);
      }

      return localProducts;
    } else {
      return []; 
    }
  }

  static const String searchHistoryKey = 'searchHistory';

  static Future<List<HistorySearch>> fetchAndSaveSearchHistory(
      int userId) async {
    try {
      bool hasNetwork = await hasNetworkConnection();

      if (hasNetwork) {
        final url =
            '${ApiConstants.baseUrl}/api/history/search-history/$userId';
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
          // Nếu việc lấy từ API thất bại, lấy dữ liệu từ local
          List<HistorySearch> localSearchHistory =
              await getSearchHistoryFromLocal(userId);

          if (localSearchHistory.isNotEmpty) {
            print(
                'Local search history loaded successfully: $localSearchHistory');
            return localSearchHistory;
          } else {
            throw Exception(
                'Failed to fetch search history from API and no local data available');
          }
        }
      } else {
        // Nếu không có mạng, lấy dữ liệu từ local
        List<HistorySearch> localSearchHistory =
            await getSearchHistoryFromLocal(userId);

        if (localSearchHistory.isNotEmpty) {
          print(
              'Local search history loaded successfully: $localSearchHistory');
          return localSearchHistory;
        } else {
          throw Exception('No network connection and no local data available');
        }
      }
    } catch (e) {
      throw Exception('Failed to fetch search history: $e');
    }
  }

  static Future<List<HistorySearch>> getSearchHistoryFromLocal(
      int userId) async {
    final prefs = await SharedPreferences.getInstance();
    final searchHistoryKey = 'searchHistory_$userId';

    final List<String>? searchHistoryJsonList =
        prefs.getStringList(searchHistoryKey);

    if (searchHistoryJsonList != null) {
      print('Local search history loaded successfully: $searchHistoryJsonList');
      return searchHistoryJsonList
          .map((jsonString) => HistorySearch.fromJson(json.decode(jsonString)))
          .toList();
    } else {
      print('No local search history available');
      return [];
    }
  }

  // Lưu lịch sử tìm kiếm vào SharedPreferences
  static Future<void> saveSearchHistory(
      List<HistorySearch> searchHistory) async {
    final prefs = await SharedPreferences.getInstance();
    final userId = "1";
    final searchHistoryKey = 'searchHistory_$userId';

    final searchHistoryJsonList =
        searchHistory.map((history) => json.encode(history.toJson())).toList();
    prefs.setStringList(searchHistoryKey, searchHistoryJsonList);
  }

  static Future<bool> hasNetworkConnection() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } on SocketException catch (_) {
      return false;
    }
  }

  // Lấy lịch sử tìm kiếm từ SharedPreferences
  static Future<List<HistorySearch>> getSearchHistory() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? searchHistoryJsonList =
        prefs.getStringList(searchHistoryKey);

    if (searchHistoryJsonList != null) {
      return searchHistoryJsonList
          .map((jsonString) => HistorySearch.fromJson(json.decode(jsonString)))
          .toList();
    } else {
      return [];
    }
  }

  static Future<void> addSearchHistory(String content, int userId) async {
    try {
      bool hasNetwork = await hasNetworkConnection();

      if (hasNetwork) {
        // Nếu có mạng, gửi dữ liệu lên server
        await sendSearchHistoryToServer(content, userId);
      } else {
        // Nếu không có mạng, thêm dữ liệu vào local
        await saveSearchHistoryToLocal(content, userId);
      }
    } catch (e) {
      print('Error adding search history: $e');
    }
  }

  static Future<void> sendSearchHistoryToServer(
      String content, int userId) async {
    try {
      bool hasNetwork = await hasNetworkConnection();

      if (!hasNetwork) {
        throw NetworkException('No network connection');
      }

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
        // Có thể thêm xử lý khác tùy thuộc vào yêu cầu của bạn
      }
      // ignore: nullable_type_in_catch_clause
    } on NetworkException catch (e) {
      print('NetworkException: ${e.message}');
      // Xử lý khi không có mạng
      // Có thể thêm xử lý khác tùy thuộc vào yêu cầu của bạn
    } catch (e) {
      print('Error: $e');
      // Xử lý lỗi khác tùy thuộc vào yêu cầu của bạn
    }
  }

  static Future<void> saveSearchHistoryToLocal(
      String content, int userId) async {
    try {
      // Lấy dữ liệu từ local
      List<HistorySearch> localSearchHistory =
          await getSearchHistoryFromLocal(userId);
      int nextId = await getNextSearchHistoryId(localSearchHistory);

      // Tạo đối tượng HistorySearch mới
      HistorySearch newSearchHistory = HistorySearch(
        id: nextId,
        content: content,
        idUser: userId,
      );

      // Thêm vào danh sách local
      localSearchHistory.add(newSearchHistory);

      // Lưu danh sách mới vào local
      await saveSearchHistory(localSearchHistory);
    } catch (e) {
      print('Error saving search history to local: $e');
    }
  }

  static Future<int> getNextSearchHistoryId(
      List<HistorySearch> searchHistory) async {
    if (searchHistory.isEmpty) {
      return 1; // Nếu không có lịch sử tìm kiếm, trả về 1
    }

    // Sắp xếp lịch sử tìm kiếm theo id giảm dần
    searchHistory.sort((a, b) => b.id.compareTo(a.id));

    // Lấy id của lịch sử tìm kiếm lớn nhất và cộng thêm 1
    return searchHistory.first.id! + 1;
  }

  static List<int> deletedSearchHistoryIds = [];

  static Future<void> deleteSearchHistory(int id) async {
    try {
      bool hasNetwork = await hasNetworkConnection();

      if (hasNetwork) {
        // Nếu có mạng, xóa lịch sử tìm kiếm từ server
        await sendDeleteRequestToServer(id);
        await clearSearchHistoryLocal(id);
      } else {
        // Nếu không có mạng, xóa lịch sử tìm kiếm từ local
        await clearSearchHistoryLocal(id);
      }
    } catch (e) {
      print('Error deleting search history: $e');
      // Xử lý lỗi và trả về phản hồi thích hợp
    }
  }

  static Future<void> sendDeleteRequestToServer(int id) async {
    try {
      final url = '${ApiConstants.baseUrl}/api/history/delete-history/$id';

      final response = await http.delete(Uri.parse(url));

      if (response.statusCode == 200) {
        // Xóa thành công từ server, thực hiện các thao tác khác nếu cần
        print('Search history deleted from server');
      } else {
        // Xử lý lỗi và trả về phản hồi thích hợp
        print(
            'Error deleting search history from server: ${response.statusCode}');
      }
    } catch (e) {
      print('Error deleting search history from server: $e');
      // Xử lý lỗi và trả về phản hồi thích hợp
    }
  }

  static Future<void> sendDeletedSearchHistoriesToServer() async {
    try {
      bool hasNetwork = await hasNetworkConnection();

      if (hasNetwork && deletedSearchHistoryIds.isNotEmpty) {
        // Nếu có mạng và có lịch sử đã xóa từ local, thực hiện xóa từ server
        for (int id in deletedSearchHistoryIds) {
          await sendDeleteRequestToServer(id);
        }

        // Sau khi xóa thành công từ server, xóa danh sách đã xóa
        deletedSearchHistoryIds.clear();
      }
    } catch (e) {
      print('Error sending deleted search histories to server: $e');
    }
  }

  static Future<void> syncSearchHistoryWithServer(int userId) async {
    try {
      bool hasNetwork = await hasNetworkConnection();

      if (hasNetwork) {
        // Lấy lịch sử từ local
        List<HistorySearch> localSearchHistory =
            await getSearchHistoryFromLocal(userId);

        // Gửi lịch sử lên server
        for (HistorySearch history in localSearchHistory) {
          await sendSearchHistoryToServer(history.content, userId);
        }

        // Xóa lịch sử đã gửi lên server từ local (tùy thuộc vào yêu cầu của bạn)
        await clearSearchHistoryLocal(userId);
      }
    } catch (e) {
      print('Error syncing search history: $e');
    }
  }

  static Future<void> clearSearchHistoryLocal(int userId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final key = 'searchHistory_$userId';

      // Xóa lịch sử tìm kiếm từ local
      prefs.remove(key);

      print('Search history cleared locally');
    } catch (e) {
      print('Error clearing search history locally: $e');
    }
  }
}

class NetworkException implements Exception {
  final String message;

  NetworkException(this.message);
}
