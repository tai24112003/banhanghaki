import 'package:bangiayhaki/components/MyAppBar.dart';
import 'package:bangiayhaki/firebase_options.dart';
import 'package:bangiayhaki/presenters/noti_service.dart';
import 'package:bangiayhaki/views/AddProductScreen.dart';
import 'package:bangiayhaki/views/LoginScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:io';

import 'package:bangiayhaki/testApi.dart';
import 'package:bangiayhaki/views/AddAddressScreen.dart';
import 'package:bangiayhaki/views/AccountManageScreen.dart';
import 'package:bangiayhaki/views/CartScreen.dart';
import 'package:bangiayhaki/views/ChatScreen.dart';
import 'package:bangiayhaki/views/CheckoutScreen.dart';
import 'package:bangiayhaki/views/CofirmOrderScreen.dart';
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
import 'package:bangiayhaki/components/ListArmchair.dart';
import 'package:bangiayhaki/components/ListBed.dart';
import 'package:bangiayhaki/components/ListChari.dart';
import 'package:bangiayhaki/components/ListLamp.dart';
import 'package:bangiayhaki/views/AdminProfileScreen.dart';
import 'package:bangiayhaki/views/HomeScreen.dart';
import 'package:bangiayhaki/views/NotiScreen.dart';
import 'package:bangiayhaki/views/OrderOfCus.dart';
import 'package:bangiayhaki/views/ProductsManageScreen.dart';
import 'package:bangiayhaki/views/ProfileScreen.dart';
import 'package:bangiayhaki/views/RegisterScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home:LoginScreen());
  }
}
