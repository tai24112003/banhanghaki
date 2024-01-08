import 'package:bangiayhaki/components/NotiItem.dart';
import 'package:bangiayhaki/presenters/BottomBarCustom.dart';
import 'package:flutter/material.dart';

class NotiScreen extends StatefulWidget {
  const NotiScreen({super.key});

  @override
  State<NotiScreen> createState() => _NotiScreenState();
}

class _NotiScreenState extends State<NotiScreen> {
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
          )),
      body: SingleChildScrollView(
        child: Column(
          children: [NotiItem()],
        ),
      ),
      bottomNavigationBar: BottomBarCustom(active: 1),
    );
  }
}
