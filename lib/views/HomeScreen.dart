import 'package:bangiayhaki/components/TabBarCustom.dart';
import 'package:bangiayhaki/components/BottomBarCustom.dart';
import 'package:bangiayhaki/components/ListArmchair.dart';
import 'package:bangiayhaki/components/ListBed.dart';
import 'package:bangiayhaki/components/ListChari.dart';
import 'package:bangiayhaki/components/ListLamp.dart';
import 'package:bangiayhaki/components/ListTable.dart';
import 'package:bangiayhaki/views/ChatScreen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.user});
  final user;
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
              preferredSize: const Size.fromHeight(
                  130), // Tính kích thước tối ưu cho AppBar và TabBar
              child: Column(
                children: [
                  AppBar(
                      leading: IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: () {},
                      ),
                      backgroundColor: Colors.transparent,
                      title: Container(
                        width: MediaQuery.of(context).size.width,
                        child: const Text(
                          "Make Home Beautiful",
                          textAlign: TextAlign.center,
                        ),
                      )),
                  const TabbarCustom()
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
              backgroundColor: const Color.fromARGB(255, 255, 255, 255),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ChatScreen()),
                );
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50), // Độ bo góc là 8.0
              ),
              child: const CircleAvatar(
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
