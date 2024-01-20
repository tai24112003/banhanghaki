import 'package:bangiayhaki/components/AddressItem.dart';
import 'package:bangiayhaki/models/UserModel.dart';
import 'package:flutter/material.dart';

class PayMethodScreen extends StatefulWidget {
  const PayMethodScreen({Key? key}) : super(key: key);

  @override
  State<PayMethodScreen> createState() => _PayMethodScreenState();
}

class _PayMethodScreenState extends State<PayMethodScreen> {
  bool? check = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Container(
          width: MediaQuery.of(context).size.width,
          child: const Text(
            "Địa chỉ giao hàng",
            textAlign: TextAlign.center,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(32, 0, 16, 0),
              child: Text(
                "Thanh toán trực tiếp",
                style: TextStyle(fontSize: 20),
              ),
            ),
            ListTile(
              title: const Text("Đặt làm địa chỉ giao hàng",
                  style: TextStyle(color: Colors.grey)),
              leading: Checkbox(
                value: check,
                onChanged: (bool? value) {
                  setState(() {
                    check = value;
                  });
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Padding(
                padding: EdgeInsets.fromLTRB(32, 0, 16, 0),
                child: Column(
                  children: [
                    Image(
                      image: AssetImage("assets/momo.png"),
                      width: 200,
                    ),
                    Text(
                      "Thanh toán MoMo(chưa có)",
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                )),
            ListTile(
              title: const Text("Đặt làm địa chỉ giao hàng",
                  style: TextStyle(color: Colors.grey)),
              leading: Checkbox(
                value: check,
                onChanged: (bool? value) {
                  setState(() {
                    check = value;
                  });
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
