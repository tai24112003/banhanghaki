import 'package:bangiayhaki/components/ListArmchair.dart';
import 'package:bangiayhaki/components/ListBed.dart';
import 'package:bangiayhaki/components/ListChari.dart';
import 'package:bangiayhaki/components/ListLamp.dart';
import 'package:bangiayhaki/views/AdminProfileScreen.dart';
import 'package:bangiayhaki/views/HomeScreen.dart';
import 'package:bangiayhaki/views/LoginScreen.dart';
import 'package:bangiayhaki/views/NotiScreen.dart';
import 'package:bangiayhaki/views/OrderOfCus.dart';
import 'package:bangiayhaki/views/ProductsManageScreen.dart';
import 'package:bangiayhaki/views/ProfileScreen.dart';
import 'package:bangiayhaki/views/RegisterScreen.dart';
import 'package:flutter/material.dart';

class GlobalVariable {
  static final GlobalVariable _instance = GlobalVariable._internal();

  factory GlobalVariable() => _instance;

  GlobalVariable._internal();

  String myVariable =
      'https://c797-2402-800-63b7-d74a-f545-3330-10f-15a0.ngrok-free.app';
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: LoginScreen(),
    );
  }
}
