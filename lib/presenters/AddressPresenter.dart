import 'dart:convert';
import 'package:bangiayhaki/models/AddressModel.dart';
import 'package:bangiayhaki/presenters/Apiconstants.dart';
import 'package:bangiayhaki/presenters/UserPresenter.dart';
import 'package:http/http.dart' as http;

abstract class AddressView {
  void displayMessage(String message);
}

class AddressPresenter {
  final AddressView _view;

  AddressPresenter(this._view);

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
      Uri.parse(
          'https://vnprovinces.pythonanywhere.com/api/provinces/$cityId/'),
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

  Future<bool> addAddress(
      {required String fullName,
      required String titleName,
      required int id}) async {
    print(fullName + titleName + id.toString());
    final response = await http.post(
      Uri.parse('${ApiConstants.baseUrl}/api/addresses/'),
      headers: {'Content-Type': 'application/json'},
      body: json
          .encode({'fullName': fullName, 'titleName': titleName, 'UserID': id}),
    );

    if (response.statusCode == 200) {
      _view.displayMessage('Add Addresses successful');
      return true;
    } else {
      _view.displayMessage('Failed to register. Please try again.');
      return false;
    }
  }

  Future<void> editAddress(
      {required int userID, required int addressID}) async {
    final response = await http.put(
      Uri.parse('${ApiConstants.baseUrl}/api/users/updateAddressId'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'userId': userID, 'addressId': addressID}),
    );

    if (response.statusCode == 200) {
      _view.displayMessage('Change Addresses successful');
    } else {
      _view.displayMessage('Failed to register. Please try again.');
    }
  }

  Future<List<Address>> getAddressByUserId(int id) async {
    final response = await http
        .get(Uri.parse('${ApiConstants.baseUrl}/api/addresses/$id/UserID'));

    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body);

      List<Address> addresses =
          responseData.map((data) => Address.fromJson(data)).toList();

      return addresses;
    } else {
      print('Failed to load addresses. Status code: ${response.statusCode}');
      return [];
    }
  }
}
