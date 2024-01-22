import 'package:bangiayhaki/components/MyAppBar.dart';
import 'package:bangiayhaki/models/UserModel.dart';
import 'package:flutter/material.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({required this.user, super.key,required this.id});
  final User user;final int id;
  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  //Khuyenmai
  bool switchValue = false;
  //hangmoive
  bool switchValue2 = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  PreferredSize(
        child: MyAppBar(
          title: "Cài đặt chung",
          UserId: widget.id,
        ),
        preferredSize: Size.fromHeight(100),
      ),
      body: Container(
        margin: const EdgeInsets.all(15),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        child: Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Thông tin cá nhân",
                  style: TextStyle(color: Colors.grey, fontSize: 20),
                ),
                Icon(
                  Icons.edit,
                  size: 25,
                  color: Colors.grey,
                )
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4)),
                shadows: [
                  const BoxShadow(
                    color: Color(0x338A959E),
                    blurRadius: 40,
                    offset: Offset(0, 2),
                    spreadRadius: 0,
                  )
                ],
              ),
              child: TextField(
                controller: TextEditingController(text: "Quân đặng"),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white.withOpacity(1),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: const BorderSide(color: Colors.transparent),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: const BorderSide(color: Colors.transparent),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: const BorderSide(color: Colors.transparent),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: const BorderSide(color: Colors.transparent),
                  ),
                  label: const Text(
                    "Tên",
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4)),
                shadows: [
                  const BoxShadow(
                    color: Color(0x338A959E),
                    blurRadius: 40,
                    offset: Offset(0, 2),
                    spreadRadius: 0,
                  )
                ],
              ),
              child: TextField(
                controller:
                    TextEditingController(text: "quandang377@gmail.com"),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white.withOpacity(1),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: const BorderSide(color: Colors.transparent),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: const BorderSide(color: Colors.transparent),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: const BorderSide(color: Colors.transparent),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: const BorderSide(color: Colors.transparent),
                  ),
                  label: const Text(
                    "Email",
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Mật khẩu",
                    style: TextStyle(color: Colors.grey, fontSize: 20),
                  ),
                  Icon(
                    Icons.edit,
                    size: 25,
                    color: Colors.grey,
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4)),
                shadows: [
                  const BoxShadow(
                    color: Color(0x338A959E),
                    blurRadius: 40,
                    offset: Offset(0, 2),
                    spreadRadius: 0,
                  )
                ],
              ),
              child: TextField(
                controller: TextEditingController(text: "**********"),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white.withOpacity(1),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: const BorderSide(color: Colors.transparent),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: const BorderSide(color: Colors.transparent),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: const BorderSide(color: Colors.transparent),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: const BorderSide(color: Colors.transparent),
                  ),
                  label: const Text(
                    "Mật khẩu",
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ),
                ),
                obscureText: true,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Thông báo",
                    style: TextStyle(color: Colors.grey, fontSize: 20),
                  ),
                  Icon(
                    Icons.edit,
                    size: 25,
                    color: Colors.grey,
                  )
                ],
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 15, 0, 15),
              alignment: Alignment.center,
              width: 350,
              height: 54,
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4)),
                shadows: [
                  const BoxShadow(
                    color: Color(0x338A959E),
                    blurRadius: 40,
                    offset: Offset(0, 2),
                    spreadRadius: 0,
                  )
                ],
              ),
              child: SwitchListTile(
                title: const Text(
                  "Khuyến mãi",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                value: switchValue,
                onChanged: (value) {
                  setState(() {
                    switchValue = value;
                  });
                },
                activeColor: Colors.blue,
                inactiveThumbColor: Colors.grey,
                controlAffinity: ListTileControlAffinity.trailing,
              ),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 15, 0, 15),
              alignment: Alignment.center,
              width: 350,
              height: 54,
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4)),
                shadows: [
                  const BoxShadow(
                    color: Color(0x338A959E),
                    blurRadius: 40,
                    offset: Offset(0, 2),
                    spreadRadius: 0,
                  )
                ],
              ),
              child: SwitchListTile(
                title: const Text(
                  "Hàng mới về",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                value: switchValue2,
                onChanged: (value) {
                  setState(() {
                    switchValue2 = value;
                  });
                },
                activeColor: Colors.blue,
                inactiveThumbColor: Colors.grey,
                controlAffinity: ListTileControlAffinity.trailing,
              ),
            )
          ],
        ),
      ),
    );
  }
}
