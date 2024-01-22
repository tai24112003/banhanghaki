import 'package:bangiayhaki/components/MyAppBar.dart';
import 'package:bangiayhaki/models/UserModel.dart';
import 'package:bangiayhaki/presenters/UserPresenter.dart';
import 'package:flutter/material.dart';

class PassWordChangeScreen extends StatefulWidget {
  const PassWordChangeScreen({required this.id, Key? key}) : super(key: key);

  final int id;

  @override
  State<PassWordChangeScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<PassWordChangeScreen>
    implements UserView {
  late TextEditingController pass = TextEditingController(text: "");
  late TextEditingController repass = TextEditingController(text: "");
  UserPresenter? presenter;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    presenter = UserPresenter(this);
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
    void submitForm() async {
      if (_formKey.currentState!.validate()) {
        setState(() {
          _isLoading = true;
        });

        bool success = await presenter?.updatePassword(
                userId: widget.id.toString(), password: pass.text) ??
            false;

        setState(() {
          _isLoading = false;
        });

        if (success) {
          // ignore: use_build_context_synchronously
          Navigator.pop(context);
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Đổi mật khẩu"),
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
                buildTextField("", label: "Mật khẩu", controller: pass),
                buildTextField("",
                    label: "Xác nhận mật khẩu", controller: repass),
                const SizedBox(height: 20),
                _isLoading
                    ? CircularProgressIndicator()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                            onPressed: submitForm,
                            child: const Text("Lưu"),
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
              if (label == "Mật khẩu") return _validatePassword(value);
              if (label == "Xác nhận mật khẩu") {
                if (repass.text != pass.text)
                  return 'Mật khẩu không giống nhau';
              }
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

  @override
  void displayMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
}
