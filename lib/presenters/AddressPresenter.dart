import 'dart:convert';
import 'package:bangiayhaki/models/AddressModel.dart';
import 'package:http/http.dart' as http;

Future<List<City>> fetchCities() async {
  final response = await http.get(
    Uri.parse(
        'https://vnprovinces.pythonanywhere.com/api/provinces/?basic=true&limit=100'),
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> data =
        json.decode(utf8.decode(response.bodyBytes));
    ;
    final List<dynamic> results = data['results'];
    return results.map((cityData) => City.fromJson(cityData)).toList();
  } else {
    throw Exception('Failed to load');
  }
}

Future<List<District>> fetchDistrictDetails(int cityId) async {
  final response = await http.get(
    Uri.parse('https://vnprovinces.pythonanywhere.com/api/provinces/$cityId/'),
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> data =
        json.decode(utf8.decode(response.bodyBytes));
    ;
    final List<dynamic> results = data['districts'];

    return results.map((cityData) => District.fromJson(cityData)).toList();
  } else {
    throw Exception('Failed to load');
  }
}

Future<List<Ward>> fetchWardDetails(int districtId) async {
  final response = await http.get(
    Uri.parse(
        'https://vnprovinces.pythonanywhere.com/api/districts/$districtId/'),
  );

  if (response.statusCode == 200) {
    final Map<String, dynamic> data =
        json.decode(utf8.decode(response.bodyBytes));
    ;
    final List<dynamic> results = data['wards'];

    return results.map((cityData) => Ward.fromJson(cityData)).toList();
  } else {
    throw Exception('Failed to load');
  }
}
