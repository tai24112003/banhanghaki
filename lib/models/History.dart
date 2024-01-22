import 'dart:convert';

import 'package:bangiayhaki/presenters/Apiconstants.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HistorySearch {
  final int id;
  final String content;
  final int idUser;

  HistorySearch({
    required this.id,
    required this.content,
    required this.idUser,
  });
  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'Content': content,
      'UserID': idUser,
    };
  }

  factory HistorySearch.fromJson(Map<String, dynamic> json) {
    return HistorySearch(
      id: json['ID'],
      content: json['Content'],
      idUser: json['UserID'],
    );
  }
}
class LocalStorage {
  static const String searchHistoryKey = 'searchHistory';

  // Lưu lịch sử tìm kiếm vào SharedPreferences
  static Future<void> saveSearchHistory(String searchTerm) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> searchHistory = prefs.getStringList(searchHistoryKey) ?? [];
    searchHistory.insert(0, searchTerm);
    prefs.setStringList(searchHistoryKey, searchHistory);
  }

  // Lấy danh sách lịch sử tìm kiếm từ SharedPreferences
  static Future<List<String>> getSearchHistory() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(searchHistoryKey) ?? [];
  }
}
