import 'package:bangiayhaki/components/item.dart';
import 'package:flutter/material.dart';

class ListArmchair extends StatefulWidget {
  const ListArmchair({super.key});

  @override
  State<ListArmchair> createState() => _ListArmchairState();
}

class _ListArmchairState extends State<ListArmchair> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Row(
          children: [Item(), Item()],
        ),
        Row(
          children: [Item(), Item()],
        )
      ],
    );
  }
}