import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class SearchHistoryManager {
  static const String _searchHistoryKey = 'searchHistory';

  static Future<List<String>> fetchSearchHistory(int userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final history = prefs.getStringList(_searchHistoryKey) ?? [];
    return history;
  }

  static Future<void> addToSearchHistory(String searchTerm) async {
    if (searchTerm == null || searchTerm.isEmpty) {
      return; // không lưu giá trị không hợp lệ
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> history = prefs.getStringList(_searchHistoryKey) ?? [];

    // Check if searchTerm already exists, remove it to add it to the front
    if (history.contains(searchTerm)) {
      history.remove(searchTerm);
    }

    // Add searchTerm to the front of the list
    history.insert(0, searchTerm);

    // Save the updated list
    await prefs.setStringList(_searchHistoryKey, history);
  }

  static Future<void> clearSearchHistory() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_searchHistoryKey);
  }

  static Future<List<String>> fetchSearchSuggestions(
    String searchTerm,
  ) async {
    // Add logic to fetch search suggestions from your API
    // This is just a placeholder
    return ['suggestion1', 'suggestion2', 'suggestion3'];
  }
}
