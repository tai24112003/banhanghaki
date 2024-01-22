import 'package:bangiayhaki/components/MyAppBar.dart';
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
  const HomeScreen({Key? key, required this.id});

  final int id;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(170),
          child: Column(
            children: [
               Expanded(child: MyAppBar(title: "MAKE HOME BEAUTIFUL",UserId: widget.id)), 
               
              TabbarCustom(),
            ],
          ),
        ),
        body:Column(
          children: [
            Expanded(
              child:  TabBarView(
          children: [
            ListChair(),
            const ListTable(),
            const ListArmchair(),
            const ListBed(),
            const ListLamp(),]))
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
                borderRadius: BorderRadius.circular(50),
              ),
              child: const CircleAvatar(
                backgroundImage: AssetImage("assets/message.JPG"),
              ),
              elevation: 0,
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.endDocked,
            bottomNavigationBar: BottomBarCustom(
              userid: widget.id,
              active: 0,
            )));
  }

  Widget buildGridList(Widget child) {
    return GridView.count(
      crossAxisCount: 2, // Number of columns in the grid
      childAspectRatio:
          0.7, // Adjust this value to control the aspect ratio of grid items
      children: [
        child,
      ],
    );
  }
}
