import 'package:bangiayhaki/components/AddressItem.dart';
import 'package:bangiayhaki/models/AddressModel.dart';
import 'package:bangiayhaki/models/UserModel.dart';
import 'package:bangiayhaki/views/EditAddressScreen.dart';
import 'package:bangiayhaki/views/PayMethodScreen.dart';
import 'package:flutter/material.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Container(
            width: MediaQuery.of(context).size.width,
            child: const Text(
              "Đặt hàng",
              textAlign: TextAlign.center,
            ),
          )),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text("Địa chỉ giao hàng",
                  style: TextStyle(color: Colors.grey)),
              trailing: IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditAddressScreen(),
                        ));
                  },
                  icon: Icon(Icons.edit)),
            ),
            const SizedBox(
              height: 10,
            ),
            AddressItem(
                address: Address(
                    FullAddress: "54 phan huy on P19 quan binh thanh",
                    NameAddress: "Tài")),
            ListTile(
              title: Text("Thanh toán", style: TextStyle(color: Colors.grey)),
              trailing: IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PayMethodScreen(),
                        ));
                  },
                  icon: Icon(Icons.edit)),
            ),
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                "Thanh toán trực tiếp",
                style: TextStyle(fontSize: 17),
              ),
            ),
            Container(
              decoration:
                  const BoxDecoration(color: Color.fromRGBO(255, 255, 255, 1)),
              margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              padding: const EdgeInsets.all(10),
              child: const Row(
                children: [
                  Text("Mã giảm giá"),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: TextField(
                      decoration: InputDecoration(
                        hintText: "Chưa ra mắt",
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        fillColor: Colors.amberAccent,
                      ),
                    ),
                  )
                ],
              ),
            ),
            const ListTile(
              title: Text("Phương thức giao hàng",
                  style: TextStyle(color: Colors.grey)),
              trailing: Icon(Icons.edit),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              decoration: const BoxDecoration(color: Colors.white),
              padding: const EdgeInsets.all(10),
              child: const Text("Nhanh (2-3 ngày)"),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              decoration: BoxDecoration(color: Colors.grey.withOpacity(0.1)),
              child: const Column(
                children: [
                  ListTile(
                    title:
                        Text("Đơn hàng", style: TextStyle(color: Colors.grey)),
                    trailing: Text(
                      "95\$",
                      style: TextStyle(fontSize: 17),
                    ),
                  ),
                  ListTile(
                    title: Text("Phí vận chuyển",
                        style: TextStyle(color: Colors.grey)),
                    trailing: Text(
                      "95\$",
                      style: TextStyle(fontSize: 17),
                    ),
                  ),
                  ListTile(
                    title:
                        Text("Giảm giá", style: TextStyle(color: Colors.grey)),
                    trailing: Text(
                      "95\$",
                      style: TextStyle(fontSize: 17),
                    ),
                  ),
                  ListTile(
                    title: Text("Tổng đơn hàng",
                        style: TextStyle(color: Colors.grey)),
                    trailing: Text(
                      "95\$",
                      style: TextStyle(fontSize: 17),
                    ),
                  ),
                ],
              ),
            ),
            Container(
                margin: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                width: MediaQuery.of(context).size.width,
                child: OutlinedButton(
                  onPressed: () {},
                  style: ButtonStyle(
                      padding: MaterialStatePropertyAll(
                          EdgeInsets.fromLTRB(0, 15, 0, 15)),
                      backgroundColor:
                          const MaterialStatePropertyAll(Colors.black),
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)))),
                  child: Text(
                    "Xác nhận đơn hàng",
                    style: TextStyle(color: Colors.white),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
