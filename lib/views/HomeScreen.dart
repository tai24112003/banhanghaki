import 'package:bangiayhaki/presenters/BottomBarCustom.dart';
import 'package:bangiayhaki/presenters/TabBarCustom.dart';
import 'package:bangiayhaki/presenters/ListArmchair.dart';
import 'package:bangiayhaki/presenters/ListBed.dart';
import 'package:bangiayhaki/presenters/ListChari.dart';
import 'package:bangiayhaki/presenters/ListLamp.dart';
import 'package:bangiayhaki/presenters/ListTable.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 5, // Số lượng tab
        child: Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(
                  130), // Tính kích thước tối ưu cho AppBar và TabBar
              child: Column(
                children: [
                  AppBar(
                    title: Text('Make Home Beautiful'),
                  ),
                  TabbarCustom()
                ],
              ),
            ),
            body: const TabBarView(children: [
              // Nội dung cho tab 1
              ListChair(),
              // Nội dung cho tab 2
              ListTable(),
              // Nội dung cho tab 3
              ListArmchair(),
              // Nội dung cho tab 4
              ListBed(),
              // Nội dung cho tab 5
              ListLamp()
            ]),
            floatingActionButton: FloatingActionButton(
              backgroundColor: Color.fromARGB(255, 255, 255, 255),
              onPressed: () {
                // Xử lý sự kiện khi nút thứ nhất được nhấn
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50), // Độ bo góc là 8.0
              ),
              child: CircleAvatar(
                backgroundImage: AssetImage("assets/message.JPG"),
              ),
              elevation: 0,
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.endDocked,
            bottomNavigationBar: BottomBarCustom(
              active: 0,
            )));
  }
}
