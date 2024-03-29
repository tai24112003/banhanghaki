import 'package:bangiayhaki/components/MyAppBar.dart';
import 'package:bangiayhaki/models/UserModel.dart';
import 'package:bangiayhaki/presenters/UserPresenter.dart';
import 'package:bangiayhaki/views/PasswordChangeScreen.dart';
import 'package:flutter/material.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({required this.user, required this.id, Key? key})
      : super(key: key);

  final User user;
  final int id;

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> implements UserView {
  late TextEditingController username =
      TextEditingController(text: widget.user.Fullname);
  late TextEditingController email =
      TextEditingController(text: widget.user.Email);
  late TextEditingController phone =
      TextEditingController(text: widget.user.Phone);
  bool switchValue = false;
  bool switchValue2 = false;
  UserPresenter? presenter;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    presenter = UserPresenter(this);
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Không được bỏ trống Email';
    } else if (!RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$')
        .hasMatch(value)) {
      return 'Vui lòng nhập một địa chỉ email hợp lệ';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Không được bỏ trống Mật khẩu';
    } else if (value.length < 6) {
      return 'Mật khẩu phải có ít nhất 6 ký tự';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cài đặt chung"),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // Handle edit action
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.all(15),
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildTextField("Thông tin cá nhân",
                    label: "Tên", controller: username),
                buildTextField("", label: "Email", controller: email),
                buildTextField("", label: "Phone", controller: phone),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: _submitForm,
                      child: const Text("Lưu"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (e) {
                          return PassWordChangeScreen(id: widget.user.ID);
                        }));
                      },
                      child: const Text("Đổi mật khẩu"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextField(String sectionTitle,
      {required String label,
      required TextEditingController controller,
      bool isPassword = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              sectionTitle,
              style: const TextStyle(color: Colors.grey, fontSize: 20),
            ),
          ],
        ),
        Container(
          margin: const EdgeInsets.only(top: 20),
          decoration: ShapeDecoration(
            color: Colors.white,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
            shadows: const [
              BoxShadow(
                color: Color(0x338A959E),
                blurRadius: 40,
                offset: Offset(0, 2),
                spreadRadius: 0,
              )
            ],
          ),
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white.withOpacity(1),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: const BorderSide(color: Colors.transparent),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: const BorderSide(color: Colors.transparent),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: const BorderSide(color: Colors.transparent),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(4),
                borderSide: const BorderSide(color: Colors.transparent),
              ),
              label: Text(
                label,
                style: const TextStyle(color: Colors.black, fontSize: 18),
              ),
            ),
            obscureText: isPassword,
            validator: (value) {
              if (label == "Email") return _validateEmail(value);
              if (label == "Mật khẩu") return _validatePassword(value);
              if (value == null || value.isEmpty) {
                return 'Không được bỏ trống $label';
              } else {
                return null;
              }
            },
          ),
        ),
      ],
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Check if the data is different from the initial data
      if (phone.text == widget.user.Phone &&
          username.text == widget.user.Fullname &&
          email.text == widget.user.Email) {
        // No changes, do not update
        displayMessage('Không có thay đổi nên không cập nhật.');
      } else {
        // Call the update method
        presenter?.updateUser(
          phone: phone.text,
          userId: widget.user.ID.toString(),
          Fullname: username.text,
          email: email.text,
        );
      }
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
}
