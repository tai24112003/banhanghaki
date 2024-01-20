import 'package:bangiayhaki/components/MyAppBar.dart';
import 'package:bangiayhaki/components/ProfileItem.dart';
import 'package:flutter/material.dart';

class AdminProfileScreen extends StatefulWidget {
  const AdminProfileScreen({super.key});

  @override
  State<AdminProfileScreen> createState() => _AdminProfileScreenState();
}

class _AdminProfileScreenState extends State<AdminProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          child: MyAppBar(
            title: "Thông tin cá nhân",
          ),
          preferredSize: const Size.fromHeight(95),
        ),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Container(
                            alignment: Alignment.center,
                            height: MediaQuery.of(context).size.height * 0.2,
                            width: MediaQuery.of(context).size.width * 0.3,
                            decoration: BoxDecoration(
                                border: Border.all(), shape: BoxShape.circle),
                            child: const Text(
                              "QD",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  // ProfileItem(
                  //   title: "Đơn hàng chờ xác nhận",
                  //   detail: "Bạn có 10 món hàng",
                  // ),
                  // ProfileItem(
                  //   title: "Khách hàng hôm nay",
                  //   detail: "Bạn có 22 thông báo",
                  // ),
                  // ProfileItem(
                  //   title: "Sản phẩm của tôi",
                  //   detail: "Bạn có 22 thông báo",
                  // ),
                  // ProfileItem(
                  //   title: "Phương thức thanh toán",
                  //   detail: "Bạn có 1 hình thức thanh toán",
                  // ),
                  // ProfileItem(
                  //   title: "Cài đặt",
                  //   detail: "Thông báo, đổi mật khẩu, liên hệ",
                  // )
                ]),
          ),
        ));
  }
}
