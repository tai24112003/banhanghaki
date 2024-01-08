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
      body: Center(
        child: Text("Notifications"),
      ),
      bottomNavigationBar: BottomBarCustom(active: 1),
    );
  }
}
