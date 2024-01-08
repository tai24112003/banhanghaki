import 'package:bangiayhaki/presenters/ItemManage.dart';
import 'package:flutter/material.dart';

class ListChairManager extends StatefulWidget {
  const ListChairManager({super.key});

  @override
  State<ListChairManager> createState() => _ListChairManagerState();
}

class _ListChairManagerState extends State<ListChairManager> {
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
