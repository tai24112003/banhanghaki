import 'package:bangiayhaki/components/ProfileItem.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "QUAN DANG",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "quandang@gmail.com",
                          style: TextStyle(
                              fontSize: 12,
                              color: Color.fromRGBO(128, 128, 128, 1)),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              ProfileItem(
                title: "Đơn hàng của tôi",
                detail: "Bạn có 10 món hàng",
              ),
              ProfileItem(
                title: "Địa chỉ giao hàng",
                detail: "Bạn có 3 địa chỉ",
              ),
              ProfileItem(
                title: "Thanh toán",
                detail: "Bạn có 1 hình thức thanh toán",
              ),
              ProfileItem(
                title: "Cài đặt",
                detail: "Thông báo, đổi mật khẩu, liên hệ",
              )
            ]),
      ),
    );
  }
}
