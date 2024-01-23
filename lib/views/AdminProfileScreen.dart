import 'package:bangiayhaki/components/BottomBarCustom.dart';
import 'package:bangiayhaki/components/ProfileItem.dart';
import 'package:bangiayhaki/models/OrderModel.dart';
import 'package:bangiayhaki/models/UserModel.dart';
import 'package:bangiayhaki/presenters/OrderPresenter.dart';
import 'package:bangiayhaki/presenters/StoreLocal.dart';
import 'package:bangiayhaki/presenters/UserPresenter.dart';
import 'package:bangiayhaki/views/AccountManageScreen.dart';
import 'package:bangiayhaki/views/CheckoutScreen.dart';
import 'package:bangiayhaki/views/CofirmOrderScreen.dart';
import 'package:bangiayhaki/views/EditAddressScreen.dart';
import 'package:bangiayhaki/views/LoginScreen.dart';
import 'package:bangiayhaki/views/OrderScreen.dart';
import 'package:bangiayhaki/views/ProductsManageScreen.dart';
import 'package:bangiayhaki/views/SettingScreen.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class AdminProfileScreen extends StatefulWidget {
  const AdminProfileScreen({required this.id, super.key});
  final int id;

  @override
  State<AdminProfileScreen> createState() => _AdminProfileScreenState();
}

class _AdminProfileScreenState extends State<AdminProfileScreen>
    implements UserView {
  late UserPresenter userPresenter;
  late Future<User?> userFuture;
  late String Fullname;
  late String Email;
  @override
  initState() {
    super.initState();
    userPresenter = UserPresenter(this);
    userFuture = loadUser();
    loadUser().then((value) {
      savedata("FullName", value!.Fullname);
      savedata("Email", value.Email);
    });

    setState(() {
      loadingdata();
    });
  }

  Future<bool> isWifiConnected() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult == ConnectivityResult.wifi;
  }

  loadingdata() async {
    Fullname = await Stored.loadStoredText("FullName");
    Email = await Stored.loadStoredText("Email");
  }

  Future<User?> loadUser() async {
    OrderPresenter.loadData(widget.id);
    if (await isWifiConnected()) {
      return userPresenter.getUserById(widget.id);
    }
    return User(
        ID: widget.id,
        Fullname: Fullname,
        Email: Email,
        DVToken: '',
        Phone: '',
        address: '',
        Password: '',
        Status: '');
  }

  void savedata(String a, String b) {
    Stored.saveText(a, b);
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
      bottomNavigationBar: BottomBarCustom(userid: widget.id, active: 2),
    );
  }

  String getAvatarText(User user) {
    print(Fullname);
    if (Fullname.isNotEmpty) {
      if (Fullname.contains(' ')) {
        return Fullname.split(' ')
            .map((word) => word.isNotEmpty ? word[0] : '')
            .join('')
            .toUpperCase();
      } else {
        return Fullname.substring(0, 1).toUpperCase();
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
                        Fullname,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        Email,
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
              mywidget: ConfirmOrderScreen(),
              title: "Đơn hàng cần xác nhận",
              detail: "",
            ),
            ProfileItem(
              mywidget: AccoutManageScreen(),
              title: "Khách hàng",
              detail: "",
            ),
            ProfileItem(
              mywidget: ProductsManageScreen(
                idUser: widget.id,
              ),
              title: "Sản phẩm",
              detail: "",
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
