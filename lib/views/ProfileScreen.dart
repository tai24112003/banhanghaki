import 'package:bangiayhaki/components/ProfileItem.dart';
import 'package:bangiayhaki/models/UserModel.dart';
import 'package:bangiayhaki/presenters/OrderPresenter.dart';
import 'package:bangiayhaki/presenters/UserPresenter.dart';
import 'package:bangiayhaki/views/CheckoutScreen.dart';
import 'package:bangiayhaki/views/EditAddressScreen.dart';
import 'package:bangiayhaki/views/OrderScreen.dart';
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
    if (user.Fullname.contains(' ')) {
      return user.Fullname.split(' ').map((word) => word[0]).join('');
    } else if (user.Fullname.isNotEmpty) {
      return user.Fullname.substring(0, 1).toString().toUpperCase();
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
              mywidget: CheckoutScreen(id: 1),
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
