import 'package:bangiayhaki/components/MyAppBar.dart';
import 'package:bangiayhaki/components/NotiItem.dart';
import 'package:bangiayhaki/components/BottomBarCustom.dart';
import 'package:bangiayhaki/models/UserModel.dart';
import 'package:flutter/material.dart';

class NotiScreen extends StatefulWidget {
  const NotiScreen({required this.userId, super.key});
  final int userId;
  @override
  State<NotiScreen> createState() => _NotiScreenState();
}

class _NotiScreenState extends State<NotiScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        child: MyAppBar(title: "Thông báo", UserId: widget.userId),
        preferredSize: const Size.fromHeight(
            100), // Tính kích thước tối ưu cho AppBar và TabBar
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [NotiItem()],
        ),
      ),
      // bottomNavigationBar: BottomBarCustom(active: 1, userid: widget.user.ID),
    );
  }
}
