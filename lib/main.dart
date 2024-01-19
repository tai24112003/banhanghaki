import 'package:bangiayhaki/views/AddAddressScreen.dart';
import 'package:bangiayhaki/views/AccountManageScreen.dart';
import 'package:bangiayhaki/views/CartScreen.dart';
import 'package:bangiayhaki/views/ChatScreen.dart';
import 'package:bangiayhaki/views/CheckoutScreen.dart';
import 'package:bangiayhaki/views/CommentsScreen.dart';
import 'package:bangiayhaki/views/EditAddressScreen.dart';
import 'package:bangiayhaki/views/LoginScreen.dart';
import 'package:bangiayhaki/views/OrderOfCus.dart';
import 'package:bangiayhaki/views/CongratScreen.dart';
import 'package:bangiayhaki/views/EditAddressScreen.dart';
import 'package:bangiayhaki/views/LoginScreen.dart';
import 'package:bangiayhaki/views/OrderScreen.dart';
import 'package:bangiayhaki/views/PayMethodScreen.dart';
import 'package:bangiayhaki/views/PreviewsScreen.dart';
import 'package:bangiayhaki/views/ProfileScreen.dart';
import 'package:bangiayhaki/views/RegisterScreen.dart';
import 'package:bangiayhaki/views/HomeScreen.dart';
import 'package:bangiayhaki/views/NotiScreen.dart';
import 'package:bangiayhaki/views/ProductsManageScreen.dart';
import 'package:bangiayhaki/views/SettingScreen.dart';
import 'package:flutter/material.dart';

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
      home: OrderScreen(id: 1),
    );
  }
}
