// ignore_for_file: use_build_context_synchronously

import 'package:bangiayhaki/models/UserModel.dart';
import 'package:bangiayhaki/presenters/StoreLocal.dart';
import 'package:bangiayhaki/presenters/UserPresenter.dart';
import 'package:bangiayhaki/presenters/noti_service.dart';
import 'package:bangiayhaki/views/AddAddressScreen.dart';
import 'package:bangiayhaki/views/CheckoutScreen.dart';
import 'package:bangiayhaki/views/HomeScreen.dart';
import 'package:bangiayhaki/views/RegisterScreen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class GlobalServices {
  static NotificationServices notificationServices = NotificationServices();
  static initService(context) {
    notificationServices.requestNotificationPermission();
    notificationServices.forgroundMessage();
    notificationServices.firebaseInit(context);
    notificationServices.setupInteractMessage(context);
    notificationServices.isTokenRefresh();
  }
}

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> implements UserView {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  UserPresenter? presenter;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String token = '';
  void _submitForm() async {
    token = await NotificationServices().getDeviceToken();
    print("Token" + token);
    if (_formKey.currentState!.validate()) {
      User? user = await presenter?.Login(
          email: emailController.text, password: passwordController.text);
      if (user != null) {
        await presenter?.updateToken(UserID: user.ID, DVToken: token);
        Navigator.popUntil(context, (route) => route.isFirst);
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(id: user.ID),
            ));
      }
    }
  }

  void initState() {
    presenter = UserPresenter(this);
    GlobalServices.initService(context);
    initLocal();
  }

  void initLocal() async {
    int? id = await Stored.loadStoredText("UserID");
    print("ID" + id.toString());
    if (id != 0) {
      Navigator.popUntil(context, (route) => route.isFirst);
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(id: id!),
          ));
    }
  }

  @override
  void displayMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Divider(),
                    ),
                  ),
                  Image(image: AssetImage('assets/logo.png')),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Divider(),
                    ),
                  ),
                ],
              ),
              Text(
                "Đăng nhập",
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.9,
                decoration: BoxDecoration(color: Colors.white, boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  )
                ]),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildTextField("Email/Phone", emailController),
                        const SizedBox(height: 30),
                        buildTextField("Password", passwordController,
                            isPassword: true),
                        const SizedBox(height: 100),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: OutlinedButton(
                            onPressed: _submitForm,
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                  Colors.black,
                                ),
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)))),
                            child: const Padding(
                              padding: EdgeInsets.all(15.0),
                              child: Text(
                                "Đăng nhập",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: OutlinedButton(
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return RegisterScreen();
                              }));
                            },
                            style: ButtonStyle(
                                side: MaterialStateProperty.all(
                                    BorderSide(color: Colors.transparent)),
                                backgroundColor: MaterialStateProperty.all(
                                  Colors.transparent,
                                ),
                                shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                        side: BorderSide(
                                            color: Colors.transparent)))),
                            child: const Padding(
                              padding: EdgeInsets.all(15.0),
                              child: Text(
                                "Đăng ký",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 20),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String label, TextEditingController controller,
      {bool isPassword = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
        TextFormField(
          controller: controller,
          obscureText: isPassword,
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter $label';
            }
            return null;
          },
        ),
        const SizedBox(height: 25),
      ],
    );
  }
}
