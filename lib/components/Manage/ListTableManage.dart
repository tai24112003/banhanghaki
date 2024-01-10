import 'package:bangiayhaki/components/ItemManage.dart';
import 'package:flutter/material.dart';

class ListTableManager extends StatefulWidget {
  const ListTableManager({super.key});

  @override
  State<ListTableManager> createState() => _ListTableManagerState();
}

class _ListTableManagerState extends State<ListTableManager> {
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
