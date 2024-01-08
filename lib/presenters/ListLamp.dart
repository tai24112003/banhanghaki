import 'package:flutter/material.dart';
import '../presenters/item.dart';

class ListLamp extends StatefulWidget {
  const ListLamp({super.key});

  @override
  State<ListLamp> createState() => _ListLampState();
}

class _ListLampState extends State<ListLamp> {
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
