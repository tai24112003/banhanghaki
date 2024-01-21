import 'package:bangiayhaki/presenters/UserPresenter.dart';
import 'package:flutter/material.dart';

class ProfileAddressScreen extends StatefulWidget {
  const ProfileAddressScreen({required this.id, required this.adr, Key? key})
      : super(key: key);

  final String? adr;
  final int id;

  @override
  _ProfileAddressScreenState createState() => _ProfileAddressScreenState();
}

class _ProfileAddressScreenState extends State<ProfileAddressScreen>
    implements UserView {
  late TextEditingController _addressController;
  UserPresenter? presenter;
  @override
  void initState() {
    super.initState();
    _addressController = TextEditingController(text: widget.adr);
    presenter = UserPresenter(this);
    ;
  }

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
      appBar: AppBar(
        title: const Text("Địa chỉ"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Địa chỉ của bạn:"),
              TextField(
                controller: _addressController,
                decoration: InputDecoration(
                  hintText: "Địa chỉ",
                  border: const OutlineInputBorder(),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      presenter?.updateAddress(
                          userId: widget.id.toString(),
                          address: _addressController.text);
                    },
                    child: const Text("Lưu"),
                  ),
                  Text(_addressController.text),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
