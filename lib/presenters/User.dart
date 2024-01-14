import 'dart:convert';

import 'package:bangiayhaki/models/User.dart';
import 'package:http/http.dart' as http;
import 'package:bcrypt/bcrypt.dart';

class ApiConstants {
  static const String host = '0.tcp.ap.ngrok.io';
  static const int port = 14570;
  static const String baseUrl = 'http://$host:$port/api';
}

abstract class UserView {
  void displayMessage(String message);
}

class UserPresenter {
  final UserView _view;

  UserPresenter(this._view);

  Future<void> Login(String email, String password) async {
    final response = await http.post(
      Uri.parse('${ApiConstants.baseUrl}/login'),
      body: {
        'email': email,
        'password': BCrypt.hashpw(password, BCrypt.gensalt())
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final User user = User.fromJson(responseData);
      _view.displayMessage('Login successful, welcome ${user.Fullname}!');
    } else if (response.statusCode == 401) {
      _view.displayMessage('Invalid email or password');
    } else {
      _view.displayMessage('Failed to login. Please try again.');
    }
  }

  Future<void> Register({
    required String email,
    required String password,
    required String fullName,
    required String phoneNumber,
    required String address,
    required String status,
  }) async {
    print(email);
    final response = await http.post(
      Uri.parse('${ApiConstants.baseUrl}/register'),
      body: {
        'email': email,
        'password': password,
        'fullName': fullName,
        'phoneNumber': phoneNumber,
        'address': address,
        'status': status,
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
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
