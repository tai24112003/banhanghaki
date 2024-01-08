import 'package:bangiayhaki/components/AddressItem.dart';
import 'package:bangiayhaki/models/User.dart';
import 'package:flutter/material.dart';

class EditAddressScreen extends StatefulWidget {
  const EditAddressScreen({Key? key}) : super(key: key);

  @override
  State<EditAddressScreen> createState() => _EditAddressScreenState();
}

class _EditAddressScreenState extends State<EditAddressScreen> {
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
            AddressItem(
                address: Address(
                    FullAddress: "54 phan huy on P19 quan binh thanh",
                    NameAddress: "Tài")),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        onPressed: () {},
        backgroundColor: Colors.white,
        child: Icon(
          Icons.add, // Biểu tượng dấu cộng đen
          color: Colors.black, // Màu của biểu tượng
        ),
      ),
    );
  }
}
