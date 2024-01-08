import 'package:bangiayhaki/presenters/ItemManage.dart';
import 'package:flutter/material.dart';

class ListLampManager extends StatefulWidget {
  const ListLampManager({super.key});

  @override
  State<ListLampManager> createState() => _ListLampManagerState();
}

class _ListLampManagerState extends State<ListLampManager> {
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
