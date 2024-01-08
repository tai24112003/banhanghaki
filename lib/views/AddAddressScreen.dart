import 'package:bangiayhaki/components/DropdownAddressItem.dart';
import 'package:flutter/material.dart';

class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({super.key});

  @override
  State<AddAddressScreen> createState() => AddAddressScreenState();
}

class AddAddressScreenState extends State<AddAddressScreen> {
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
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8.0),
              ),
              padding: EdgeInsets.all(5),
              margin: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Họ tên',
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.black87,
                    ),
                  ),
                  TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Nguyễn Văn A',
                    ),
                  ),
                ],
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8.0),
              ),
              padding: EdgeInsets.all(5),
              margin: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Địa chỉ',
                    style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.black87,
                    ),
                  ),
                  TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: '244 Thái Văn Lung',
                    ),
                  ),
                ],
              ),
            ),
            DropdownAddressItem(label: "Thành Phố/Tỉnh", list: []),
            DropdownAddressItem(label: "Quận/Huyện", list: []),
            DropdownAddressItem(label: "Ấp/Phường", list: []),
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
                    "Lưu Địa Chỉ",
                    style: TextStyle(color: Colors.white),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
