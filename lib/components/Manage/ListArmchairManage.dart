import 'package:bangiayhaki/components/ItemManage.dart';
import 'package:flutter/material.dart';

class ListArmchairManager extends StatefulWidget {
  const ListArmchairManager({super.key});

  @override
  State<ListArmchairManager> createState() => _ListArmchairManagerState();
}

class _ListArmchairManagerState extends State<ListArmchairManager> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Column(
          children: [ItemManage(), ItemManage(), ItemManage(), ItemManage()],
        )
      ],
    );
  }
}
