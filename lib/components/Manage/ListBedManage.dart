import 'package:bangiayhaki/components/ItemManage.dart';
import 'package:flutter/material.dart';

class ListBedManager extends StatefulWidget {
  const ListBedManager({super.key});

  @override
  State<ListBedManager> createState() => _ListBedManagerState();
}

class _ListBedManagerState extends State<ListBedManager> {
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
