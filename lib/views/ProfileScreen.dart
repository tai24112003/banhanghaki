import 'package:bangiayhaki/components/ProfileItem.dart';
import 'package:bangiayhaki/models/UserModel.dart';
import 'package:bangiayhaki/presenters/OrderPresenter.dart';
import 'package:bangiayhaki/presenters/StoreLocal.dart';
import 'package:bangiayhaki/presenters/UserPresenter.dart';
import 'package:bangiayhaki/views/CheckoutScreen.dart';
import 'package:bangiayhaki/views/EditAddressScreen.dart';
import 'package:bangiayhaki/views/LoginScreen.dart';
import 'package:bangiayhaki/views/OrderScreen.dart';
import 'package:bangiayhaki/views/PayMethodScreen.dart';
import 'package:bangiayhaki/views/SettingScreen.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({required this.id, super.key});
  final int id;

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> implements UserView {
  late UserPresenter userPresenter;
  late Future<User?> userFuture;
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    userPresenter = UserPresenter(this);
    userFuture = loadUser();
  }

  Future<User?> loadUser() async {
    return userPresenter.getUserById(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.search),
          onPressed: () {},
        ),
        backgroundColor: Colors.transparent,
        title: Container(
          width: MediaQuery.of(context).size.width,
          child: const Text(
            "Đặt hàng",
            textAlign: TextAlign.center,
          ),
        ),
      ),
      body: FutureBuilder<User?>(
        future: userFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data == null) {
            return Center(
              child: Text('Failed to load user data.'),
            );
          } else {
            User user = snapshot.data!;
            return buildProfileView(user);
          }
        },
      ),
    );
  }

  String getAvatarText(User user) {
    print(user.Fullname);
    if (user.Fullname.isNotEmpty) {
      if (user.Fullname.contains(' ')) {
        return user.Fullname.split(' ')
            .map((word) => word.isNotEmpty ? word[0] : '')
            .join('')
            .toUpperCase();
      } else {
        return user.Fullname.substring(0, 1).toUpperCase();
      }
    } else {
      return 'QD';
    }
  }

  Widget buildProfileView(User user) {
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
                        border: Border.all(),
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        getAvatarText(user),
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
                        user.Fullname,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        user.Email,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Color.fromRGBO(128, 128, 128, 1),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            ProfileItem(
              mywidget: OrderScreen(id: 1),
              title: "Đơn hàng của tôi",
              detail: "Bạn có ${OrderPresenter.lstOrder.length} đơn hàng",
            ),
            ProfileItem(
              mywidget: EditAddressScreen(id: user.ID),
              title: "Địa chỉ giao hàng",
              detail: "Bạn có 3 địa chỉ",
            ),
            ProfileItem(
              mywidget: PayMethodScreen(),
              title: "Thanh toán",
              detail: "Bạn có 1 hình thức thanh toán",
            ),
            ProfileItem(
              mywidget: SettingScreen(
                user: user,
                id: user.ID,
              ),
              title: "Cài đặt",
              detail: "Thông báo, đổi mật khẩu, liên hệ",
            ),
            Container(
                margin: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                width: MediaQuery.of(context).size.width,
                child: OutlinedButton(
                  onPressed: () async {
                    Stored.saveText("UserID", 0);
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ));
                  },
                  style: ButtonStyle(
                      padding: MaterialStatePropertyAll(
                          EdgeInsets.fromLTRB(0, 15, 0, 15)),
                      backgroundColor:
                          const MaterialStatePropertyAll(Colors.black),
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)))),
                  child: Text(
                    "Đăng xuất",
                    style: TextStyle(color: Colors.white),
                  ),
                ))
          ],
        ),
      ),
    );
  }

  @override
  void displayMessage(String message) {
    // TODO: implement displayMessage
  }
}
