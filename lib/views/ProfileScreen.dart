import 'package:bangiayhaki/components/BottomBarCustom.dart';
import 'package:bangiayhaki/components/MyAppBar.dart';
import 'package:bangiayhaki/components/ProfileItem.dart';
import 'package:bangiayhaki/models/OrderModel.dart';
import 'package:bangiayhaki/models/UserModel.dart';
import 'package:bangiayhaki/presenters/OrderPresenter.dart';
import 'package:bangiayhaki/views/CheckoutScreen.dart';
import 'package:bangiayhaki/views/OrderScreen.dart';
import 'package:bangiayhaki/views/SettingScreen.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({required this.user, super.key});
  final User user;
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: "Thông tin cá nhân",
      ),
      bottomNavigationBar: BottomBarCustom(userid: widget.user, active: 2),
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
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.user.Fullname,
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            widget.user.Email,
                            style: const TextStyle(
                                fontSize: 12,
                                color: Color.fromRGBO(128, 128, 128, 1)),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                ProfileItem(
                  mywidget: OrderScreen(id: widget.user.ID),
                  title: "Đơn hàng của tôi",
                  detail: "Bạn có ${OrderPresenter.lstOrder.length} đơn hàng",
                ),
                ProfileItem(
                  mywidget: OrderScreen(id: widget.user.ID),
                  title: "Địa chỉ giao hàng",
                  detail: "Bạn có 3 địa chỉ",
                ),
                ProfileItem(
                  mywidget: CheckoutScreen(id: widget.user.ID),
                  title: "Thanh toán",
                  detail: "Bạn có 1 hình thức thanh toán",
                ),
                ProfileItem(
                  mywidget: SettingScreen(user: widget.user),
                  title: "Cài đặt",
                  detail: "Thông báo, đổi mật khẩu, liên hệ",
                )
              ]),
        ),
      ),
    );
  }
}
