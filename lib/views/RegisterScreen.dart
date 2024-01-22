import 'package:bangiayhaki/presenters/UserPresenter.dart';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> implements UserView {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  UserPresenter? presenter;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    presenter = UserPresenter(this);
    ;
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      presenter?.Register(
        email: emailController.text,
        password: passwordController.text,
        fullName: fullNameController.text,
        phoneNumber: phoneNumberController.text,
        status: '1', // Set the status accordingly
      );
    }
  }

  @override
  void displayMessage(String message) {
    // Hiển thị thông báo cho người dùng (ví dụ: sử dụng SnackBar)
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Image(image: AssetImage('assets/logo.png'), height: 100),
                const SizedBox(height: 20),
                Text(
                  "Đăng Ký",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  padding: const EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3),
                      ),
                    ],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Form(
                      key: _formKey,
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            buildTextField("Họ và tên", fullNameController),
                            buildTextField("Email", emailController),
                            buildTextField(
                                "Số điện thoại", phoneNumberController),
                            buildTextField("Password", passwordController,
                                isPassword: true),
                            buildTextField(
                                "Confirm Password", confirmPasswordController,
                                isPassword: true, isConfirm: true),
                            const SizedBox(height: 25),
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: ElevatedButton(
                                onPressed: _submitForm,
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.black),
                                  shape: MaterialStateProperty.all(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                ),
                                child: const Padding(
                                  padding: EdgeInsets.all(15.0),
                                  child: Text(
                                    "Đăng Ký",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Đã có tài khoản? "),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pushReplacementNamed(
                                        context, "/");
                                  },
                                  child: Text(
                                    "Đăng nhập",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String label, TextEditingController controller,
      {bool isPassword = false,
      bool isConfirm = false,
      bool isPhoneNumber = false}) {
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
              return 'Không được bỏ trống $label';
            } else if (isPassword && value.length < 6) {
              return 'Mật khẩu có ít nhất 6 ký tự';
            } else if (isConfirm && value != passwordController.text) {
              return 'Mật khẩu không khớp';
            } else if (isPhoneNumber &&
                !RegExp(r'^0[3789]\d{8}$').hasMatch(value)) {
              return 'Số điện thoại không hợp lệ';
            } else if (isPassword &&
                !RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(value)) {
              return 'Mật khẩu phải chứa ít nhất một ký tự đặc biệt';
            }
            return null;
          },
        ),
        const SizedBox(height: 25),
      ],
    );
  }
}
