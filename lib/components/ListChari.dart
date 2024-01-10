import 'package:bangiayhaki/components/item.dart';
import 'package:flutter/material.dart';

class ListChair extends StatefulWidget {
  const ListChair({super.key});

  @override
  State<ListChair> createState() => _ListChairState();
}

class _ListChairState extends State<ListChair> {
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
