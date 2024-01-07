import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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
                "Đăng Ký",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Họ và tên",
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      const TextField(),
                      const SizedBox(
                        height: 25,
                      ),
                      const Text(
                        "Email",
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      const TextField(),
                      const SizedBox(
                        height: 25,
                      ),
                      const Text(
                        "Số điện thoại",
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      const TextField(),
                      const SizedBox(
                        height: 25,
                      ),
                      const Text(
                        "Địa chỉ",
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      const TextField(),
                      const SizedBox(
                        height: 25,
                      ),
                      const Text(
                        "Password",
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      const TextField(),
                      const SizedBox(
                        height: 25,
                      ),
                      const Text(
                        "Confirm Password",
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      const TextField(),
                      SizedBox(
                        height: 10,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: OutlinedButton(
                          onPressed: () {},
                          style: ButtonStyle(
                              backgroundColor: const MaterialStatePropertyAll(
                                Colors.black,
                              ),
                              shape: MaterialStatePropertyAll(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10)))),
                          child: const Padding(
                            padding: EdgeInsets.all(15.0),
                            child: Text(
                              "Đăng Ký",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Đã có tài khoản? "),
                          GestureDetector(
                            child: Text(
                              "Đăng nhập",
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
