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

  // Factory method to create HistorySearch object from JSON
  factory HistorySearch.fromJson(Map<String, dynamic> json) {
    return HistorySearch(
      id: json['ID'],
      content: json['Content'],
      idUser: json['UserID'],
    );
  }
}

class SearchHistoryManager {
  
}
