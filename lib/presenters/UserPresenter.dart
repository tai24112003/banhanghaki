import 'dart:convert';

import 'package:bangiayhaki/models/UserModel.dart';
import 'package:http/http.dart' as http;
import 'package:bcrypt/bcrypt.dart';

class ApiConstants {
  static const String baseUrl =
      'https://0b5b-2402-800-63b9-bf0b-28ed-9969-13ad-e28d.ngrok-free.app';
}

abstract class UserView {
  void displayMessage(String message);
}

class UserPresenter {
  final UserView _view;

  UserPresenter(this._view);
  Future<User?> 
  getUserById(int id) async {
    final response = await http.get(
      Uri.parse('${ApiConstants.baseUrl}/api/users/'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> responseData = json.decode(response.body);
      print("object");
      print(responseData);
      return User.fromJson(
          responseData.firstWhere((element) => element['ID'] == id));
    } else {
      print('Failed to load user. Status code: ${response.statusCode}');
      return null;
    }
  }

  Future<User?> Login({required String email, required String password}) async {
    final response = await http.post(
      Uri.parse('${ApiConstants.baseUrl}/api/users/login'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'username': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      _view.displayMessage('Login successful, welcome!');
      print(responseData);
      return User.fromJson(responseData);
    } else if (response.statusCode == 401) {
      final Map<String, dynamic> responseData = json.decode(response.body);

      _view.displayMessage(responseData['message']);
    } else {
      _view.displayMessage('Failed to login. Please try again.');
    }
    return null;
  }

  Future<void> Register({
    required String email,
    required String password,
    required String fullName,
    required String phoneNumber,
    required String status,
  }) async {
    print('${ApiConstants.baseUrl}/api/users/register');
    final response = await http.post(
      Uri.parse('${ApiConstants.baseUrl}/api/users/register'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'email': email,
        'password': BCrypt.hashpw(password, BCrypt.gensalt()),
        'fullName': fullName,
        'phoneNumber': phoneNumber,
        'status': status,
      }),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      print(responseData);

      final User user = User.fromJson(responseData);
      _view
          .displayMessage('Registration successful, welcome ${user.Fullname}!');
    } else if (response.statusCode == 400) {
      _view.displayMessage('Email is already registered');
    } else {
      _view.displayMessage('Failed to register. Please try again.');
    }
  }
}
